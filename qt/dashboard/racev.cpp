#include <iostream>
#include <algorithm>
#include <string>

#include <QQmlApplicationEngine>
#include <QFile>
#include <QDebug>
#include <QCanBusFrame>
#include <QVector>
#include <QHash>
#include <QSettings>
#include <QQmlProperty>

#include "info.h"
#include "worker.h"
#if defined ( MONGO_THREAD_ )
#include "mongo/mongo.h"
#endif

#include "can/frameparser.h"
#include "can/viob_can06/Can06Thread.h"
#include "can/handlers.h"
#include "parameters/contactmodel.h"
#include "parameters/alarm.h"

#include "gps/gpsthread.h"
#include "gps/gpswrapper.h"

#include "racev.h"

///
/// \brief Racev::Racev
///
/// HMI context
///
Racev::Racev():
    m_pInfo(nullptr),
    m_CANBusReceiverThreadPriority(QThread::NormalPriority),
#if defined ( NEXCOM_CAN06_THREAD_ )
    m_CANBusPort2Name("/dev/ttyUSB0"),
    // ( https://tinyurl.com/yywv5cv9 )
    m_CANBusPort2Info("ttyUSB0"),
    m_pCAN06Thread(nullptr),
    m_CAN06ThreadPriority(QThread::NormalPriority),
#endif
//    m_CANBusReceiverThreadPriority(QThread::HighPriority),
//    m_CANBusReceiverThreadPriority(QThread::HighestPriority),
//    m_CANBusReceiverThreadPriority(QThread::TimeCriticalPriority),
// TODO: threads
#if defined ( CLOCK_THREAD_ )
    pClockThread(nullptr),
    m_ClockThreadPriority(QThread::NormalPriority),
    m_iTicks2Sec(0),
    m_iTicks5Sec(0),
    m_iTicks10Sec(0),
    m_iTicks20Sec(0),
    m_iTicks30Sec(0),
    m_iTicks60Sec(0),
#endif
#if defined ( GPS_THREAD_ )
    m_pGPSThread(nullptr),
    m_GPSThreadPriority(QThread::LowestPriority),
#endif
    m_pFrameParser(nullptr),
    m_pFrameParserViobCan06(nullptr),
    m_pWinMain(nullptr), m_pWinDeploy(nullptr),
    m_pWinChart(nullptr), m_selectPack("A"), m_indexPack(0),
    m_pWinCharging(nullptr),
    m_pWinTpms(nullptr),
    m_pWinUnlock(nullptr),
    // m_pWinEngineering(nullptr),
    m_pWinDiagnose(nullptr),
    m_pWinVehicle(nullptr),
    m_pWinTraction(nullptr),
    m_pWinBrake(nullptr),
    m_pWinSteering(nullptr),
    m_pWinPcuAnalog(nullptr),
    m_pWinBcuAnalog(nullptr),
    m_pWinVcuAnalog(nullptr),
    m_pWinBmsAnalog(nullptr),

    m_pWinPcuDigital(nullptr),
    m_pWinBcuDigital(nullptr),
    m_pWinVcuDigital(nullptr),
    m_pWinBmsDigital(nullptr),

    m_pWinDcdc(nullptr),
    m_pWinIconDesc(nullptr),
    m_pWinHistory(nullptr),
    m_pWinAlarmRecord(nullptr),
    m_pWinAlarmStatistics(nullptr),
    m_pWinSystemLog(nullptr),
    m_pWinCellAlarmRecord(nullptr),
    m_pWinVehicleInformationRecord(nullptr),
    m_pWinChargeTrippedRecord(nullptr),
    m_pWinParameters(nullptr),
    m_pWinGeneralParameters(nullptr),
    m_pWinChargeParameters(nullptr),
    m_pWinAlarmParameters(nullptr),
    m_pWinHmiParameters(nullptr),
    m_pWinTyreParameters(nullptr),
    m_pWinLogOn(nullptr),
    m_pWinBoot(nullptr),
    m_iStartUpTimeStamp(0),
    m_pVCU_HMI_MSG01(nullptr),
    m_pVCU_HMI_MSG02(nullptr),
    m_pVCU_HMI_MSG03(nullptr),
    // m_pVCU_HMI_MSG04(nullptr),
    m_pBMS_VCU_MSG01(nullptr),
    m_pBMS_VCU_MSG02(nullptr),
    m_pBMS_VCU_MSG03(nullptr),
    m_pBMS_VCU_MSG04(nullptr),
    m_pBMS_CMUERR_MSG01(nullptr),
    m_pBMS_OBC_MSG01(nullptr),
    m_pVCU_IOSIG_MSG(nullptr),
    m_pVCU_PWR_STATUS(nullptr),
    m_pPCU_IO_SIG00(nullptr),
    m_pPCU_ST_SYS_1(nullptr),
    m_pPCU_ST_SYS_2(nullptr),
    m_pPCU_ST_SYS_3(nullptr),
    m_pPCU_ST_SYS_4(nullptr),
    m_pPCU_ST_MOT_1(nullptr),
    m_pPCU_ST_MOT_2(nullptr),
    m_pPCU_ST_MOT_3(nullptr),
    m_pPCU_CMD_SYS_1(nullptr),
    m_pPCU_CMD_MOT_1(nullptr),
    m_pPCU_CMD_MOT_2(nullptr),
    m_pPCU_CMD_MOT_3(nullptr),
    m_pVCU_DIAG01(nullptr),
    m_pVCU_DIAG02(nullptr),
    m_pBCU_VCU_MSG0(nullptr),
    m_pBCU_VCU_SMD(nullptr),
    m_pBCU_ER_MSG01(nullptr),
    m_pDCDC_MSG00(nullptr),
    m_pTPMS_MSG01(nullptr),
    m_pTPMS_MSG02(nullptr),
    m_pALM_MSG_00(nullptr),
    m_pALM_MSG_01(nullptr),
    m_pALM_MSG_02(nullptr),
    m_pALM_MSG_03(nullptr),
    m_unlockBits(0),
    m_pAlarmParametersTableView(nullptr),
    m_pAlarmParameters(nullptr),
    m_HmiWakeUp(0)
#if defined ( GPS_THREAD_ )
    ,m_pUART3(nullptr),
    m_UART3Name("/dev/ttyS3"),
    m_UART3Info("ttyS3"),
    m_pGPS(nullptr)
#endif
#if defined ( EN_CONFIG_ )
#if 0
    // FIXME: @see https://tinyurl.com/yxgma9wc
    ,m_arguments {
	0, 0,
	"/home/racev/dashboard.d/dashboard.cfg",
	"/home/racev/dashboard.d/output.csv",
	"/home/racev/IMEI.cfg",
	"/home/racev/dashboard.d/alarm_en_20190102.txt"
    }
#endif
    ,m_Locale("zh_TW.utf8")
#endif
    ,m_bIsLogOn(false),
    m_pActiveWindow(nullptr)
{
    //Mongo* m_pMongo = new Mongo();
    //Info* m_pInfo = new Info();
#if defined ( QT_DEBUG )
    cout << __func__ <<":"<< __LINE__ << "+" << endl;
#endif

#if defined ( EN_MONGO_ )
    m_pMongo->connectPool();
#endif

#if defined ( EN_CONFIG_ )
    // Default values.
    m_arguments.silent = 0;
    m_arguments.verbose = 0;
    m_arguments.config_file = "/home/racev/dashboard.d/dashboard.cfg";
    m_arguments.output_file = "/home/racev/dashboard.d/output.csv";
    m_arguments.imei_file = "/home/racev/IMEI.cfg";
    QSettings mySettings(QString(m_arguments.config_file),
	QSettings::NativeFormat);
    m_Locale = mySettings.value("LOCALE", "zh_TW.utf8").toString();
    if ( m_Locale == "zh_TW.utf8" )
	m_arguments.alarm_parameter_file
	    = "/home/racev/dashboard.d/alarm_tw_20190102.txt";
    else if ( m_Locale == "zh_CN.utf8" )
	m_arguments.alarm_parameter_file
	    = "/home/racev/dashboard.d/alarm_cn_20190102.txt";
    else if ( m_Locale == "en_US.utf8" )
	m_arguments.alarm_parameter_file
	    = "/home/racev/dashboard.d/alarm_en_20190102.txt";
    else
	cout << __func__ <<":"<< __LINE__
	    << " locale: " << m_Locale.toStdString() << endl;
#if 0
    cout << __func__ <<":"<< __LINE__
	<< " locale: " << m_Locale.toStdString() << " "
	<< " apfile: " << m_arguments.alarm_parameter_file
	<< endl;
#endif
#endif
    //m_stream(&m_file);
    m_pInfo = new Info();
    // any difference in with or without parentheses in 'new statement'?
    // Let's get pedantic, because there are differences that can actually affect your code's behavior.
    // @see https://tinyurl.com/y5o7hwww
    m_pFrameParser = new FrameParser(this);
    m_pFrameParserViobCan06 = new FrameParserViobCan06(this);
    m_CANBusCircularBufferHead = 0;
    m_CANBusCircularBufferTail = 0;
    m_pVCU_HMI_MSG01 = new Handler_VCU_HMI_MSG01(this);
    m_pVCU_HMI_MSG02 = new Handler_VCU_HMI_MSG02(this);
    m_pVCU_HMI_MSG03 = new Handler_VCU_HMI_MSG03(this);
    // m_pVCU_HMI_MSG04 = new Handler_VCU_HMI_MSG04(this);
    m_pBMS_VCU_MSG01 = new Handler_BMS_VCU_MSG01(this);
    m_pBMS_VCU_MSG02 = new Handler_BMS_VCU_MSG02(this);
    m_pBMS_VCU_MSG03 = new Handler_BMS_VCU_MSG03(this);
    m_pBMS_VCU_MSG04 = new Handler_BMS_VCU_MSG04(this);
    m_pBMS_CMUERR_MSG01 = new Handler_BMS_CMUERR_MSG01(this);
    m_pBMS_OBC_MSG01 = new Handler_BMS_OBC_MSG01(this);
    m_pVCU_IOSIG_MSG = new Handler_VCU_IOSIG_MSG(this);
    m_pVCU_PWR_STATUS = new Handler_VCU_PWR_STATUS(this);
    m_pPCU_IO_SIG00 = new Handler_PCU_IO_SIG00(this);
    m_pPCU_ST_SYS_1 = new Handler_PCU_ST_SYS_1(this);
    m_pPCU_ST_SYS_2 = new Handler_PCU_ST_SYS_2(this);
    m_pPCU_ST_SYS_3 = new Handler_PCU_ST_SYS_3(this);
    m_pPCU_ST_SYS_4 = new Handler_PCU_ST_SYS_4(this);
    m_pPCU_ST_MOT_1 = new Handler_PCU_ST_MOT_1(this);
    m_pPCU_ST_MOT_2 = new Handler_PCU_ST_MOT_2(this);
    m_pPCU_ST_MOT_3 = new Handler_PCU_ST_MOT_3(this);
    m_pPCU_CMD_SYS_1 = new Handler_PCU_CMD_SYS_1(this);
    m_pPCU_CMD_MOT_1 = new Handler_PCU_CMD_MOT_1(this);
    m_pPCU_CMD_MOT_2 = new Handler_PCU_CMD_MOT_2(this);
    m_pPCU_CMD_MOT_3 = new Handler_PCU_CMD_MOT_3(this);
    m_pVCU_DIAG01 = new Handler_VCU_DIAG01(this);
    m_pVCU_DIAG02 = new Handler_VCU_DIAG02(this);
    m_pBCU_VCU_MSG0 = new Handler_BCU_VCU_MSG0(this);
    m_pBCU_VCU_SMD = new Handler_BCU_VCU_SMD(this);
    m_pBCU_ER_MSG01 = new Handler_BCU_ER_MSG01(this);
    m_pDCDC_MSG00 = new Handler_DCDC_MSG00(this);
    m_pTPMS_MSG01 = new Handler_TPMS_MSG01(this);
    m_pTPMS_MSG02 = new Handler_TPMS_MSG02(this);
    m_pALM_MSG_00 = new Handler_ALM_MSG00(this);
    m_pALM_MSG_01 = new Handler_ALM_MSG01(this);
    m_pALM_MSG_02 = new Handler_ALM_MSG02(this);
    m_pALM_MSG_03 = new Handler_ALM_MSG03(this);

    m_pAlarmParameters = new AlarmParameters(this); // TODO: check if the priciple applies if child not type of G_OBJECT
#if defined ( GPS_THREAD_ )
    m_pGPS = new GPSWrapper();
#endif
#if defined ( NEXCOM_CAN06_THREAD_ )
#endif
}


Racev::~Racev()
{
#if defined ( EN_MONGO_ )
    delete m_pMongo; // allowed, no parent reference passed in
#endif
    // When you create a QObject with another object as parent,
    // the object will automatically add itself to the parent's children() list.
    // The parent takes ownership of the object;
    // i.e., it will automatically delete its children in its destructor.
    // See Object Trees & Ownership for more information.
    // @see https://t.ly/7982
    // delete m_pAlarmParameters; // TODO: not type of G_OBJECT. is the principle applied?
#if defined ( NEXCOM_CAN06_THREAD_ )
    m_pCANBusPort2->close();
#endif
#if defined ( GPS_THREAD_ )
    m_pUART3->close();
#endif
    // Regarding Qt, beware that Qt uses a parent child ownership.
    // You should only delete "top" objects (ones that has no "parent" set)
    // Qt will delete all children of a deleted object on its own.
    // @see https://tinyurl.com/y3xm6pp4

    // If your MyClass is not a child of QObject,
    // you’ll have to use the plain C++ way of doing things.
    // @see https://tinyurl.com/yyorxoct
}

//
// obselete
//
int Racev::initialize()
{
#if defined ( EN_MONGO_ )
    //m_pMongo->connect();
    m_pMongo = new Mongo();
#endif
    return 0;
}

int Racev::initialize(QQmlApplicationEngine& engine) {
#if defined ( EN_MONGO_ )
    //m_pMongo->connect();
    m_pMongo = new Mongo();
#endif

#if defined ( EN_DEVELOP_DATA_ )
    //m_pInfo->setupDataVolt();
    //m_pInfo->setupDataTemperature();
#endif

    findChildren(engine);
    getAlarmParameters(engine);
    cout << __FILE__ << ":" << __LINE__ << "-" << endl;
    return 0;
}

#if defined (  NEXCOM_CAN06_THREAD_ )

// packing to Q
void Racev::readCAN06Data() {
    const QByteArray data = m_pCANBusPort2->readAll();
    QCanBusFrame* pframe= nullptr;
    //const QByteArray data = m_CANBusPort2.readLine();
    //
    // QSerialPort readLine() : ( https://to.ly/1zjHW )
    // add ATL1 setting
    // if the user used correct '\n' delimiters,
    // then I do not see any problems at all,
    // just use canReadLine() && readLine().
    // ( https://to.ly/1zjMJ )

    //while ( m_CANBusPort2.canReadLine() ) {
    //	processLine( m_CANBusPort2.readLine() );
    //}

#if 0
    cout << __func__ << ":" << __LINE__ << endl;
#endif
    pframe = &m_CANBusCircularBuffer06[m_CANBusCircularBuffer06Head++];
    if ( static_cast<quint32>(1 - NUM_CANCB06) < m_CANBusCircularBuffer06Head ) {
	m_CANBusCircularBuffer06Head = 0;
    }
    // testing
    m_pFrameParserViobCan06->parse(data);
}

void Racev::writeCAN06Data(const QByteArray &data) {
#if 0
    std::string stdString(data.constData(), data.length());
    cout << typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " [" << stdString << "] " << endl;
#endif
    m_pCANBusPort2->write(data);
    // example: ( https://to.ly/1zjAJ )
    m_pCANBusPort2->waitForBytesWritten(-1);
    // m_CANBusPort2.flush(); // write + flush => NG
#if 0
    qDebug() << __func__ << ":" << __LINE__
	<< QString::fromStdString(data.toStdString());
#endif
}

void Racev::handleCAN06Error(QSerialPort::SerialPortError error) {
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " ! " << error << " "
	<< m_pCANBusPort2->errorString().toStdString() << endl;
#endif
    if ( error == QSerialPort::ResourceError ) {
	if ( m_pCANBusPort2->isOpen() )
	    m_pCANBusPort2->close();
    }
}

int Racev::createCan06Thread(void) {
    // cout << __func__ << ":" << __LINE__ << "+" << endl;
    // works
    //Configuration du port
    // this works
    // m_pCANBusPort2 = new QSerialPort(m_CANBusPort2Info, this);
    // this works
    m_pCANBusPort2 = new QSerialPort(m_CANBusPort2Name, this);
    m_pCANBusPort2->setBaudRate(QSerialPort::Baud115200);
    m_pCANBusPort2->setDataBits(QSerialPort::Data8);
    m_pCANBusPort2->setParity(QSerialPort::NoParity);
    m_pCANBusPort2->setStopBits(QSerialPort::OneStop);
    m_pCANBusPort2->setFlowControl(QSerialPort::NoFlowControl);
    // example: ( https://to.ly/1zj94 )
    //m_pCANBusPort2->setPortName(m_CANBusPort2Name);

    // FIXME: Cannot create children for a parent that is in a different thread.
    // (Parent is QSerialPort, parent's thread is Qthread, current thread is Can06Thread)
    // FIXME: shows "Cannot create children that is in a different thread,
    // Parent is QSerialPort, parent's thread is QThread, current is Can06Thread
    if ( false == m_pCANBusPort2->open(QIODevice::ReadWrite) ) {
	cout << __func__ << ":" << __LINE__
	    << " " << m_pCANBusPort2->errorString().toStdString()
	    << " ( or cable not connected, or portname NG )" << endl;
	goto ERROR_HANDLER;
    }
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " Port Open VOIBCAN06_IMPL_ prio "
	<< QThread::currentThread()->priority()
	<< endl;
#endif
#if 0
	//Default configuration
	qDebug() << "Baud rate:" << m_CANBusPort2.baudRate();
	qDebug() << "Data bits:" << m_CANBusPort2.dataBits();
	qDebug() << "Stop bits:" << m_CANBusPort2.stopBits();
	qDebug() << "Parity:" << m_CANBusPort2.parity();
	qDebug() << "Flow control:" << m_CANBusPort2.flowControl();
	qDebug() << "Read buffer size:" << m_CANBusPort2.readBufferSize();
#endif
    QObject::connect(m_pCANBusPort2, &QSerialPort::errorOccurred,
	    this, &Racev::handleCAN06Error);
    QObject::connect(m_pCANBusPort2, &QSerialPort::readyRead,
	    this, &Racev::readCAN06Data);

    m_pCAN06Thread = new Can06Thread(this);
    m_pCAN06Thread->start(m_CAN06ThreadPriority);
ERROR_HANDLER:
    return 0;
}
#endif

#if defined ( GPS_THREAD_ )
int Racev::createGPSThread(void) {
    //Configuration du port ( this works )
    // m_pUART3 = new QSerialPort(m_UART3Info, this);
    m_pUART3 = new QSerialPort(m_UART3Name, this);
    m_pUART3->setBaudRate(QSerialPort::Baud9600);
    m_pUART3->setDataBits(QSerialPort::Data8);
    m_pUART3->setParity(QSerialPort::NoParity);
    m_pUART3->setStopBits(QSerialPort::OneStop);
    m_pUART3->setFlowControl(QSerialPort::NoFlowControl);
    // example: ( https://to.ly/1zj94 )
    //m_pUART3->setPortName(m_UART3Name);

    // cout << __func__ << ":" << __LINE__ << "+" << endl;
    // FIXME: Cannot create children for a parent that is in a different thread.
    // (Parent is QSerialPort, parent's thread is Qthread, current thread is GPSThread)
    // FIXME: shows "Cannot create children that is in a different thread,
    // Parent is QSerialPort, parent's thread is QThread, current is GPSThread
    if ( false == m_pUART3->open(QIODevice::ReadOnly) ) {
	cout << typeid(*this).name() << "::"
	    << __func__ << ":" << __LINE__ << " ! "
	    << m_pUART3->errorString().toStdString()
	    << " ( or cable not connected, or portname NG )" << endl;
	goto ERROR_HANDLER;
    }
#if defined ( QT_DEBUG )
    cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__
	<< " Port opened [" << m_pUART3->portName().toStdString() << "]"
	// << " gps thread prio " << QThread::currentThread()->priority()
	<< endl;
#endif
#if 0
	//Default configuration
	qDebug() << "Baud rate:" << m_pUART3->baudRate();
	qDebug() << "Data bits:" << m_pUART3->dataBits();
	qDebug() << "Stop bits:" << m_pUART3->stopBits();
	qDebug() << "Parity:" << m_pUART3->parity();
	qDebug() << "Flow control:" << m_pUART3->flowControl();
	qDebug() << "Read buffer size:" << m_pUART3->readBufferSize();
#endif
#if 1
    QObject::connect(m_pUART3, &QSerialPort::errorOccurred,
	    this, &Racev::handleGPSError);
    QObject::connect(m_pUART3, &QSerialPort::readyRead,
	    this, &Racev::readGPSData);
#endif
    m_pGPSThread = new GPSThread(this);
    m_pGPSThread->start(m_GPSThreadPriority);
ERROR_HANDLER:
    cout << typeid(*this).name() << "::" << __FILE__ << ":" << __LINE__
	<< " - " << endl;
    return 0;
}

void Racev::handleGPSError(QSerialPort::SerialPortError error) {
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " ! " << error << " "
	<< m_pUART3->errorString().toStdString() << endl;
#endif
    if ( error == QSerialPort::ResourceError ) {
	if ( m_pUART3->isOpen() )
	    m_pUART3->close();
    }
}

/*
 * reading /dev/ttyS3 gps data
 * update QML
 * start to read when ready
 */
void Racev::readGPSData() {
#if 0 // defined ( QT_DEBUG )
    cout << typeid(*this).name()
	<< "::" << __func__ << ":" << __LINE__ << "+" << endl;
#endif
    // const QByteArray data = m_pUART3->readAll();
    // this is where NMEA parser kicks in
    // m_pRacev->m_pFrameParserViobCan06->parse(data);
#if 0
    char sentence[256] = {0};
    int sentence_len = 0;
#endif
    QByteArray read_out;
    std::string str;

    while ( m_pUART3->canReadLine() ) {
	read_out = m_pUART3->readLine();
// #define PRINT_PARSE_LINE_
#if 0
	cout << __FILE__ << ":" << __LINE__ << " "
	    << "[" << read_out.toStdString();
	// there's already a linefeed, no extra endl required
#endif
	// trim \r\n @see https://tinyurl.com/y555hfnv
	str = read_out.toStdString();
	str.erase(std::remove(str.begin(), str.end(), '\n'), str.end());
	str.erase(std::remove(str.begin(), str.end(), '\r'), str.end());
#if 0
	if ( read_out.contains("GLL")
	    || read_out.contains("GGA") ) {
	    cout << __FILE__ << ":" << __LINE__ << " [" << str << "]" << endl;
		// << read_out.toStdString();
	    // there's already a linefeed, no extra endl required
	}
#endif
#if 0
	if ( read_out.contains("$GPGLL") ) {
	    // @see https://tinyurl.com/y59dx7el
	    strncpy(sentence, read_out.toStdString().c_str(), 255);
	    sentence_len = strlen(sentence);
	    cout << __FILE__ << ":" << __LINE__ << endl;
	    m_pGPS->parse(sentence, sentence_len);
	    cout << __FILE__ << ":" << __LINE__ << endl;
	    // m_pGPS->getInfo();
	}
#endif
	if ( read_out.contains("$GNGGA") /*&& m_pGPS && m_pWinDiagnose*/ ) {
	    // m_pGPS->parse(read_out, m_pInfo);
	    m_pGPS->parse(str, m_pInfo);
#if defined ( GPS_THREAD_ )
	    emit signalGPS();
#endif
	}
    }
    // QSerialPort readLine() : ( https://to.ly/1zjHW )
    // add ATL1 setting
    // if the user used correct '\n' delimiters,
    // then I do not see any problems at all,
    // just use canReadLine() && readLine().
    // ( https://to.ly/1zjMJ )
#if 0 // defined ( QT_DEBUG )
    cout << typeid(*this).name()
	<< "::" << __func__ << ":" << __LINE__ << "-" << endl;
#endif
}

#endif

/*
 * connect to those has buttons to click/load windows
 */
void Racev::connectOnLoadSlots(void) {
    // cout << __func__ << ":" << __LINE__ << "+" << endl;
    Worker* pWorker = qobject_cast<Worker*>(pWorkerThread);

    // connecting screen loading notification
    QObject::connect(m_pWinMain, SIGNAL(qmlSignal(QString)),
	pWorker, SLOT(cppSlotRaiseWindow(QString)));
    // QObject::connect(m_pWinEngineering, SIGNAL(qmlSignal(QString)),
// 	pWorker, SLOT(cppSlotRaiseWindow(QString)));
    QObject::connect(m_pWinDeploy, SIGNAL(qmlSignalDeployment(QString, int)),
	pWorker, SLOT(cppSlotDeployment(QString, int)));
    QObject::connect(m_pWinVehicle, SIGNAL(qmlSignal(QString)),
	pWorker, SLOT(cppSlotRaiseWindow(QString)));
    QObject::connect(m_pWinHistory, SIGNAL(qmlSignal(QString)),
	pWorker, SLOT(cppSlotRaiseWindow(QString)));
    QObject::connect(m_pWinParameters, SIGNAL(qmlSignal(QString)),
	pWorker, SLOT(cppSlotRaiseWindow(QString)));
    QObject::connect(m_pWinLogOn, SIGNAL(qmlSignalAuth(QString)),
	pWorker, SLOT(onSignalAuth(QString)));
    QObject::connect(m_pWinLogOn, SIGNAL(qmlSignalTimeout(int)),
	pWorker, SLOT(onSignalSessionTimeout(int)));
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << "-" << endl;
#endif
}

void Racev::connectOnActiveSlots(void) {
    Worker* pWorker = qobject_cast<Worker*>(pWorkerThread);
    // cout << __func__ << ":" << __LINE__ << " +" << endl;
    // window active notification, (signal)N:1(slot)
    QObject::connect(m_pWinMain, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinDeploy, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinChart, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinCharging, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));

    // QObject::connect(m_pWinEngineering, SIGNAL(qmlSignalActive(QString)),
//	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinTraction, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinBrake, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinSteering, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));

    QObject::connect(m_pWinPcuAnalog, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));

    QObject::connect(m_pWinDiagnose, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));

    QObject::connect(m_pWinHistory, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinAlarmRecord, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinAlarmStatistics, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinSystemLog, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinCellAlarmRecord, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinVehicleInformationRecord, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinChargeTrippedRecord, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    //cout << __func__ << ":" << __LINE__ << "*" << endl;
    QObject::connect(m_pWinParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinGeneralParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinChargeParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinAlarmParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinHmiParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinTyreParameters, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinLogOn, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));
    QObject::connect(m_pWinBoot, SIGNAL(qmlSignalActive(QString)),
	pWorker, SLOT(onSignalActive(QString)));

    // cout << __func__ << ":" << __LINE__ << "*" << endl;

    // unlock / release
    QObject::connect(m_pWinUnlock, SIGNAL(qmlSignalUnlock(QString, QString)),
	pWorker, SLOT(onSignalUnlock(QString, QString)));
    // reset
    QObject::connect(m_pWinTraction, SIGNAL(qmlSignalReset(QString)),
	pWorker, SLOT(onSignalReset(QString)));
    QObject::connect(m_pWinBrake, SIGNAL(qmlSignalReset(QString)),
	pWorker, SLOT(onSignalReset(QString)));
    QObject::connect(m_pWinSteering, SIGNAL(qmlSignalReset(QString)),
	pWorker, SLOT(onSignalReset(QString)));
    // tableview click
    QObject::connect(m_pWinAlarmParameters, SIGNAL(checkedChanged(int, int, bool)),
	pWorker, SLOT(onAlarmParameterChecked(int, int, bool)));
    // calibration/zero
    QObject::connect(m_pWinDiagnose, SIGNAL(qmlSignalCalibrate(QString)),
	pWorker, SLOT(onSignalCalibrate(QString)));
    QObject::connect(m_pWinDiagnose, SIGNAL(qmlSignalZero(QString)),
	pWorker, SLOT(onSignalZero(QString)));
#if defined ( GPS_THREAD_ )
    // GPS update to QML
    QObject::connect(this, SIGNAL(signalGPS(void)),
	pWorker, SLOT(onSignalGPS(void)));
#endif
    // cout << __func__ << ":" << __LINE__ << "-" << endl;
}

void Racev::findChildren(QQmlApplicationEngine& engine) {
    // cout << __func__ << ":" << __LINE__ << " +" << endl;
    QObject *root_object = engine.rootObjects().first();
    if ( !root_object ) {
        cout << __func__ << ":" << __LINE__ << " root object!" << endl;
    }
    // Worker* pWorker = qobject_cast<Worker*>(pWorkerThread);

    m_pWinMain = root_object->findChild<QObject*>("hmiroot");
    m_pWinChart = root_object->findChild<QObject*>("chartWindow");
    m_pWinDeploy = root_object->findChild<QObject*>("deploymentWindow");
    m_pWinCharging = root_object->findChild<QObject*>("chargingWindow");
    m_pWinTpms = root_object->findChild<QObject*>("tpmsWindow");
    m_pWinUnlock = root_object->findChild<QObject*>("unlockWindow");
    // m_pWinEngineering = root_object->findChild<QObject*>("engineeringWindow");
    m_pWinDiagnose = root_object->findChild<QObject*>("diagnoseWindow");
    //cout << __func__ << ":" << __LINE__
    //	<< " & " << static_cast<void*>(m_pWinDiagnose) << endl;
    m_pWinVehicle = root_object->findChild<QObject*>("vehicleInfoWindow");
    m_pWinTraction = root_object->findChild<QObject*>("tractionWindow");
    m_pWinBrake = root_object->findChild<QObject*>("brakeWindow");
    m_pWinSteering = root_object->findChild<QObject*>("steeringWindow");

    m_pWinPcuAnalog = root_object->findChild<QObject*>("pcuAnalog");
    m_pWinBcuAnalog = root_object->findChild<QObject*>("bcuAnalogWindow");
    m_pWinVcuAnalog = root_object->findChild<QObject*>("vcuAnalogWindow");
    m_pWinBmsAnalog = root_object->findChild<QObject*>("bmsAnalogWindow");

    m_pWinPcuDigital = root_object->findChild<QObject*>("pcuDigitalWindow");
    m_pWinBcuDigital = root_object->findChild<QObject*>("bcuDigitalWindow");
    m_pWinVcuDigital = root_object->findChild<QObject*>("vcuDigitalWindow");
    m_pWinBmsDigital = root_object->findChild<QObject*>("bmsDigitalWindow");

    m_pWinDcdc = root_object->findChild<QObject*>("dcDcWindow");

    m_pWinIconDesc
	= root_object->findChild<QObject*>("iconDescriptionWindow");
//	<< " & " << static_cast<void*>(m_pWinIconDesc) << endl;

    m_pWinHistory = root_object->findChild<QObject*>("historyWindow");
    m_pWinAlarmRecord = root_object->findChild<QObject*>("alarmRecordWin");
    m_pWinAlarmStatistics = root_object->findChild<QObject*>("alarmStatisticsWin");
    m_pWinSystemLog = root_object->findChild<QObject*>("sysLogWin");
    m_pWinCellAlarmRecord = root_object->findChild<QObject*>("cellAlarmRecWin");
    m_pWinVehicleInformationRecord = root_object->findChild<QObject*>("vehicleInfoRecordWin");
    m_pWinChargeTrippedRecord = root_object->findChild<QObject*>("chargeTrippedRecordWin");

    m_pWinParameters = root_object->findChild<QObject*>("parametersWindow");
    m_pWinGeneralParameters = root_object->findChild<QObject*>("generalWindow");
    m_pWinChargeParameters = root_object->findChild<QObject*>("chargeWindow");
    m_pWinAlarmParameters = root_object->findChild<QObject*>("alarmWindow");
    m_pWinHmiParameters = root_object->findChild<QObject*>("hmiSettingWindow");
    m_pWinTyreParameters = root_object->findChild<QObject*>("tyresWindow");
    m_pWinLogOn = root_object->findChild<QObject*>("logOnWindow");
    m_pWinBoot = root_object->findChild<QObject*>("bootWindow");
    // cout << __FILE__ << ":" << __LINE__ << " #" << endl;
    // TODO:
}

/*
 * from parameter file
 */
int Racev::getAlarmParameters(QQmlApplicationEngine& engine) {
    QString ap_filename = m_arguments.alarm_parameter_file;
    QFile ap_file;
    int num_rows = 0;
    QVariant returnedValue;
    bool ok;

#if 0
    cout << __FILE__ << ":" << __LINE__
	<< " + " << m_arguments.alarm_parameter_file << endl;
#endif
    QObject *root_object = engine.rootObjects().first();
    if ( !root_object ) {
        cout << __func__ << ":" << __LINE__ << " root object!" << endl;
    }
    // Model-View-Delegate Pattern ( https://tinyurl.com/y697kuhc )
    m_pAlarmParametersTableView
	= root_object->findChild<QObject*>("alarmParameterTablewView");
    //access model property of TableView
    QVariant qmlmodel = m_pAlarmParametersTableView->property("model");
    //convert to QAbstractListModel
    QAbstractListModel *model
	= qvariant_cast<QAbstractListModel *>(qmlmodel);

    ap_file.setFileName(ap_filename);
    if ( false == ap_file.open(QIODevice::ReadOnly) ) {
        cout << __FILE__ << ":" << __LINE__
	    << " make sure alarm parameter file is ready!" << endl;
    }
    QTextStream in(&ap_file);
    while ( !in.atEnd() ) {
	QString line = in.readLine();
	// line.toStdString() << endl;
	// note: it's UTF-8 Unicode (with BOM), with CRLF
	// ( https://tinyurl.com/y3gfbgnh )
	QStringList pieces = line.split( "," );
	if ( LEN_ALARM_SEG == pieces.length() ) {
	    // status: qml already completed
	    QMetaObject::invokeMethod(m_pWinAlarmParameters, "addElement",
		//Qt::BlockingQueuedConnection,
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, pieces.at(0)/*idx*/),
		Q_ARG(QVariant, pieces.at(1)/*display*/),
		Q_ARG(QVariant, pieces.at(2)/*record*/),
		Q_ARG(QVariant, 0/*pieces.at(3)beeps*/), // TODO:
		Q_ARG(QVariant, pieces.at(3)/*voice*/),
		Q_ARG(QVariant, pieces.at(4)/*content*/));
#if 1 // FIXME: find out why marking this makes crashing
	    m_pAlarmParameters->insert(
		pieces.at(0).toUInt(&ok, 10),
		pieces.at(1).toUShort(&ok, 10),
		pieces.at(2).toUShort(&ok, 10),
		0,
		pieces.at(3).toUShort(&ok, 10),
		pieces.at(4).toStdString());
#endif
	    num_rows++;
	}
    }
    ap_file.close();
    //get number of rows from model
    int rows = model->rowCount();
    // ( https://tinyurl.com/y3wkmdnk )
    // model->data(model->index(0, 0), 0);
#if defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " #row " << rows << " num_rows " << num_rows
	<< endl;
#endif
    return rows;
}

// TODO:
bool Racev::setAlarmParameters(void) {
    return true;
}

void Racev::LogOn(bool on) {
    m_bIsLogOn = on;
}

bool Racev::IsLogOn(void) {
    return m_bIsLogOn;
}

bool Racev::isActiveWindow(QObject* pWindow) {
    if ( "true" == QQmlProperty::read(pWindow, "active") )
	return true;
    else return false;
}

void Racev::setActiveWindow(QObject* pWindow) {
    // presume pWindow is not null
#if defined ( _SHOW_ADDR_ )
    cout << __FILE__ << ":" << __LINE__
	<< " w:[" << pWindow << "]"
	<< " p:[" << m_pActiveWindow << "]"
	<< endl;
#endif
    if ( pWindow )
	QQmlProperty::write(pWindow, "visible", "true");
    if ( m_pActiveWindow && ( pWindow != m_pActiveWindow ) )
	QQmlProperty::write(m_pActiveWindow, "visible", "false");
    m_pActiveWindow = pWindow;
}

QObject* Racev::getActiveWindow(void) {
    return m_pActiveWindow;
}
