#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QtQml/QQmlApplicationEngine>
#include <QCanBusFrame>

#include "mongo/mongo.h"
#include "info.h"
#include "racev.h"

#if 1 // TODO: SJA1000_IMPL_
#include "can/sja1000_can.h"
#endif

class Worker : public QObject
{
    Q_OBJECT
public:
    Worker();
    //Worker(QQmlApplicationEngine *pEngine);
    Worker(QQmlApplicationEngine *pEngine, Racev* pRacev);
    //Worker(QObject *pText);
    ~Worker();
    bool isWindowActive(QObject* pWindow);

public slots:
    void doWork(/*const QString &parameter*/);
    void process();
    //void setText(const QString &msg, int cpu_usage, int freemem);
    void quit();
    //void errorString();
    void cppSlotRaiseWindow(const QString &msg);
    void cppSlotDeployment(const QString &msg, int index);
    void updateModel(void);
    void onSignalActive(const QString &msg);
#if 0
    void processReceivedFrames();
    void processErrors(QCanBusDevice::CanBusError) const;
    void processFramesWritten(qint64);
#endif
    void onSignalCANFrame(quint32 can_addr, QCanBusFrame* pframe);
#if 1 // TODO: SJA1000_IMPL_
    void onSignalErrorFrame(uint direction, uint stat, uint rx_err_cnt, uint tx_err_cnt);
#endif
    void onSignalLoadCompleted(const QString &msg); // FIXME: too early to fire
    void onSignalUnlock(const QString &item, const QString &unlock);
    void onSignalReset(const QString &msg);
    void onAlarmParameterChecked(int row, int col, bool checked);
    void onSignalAuth(const QString &msg);
    void onSignalCalibrate(const QString &msg);
    void onSignalZero(const QString &msg);
#if defined ( CLOCK_THREAD_ )
    // cannot queue type uint8_t unless qRegisterMetaType()
    void onSignalTicksSec(unsigned int n_seconds);
    void onTickSlope(void);
    void onSignalAccelerometer(void);
#endif

signals:
    void resultReady(const QString &result);
    void error(QString err);
    void finished();
#if defined ( CLOCK_THREAD_ )
    void signalTickSlope(void);
    void signalAccelerometer(void);
#endif
    void signalLogVehicleInfo(void);

private:
    void updateFramePayloadQSize(QCanBusFrame& frame, int size);
    void updateMainView(QCanBusFrame& frame);

    void updateView(void/*QObject* pDstVw*/);
    void updateDeploymentView(void/*QObject* pDstVw*/);
    void updateChartView(void/*QObject* pDstVw*/);
    void updateChargingView(void);
    void updateDiagnoseView(void);
    void updateEngineeringView(void);
    void updateWindow(QObject *pWindow);

    QCanBusFrame* getFrameFromSlots(quint32 key);
    // TODO: refactor
    void updateMessage_VCU_HMI_Msg_3(QCanBusFrame* pframe);
    void updateMessage_VCU_HMI_Msg_4(QCanBusFrame* pframe);

    //void updateMsg_BMS_Volt_Msg01(QCanBusFrame& frame1, QObject* pDstVw);
    void updateMsg_BMS_Volt_Msg01(int pack/*0-based*/, QObject* pDstVw);
    //void updateMsg_BMS_Temp_Msg01(QCanBusFrame& frame, QObject* pDstVw);
    void updateMsg_BMS_Temp_Msg01(int pack/*0-based*/, QObject* pDstVw);
    void updateMsg_BMS_OCU_Msg01(QCanBusFrame* pframe, QObject* pDstVw);
    QQmlApplicationEngine *p_engine;
    Racev* m_pRacev;
    Info* m_pInfo;
};

#endif // WORKER_H
