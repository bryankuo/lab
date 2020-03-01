#ifndef RACEV_H
#define RACEV_H

#include <argp.h>
#include <syslog.h>

#include <QObject>
#include <QQmlApplicationEngine>
#include <QMutex>
#include <QWaitCondition>
#include <QFile>
#include <QTextStream>
#include <QCanBusFrame>
#include <QQueue>
#include <QVector>
#include <QHash>
#include <QThread>
#include <QSettings>

#include <QSerialPort>
#include <QSerialPortInfo>

#define EN_SYSLOG_
#define NORMAL_SCENARIO_ // normal scenario or show dash

#define CLOCK_THREAD_

// first module CAN RX
#define CAN_THREAD_
// frame source selection
#define SJA1000_IMPL_
//#define SKTCAN_IMPL_
// TODO: there will be 2 independent CANbus threads
//#define _TRACE_HEAD_TAIL_
#define EN_IPC_

// first module CAN TX
#define CAN_TX_THREAD_

#define PARSER_THREAD_
//#define EN_PARSE_ON_RECEIVE_ // at can rx thread
#define EN_PARSER_THREAD_ // at parser thread

//#define EN_INVOKE_METHOD_
#define EN_PUSHING_REF2QML_

// #define MONGO_THREAD_
#if defined ( MONGO_THREAD_ )
#include "mongo/mongo.h"
#endif

#define GPS_THREAD_
#if defined ( GPS_THREAD_ )
#include "gps/gpswrapper.h"
#endif

// TODO:
#define BT_THREAD_
#define CONN_THREAD_

#include "info.h"
#include "can/frameparser.h"
#include "can/viob_can06/fp_can06.h"
#include "can/handlers.h"
#include "parameters/alarm.h"

// #define HISTORY_
#if defined ( HISTORY_ )
#include "history/vehicleinfohandler.h"
#include "history/vehicleinforecord.h"
#include "history/vehicleinfomodel.h"
#include "history/filelistmodel.h"
#include "history/record.h"
#endif

#define MAX_SPEED_ 200
#define CANBUS_UPDATE_ 2 // every 2 seconds
//#define MAX_NUM_SLOTS 6 // ref. info.h


// #define NEXCOM_CAN06_THREAD_ // FIXME: index out of range issue
// #define HANDLERS_ // organize each PGN as a handler class

#define EN_CONFIG_
#define NUM_CMDLINE 3
// use command line parsing ( GNU argp )
// @see https://tinyurl.com/y69mqlsl
// 25.3 Parsing Program Options with Argp
// @see https://tinyurl.com/y9hcqqgt

#define EN_DLIGHT_FLASH_ // TODO:

#ifdef QT_DEBUG
#define DEBUG_LOG(msg) std::cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " : " << msg << std::endl
#else
#define DEBUG_LOG(msg)
#endif

using namespace std;

#if defined ( EN_CONFIG_ )
/* Used by main to communicate with parse_opt. */
struct arguments
{
    char *args[NUM_CMDLINE];                /* arg1 & arg2 */
    int silent, verbose;
    char *output_file;
    char *imei_file;
    char *config_file;
    char *alarm_parameter_file;
};
#endif

//
// application context
//

class Racev : public QObject
{
    Q_OBJECT
public:
    explicit Racev();
    ~Racev();
    int initialize();
    int initialize(QQmlApplicationEngine& engine);
    void connectOnLoadSlots(void);
    void connectOnActiveSlots(void);
    void LogOn(bool on);
    bool IsLogOn(void);
    bool IsEligibleToMenu(void);

    qint64 m_tick;
    mutable QMutex m_mutex;
    mutable QWaitCondition m_cond;
#if defined ( MONGO_THREAD_ )
    Mongo* m_pMongo;
#endif
    Info* m_pInfo;

#if defined ( CAN_THREAD_ )
    QObject *pCANBusReceiverThread;
    QThread::Priority m_CANBusReceiverThreadPriority;
#endif

#if defined ( CAN_TX_THREAD_ )
    QObject *pCANBusSenderThread;
    QThread::Priority m_CANBusSenderThreadPriority;
#endif
    QMutex m_CANDeviceMutex;

#if defined ( NEXCOM_CAN06_THREAD_ )
    QSerialPort* m_pCANBusPort2;
    QString m_CANBusPort2Name;
    QSerialPortInfo m_CANBusPort2Info;
    QThread* m_pCAN06Thread;
    QThread::Priority m_CAN06ThreadPriority;
    int createCan06Thread(void);
public slots:
    void handleCAN06Error(QSerialPort::SerialPortError error);
    void readCAN06Data();
    void writeCAN06Data(const QByteArray &data);
#endif

public:
    QObject *pWorkerThread;
    QThread::Priority m_WorkerThreadPriority; // TODO: init, bookkeeping
#if defined ( CLOCK_THREAD_ )
    QObject *pClockThread; // TODO:
    QThread::Priority m_ClockThreadPriority;
    // data log period
    // unsigned int m_iTicks2Sec;
    // unsigned int m_iTicks5Sec;
    // unsigned int m_iTicks10Sec;
    // unsigned int m_iTicks20Sec;
    // unsigned int m_iTicks30Sec;
    // unsigned int m_iTicks60Sec;
#endif

#if defined ( GPS_THREAD_ )
public:
    QThread* m_pGPSThread;
    QThread::Priority m_GPSThreadPriority;
signals:
    void signalGPS(void);
public slots:
    void handleGPSError(QSerialPort::SerialPortError error);
    void readGPSData();
public:
    QSerialPort* m_pUART3;
    QString m_UART3Name;
    QSerialPortInfo m_UART3Info;
    int createGPSThread(void);
    GPSWrapper* m_pGPS;
#endif

    // Q: synchronization required?
    // A: I'm fairly certain, that QQueue is
    // not explicitly thread save ( https://goo.gl/VLY9kj )
    // Synchronizing Objects in Different Threads in Qt
    // ( https://goo.gl/hDgGHh )

    // How can I return a QList pointer and get no memory leak?
    // Otherwise you need to figure out what object is responsible
    // for releasing the object ( http://tinyw.in/fMUn )
    // QQueue inherits from QList. The QList internal buffer only GROWS.
    // Which means that it will NEVER shrink even if
    // you remove all elements from it.
    // This is a design choice ( https://forum.qt.io/post/143725 )
    // QHash<quint32, QVector<QCanBusFrame*>> m_CANBusFrameBins;
    // TODO: obselete

    // Circular Buffer implementation instead of new/delete pair
    // ( http://tinyw.in/JlVj )
    // Whereas QVector<T> and QList<T> will both grow
    // to accommodate the new items, ( http://tinyw.in/HxOZ )
    // QCircularBuffer<T> will overwrite the oldest items.
#define NUM_CANCB 1000
    // assume 100% bus load
    // @see https://tinyurl.com/vmafdut

    QCanBusFrame m_CANBusCircularBuffer[NUM_CANCB];
    quint32 m_CANBusCircularBufferHead = 0;
    quint32 m_CANBusCircularBufferTail = 0;
#if defined ( EN_IPC_ )
    QMutex m_CANBusFrameQueueMutex; // guarding head/tail access
#endif

    QCanBusFrame m_CANBusFrame; // this is for HMI_TM_MSG01 exclusively

#define NUM_CANCB06 20
    QCanBusFrame m_CANBusCircularBuffer06[NUM_CANCB06];
    quint32 m_CANBusCircularBuffer06Head = 0;
    quint32 m_CANBusCircularBuffer06Tail = 0;

    FrameParser* m_pFrameParser; // multiplextor for SJA1000
#if defined ( PARSER_THREAD_ )
    QThread* pCANParserThread;
    QThread::Priority m_CANParserThreadPriority;
#endif
    FrameParserViobCan06* m_pFrameParserViobCan06; // TODO:

    // window placement
    QObject *m_pRoot; // dashwindow.qml
    QObject *m_pWinMain;
    QObject *m_pWinDeploy;
    QObject *m_pWinChart;
    QString m_selectPack;
    int m_indexPack;
    QObject* m_pWinCharging;
    QObject* m_pWinTpms;
    QObject* m_pWinUnlock;
    QObject* m_pWinDiagnose;
    QObject* m_pWinVehicle;
    QObject* m_pWinTraction;
    QObject* m_pWinBrake;
    QObject* m_pWinSteering;

    QObject* m_pWinPcuAnalog;
    QObject* m_pWinBcuAnalog;
    QObject* m_pWinVcuAnalog;
    QObject* m_pWinBmsAnalog;

    QObject* m_pWinPcuDigital;
    QObject* m_pWinBcuDigital;
    QObject* m_pWinVcuDigital;
    QObject* m_pWinBmsDigital;

    QObject* m_pWinDcdc;

    QObject* m_pWinIconDesc;

    QObject* m_pWinHistory;
    QObject* m_pWinAlarmRecord;
    QObject* m_pWinAlarmStatistics;
    QObject* m_pWinSystemLog;
    QObject* m_pWinCellAlarmRecord;
    QObject* m_pWinVehicleInformationRecord;
    QObject* m_pWinChargeTrippedRecord;

    QObject* m_pWinParameters;
    QObject* m_pWinGeneralParameters;
    QObject* m_pWinChargeParameters;
    QObject* m_pWinAlarmParameters;
    QObject* m_pWinHmiParameters;
    QObject* m_pWinTyreParameters;
    QObject* m_pWinLogOn;
    QObject* m_pWinBoot;
    QObject* m_pModel;
    // to protect sequence of :
    // 1.active 2.frame 3.timely update
    QMutex m_CanvasMutex;

    // application startup timestamp via currentMSecsSinceEpoch()
    qint64 m_iStartUpTimeStamp;

    // address specific handlers
    Handler_VCU_HMI_MSG01* m_pVCU_HMI_MSG01;
    Handler_VCU_HMI_MSG02* m_pVCU_HMI_MSG02;
    Handler_VCU_HMI_MSG03* m_pVCU_HMI_MSG03;
    Handler_VCU_HMI_MSG04* m_pVCU_HMI_MSG04;

    Handler_BMS_VCU_MSG01* m_pBMS_VCU_MSG01;
    Handler_BMS_VCU_MSG02* m_pBMS_VCU_MSG02;
    Handler_BMS_VCU_MSG03* m_pBMS_VCU_MSG03;
    Handler_BMS_VCU_MSG04* m_pBMS_VCU_MSG04;

    Handler_BMS_CMUERR_MSG01* m_pBMS_CMUERR_MSG01;
    Handler_BMS_OBC_MSG01* m_pBMS_OBC_MSG01;
    Handler_VCU_IOSIG_MSG* m_pVCU_IOSIG_MSG;
    Handler_VCU_PWR_STATUS* m_pVCU_PWR_STATUS;

    Handler_PCU_IO_SIG00* m_pPCU_IO_SIG00;
    Handler_PCU_ST_SYS_1* m_pPCU_ST_SYS_1;
    Handler_PCU_ST_SYS_2* m_pPCU_ST_SYS_2;
    Handler_PCU_ST_SYS_3* m_pPCU_ST_SYS_3;
    Handler_PCU_ST_SYS_4* m_pPCU_ST_SYS_4;

    Handler_PCU_ST_MOT_1* m_pPCU_ST_MOT_1;

    Handler_PCU_ST_MOT_2* m_pPCU_ST_MOT_2;
    Handler_PCU_ST_MOT_3* m_pPCU_ST_MOT_3;
    Handler_PCU_CMD_SYS_1* m_pPCU_CMD_SYS_1;
    Handler_PCU_CMD_MOT_1* m_pPCU_CMD_MOT_1;
    Handler_PCU_CMD_MOT_2* m_pPCU_CMD_MOT_2;
    Handler_PCU_CMD_MOT_3* m_pPCU_CMD_MOT_3;

    Handler_VCU_DIAG01* m_pVCU_DIAG01;
    Handler_VCU_DIAG02* m_pVCU_DIAG02;

    Handler_BCU_VCU_MSG0* m_pBCU_VCU_MSG0;
    Handler_BCU_VCU_SMD* m_pBCU_VCU_SMD;
    Handler_BCU_ER_MSG01* m_pBCU_ER_MSG01;

    Handler_DCDC_MSG00* m_pDCDC_MSG00;
    Handler_TPMS_MSG01* m_pTPMS_MSG01;
    Handler_TPMS_MSG02* m_pTPMS_MSG02; // TODO:
    Handler_ALM_MSG00* m_pALM_MSG_00;
    Handler_ALM_MSG01* m_pALM_MSG_01;
    Handler_ALM_MSG02* m_pALM_MSG_02;
    Handler_ALM_MSG03* m_pALM_MSG_03;

    unsigned int i_reset; // TODO: vehicle 'info'

    QObject* m_pAlarmParametersTableView; // TODO: application 'specific'

    // TODO: refactor to info (vehicle related) class
    int getAlarmParameters(QQmlApplicationEngine& engine);
    bool setAlarmParameters(void);
    AlarmParameters* m_pAlarmParameters;

#if defined ( EN_CONFIG_ )
    struct arguments m_arguments;
    QString m_Locale;
#endif

    uint8_t m_HmiWakeUp;
    int num_logon_fail;

    // TODO: create a window manager class
    bool isActiveWindow(QObject* pWindow);
    void setActiveWindow(QObject* pWindow);
    QObject* getActiveWindow(void);
    QObject* getPrevWindow(void);

    bool isReady(void);
    bool m_bIsReady; // to tell controller is ready, then let thread go

    QSettings m_Settings; // TODO: application wide access
    bool isAuthorized(QString group, QString user, QString credential);

#if defined ( HISTORY_ )
    // alarm record
    vehicleInfoModel ARmodel;
    vehicleInfoHandler arHandler;

    // vehicle information record
    vehicleInfoModel model;
    fileListModel fLmodel;
    vehicleInfoHandler veHandler; // (&model);
#endif

    int m_iRole; // 0: admin, 1: user, see constants.h

signals:
    void signalRole(int newRole);

public slots:
    void onSignalEngProg();

private:
    void findChildren(void);
    bool m_bIsLogOn;
    QObject* m_pActiveWindow; // topmost window, active window
    QObject* m_pPrevWindow; // prev window
};

#endif // RACEV_H
