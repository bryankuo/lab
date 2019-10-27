#include <iostream>
#include <stdexcept>
#include <iomanip>
#include <cmath>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <string.h>

#include <QtQml/QQmlContext>
#include <QQmlProperty>
#include <QQuickItem>
#include <QWindow>
#include <QtMath>
#include <QDateTime>
#include <QtAlgorithms>
#include <QDebug>
#include <QProcess>

#include "constants.h"
#include "worker.h"
// extern const quint32 Info::ADDR_VCU_HMI_MSG1;
// 靜態空間變數/全域變數，是接近 evil 的東西 ( http://tinyurl.com/y2xabqck )
// #include "can/viob_can06/Can06Thread.h"
#include "can/canthread.h"

//#define EN_VERBOSE_OUT_
//#define UPDATE_DEPLOYMENT_
//#define TICK_SLOTS_

Worker::Worker()
{
    //qDebug() << "Worker+";
}

Worker::Worker(QQmlApplicationEngine *pEngine, Racev* pRacev):
    p_engine(pEngine),
    m_pRacev(pRacev),
    m_pInfo(pRacev->m_pInfo),
    m_pActiveWindow(nullptr) {
    //qDebug() << "Worker(e,r)+";
    // QByteArray cmd_at_mp_ff92 = "AT MP FF92\r";
}

Worker::~Worker()
{
    cout << "Worker -" << endl;
}

void Worker::process()
{
    // allocate resources using new here
    //qDebug() << "Worker::process ";
    emit finished();
}

void Worker::doWork(/*const QString &parameter*/) {
    QString result;
    /* ... here is the expensive or blocking operation ... */
    //qDebug() << "Worker::doWork " << parameter;
    emit resultReady(result);
}

#if 0 // some reference code here.
// set model
void Worker::setText(const QString &msg, int cpu_usage, int freemem)
{
    QVariant returnedValue;
    //qDebug() << "Worker::setText " << msg;
    // ( https://forum.qt.io/post/306365 )
    QObject *root_object = p_engine->rootObjects().first();
    if ( !root_object ) {
    qDebug() << "root object!";
    }
    // find current active window
    // How can I access my Window object properties
    // from C++ while using QQmlApplicationEngine?
    // ( https://goo.gl/V1ACAu )
    // for "qml objects" you will need to have the objectName property set
    // ( https://goo.gl/LWbdMG )
    //qDebug() << "root object name:" << root_object->objectName();

#if 0
    //qDebug() << "Property value:" << object->property("id").toString();
    //QObject *clock_text = object->findChild<QObject*>("text1");
    QQmlProperty::write(clock_text, "text", msg.right(8));
    //qDebug() << "Property value:" << QQmlProperty::read(clock_text, "text").toString();
    //clock_text->setProperty("text", msg.right(8));
#endif

#if 0 // not update instantly, why?
    QObject *pQobject = root_object->findChild<QObject*>("txtTotalVoltage");
    if (pQobject)
        QQmlProperty::write(pQobject, "text", 999.9);
#endif

#if 0
    m_pRacev->m_pWinDeploy = root_object->findChild<QObject*>("deploymentWindow");
#endif

//#define SINE_VALUE_
#if defined ( SINE_VALUE_ )
    //qDebug() << "sin(" << M_PI << ") = " << qSin(M_PI);
    m_pRacev->m_pInfo->pi += 0.25;
    if ( 2*M_PI < m_pRacev->m_pInfo->pi )
        m_pRacev->m_pInfo->pi = 0;
    m_pRacev->m_pInfo->speed = static_cast<uint>( 280 * qSin(m_pRacev->m_pInfo->pi));
    if ( MAX_SPEED_ < m_pRacev->m_pInfo->speed )
        m_pRacev->m_pInfo->speed = MAX_SPEED_;
#endif

    m_pRacev->m_pInfo->cpu_usage = cpu_usage;
    m_pRacev->m_pInfo->freemem = freemem;
    //QDateTime current_dt;
    //qint64 ts = current_dt.currentSecsSinceEpoch();
    //m_pRacev->m_pInfo->milage = static_cast<uint64_t>(ts);

//#define UPDATE_TIMER_
#if defined( UPDATE_TIMER_ )
    // System Information / main / system status
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateSystemInfo",
            Qt::BlockingQueuedConnection, /* https://goo.gl/kUjJva */
            Q_RETURN_ARG(QVariant, returnedValue),
            /*Q_ARG(QVariant, msg.right(8).left(5)),*/
            Q_ARG(QVariant, QString("%1").arg(m_pRacev->m_pInfo->m_dbop, 5, 10, QChar('0'))),
            Q_ARG(QVariant, m_pRacev->m_pInfo->cpu_usage),
            Q_ARG(QVariant, m_pRacev->m_pInfo->freemem));
#endif

//#define GET_DASHBOARD_
#if defined( GET_DASHBOARD_ )
    // allows a C++ application to locate an item within a QML component using the QObject::findChild() method. ( https://goo.gl/Caomvq )    ///
    QObject *p_speedometer = root_object->findChild<QObject*>("speedometer1");
    m_pRacev->m_pInfo->speed = QQmlProperty::read(p_speedometer, "value").toUInt();
    QObject *p_tachometer = root_object->findChild<QObject*>("tachometer1");
    m_pRacev->m_pInfo->rpm = QQmlProperty::read(p_tachometer, "value").toUInt();
    qDebug() \
        << "speed:" << m_pRacev->m_pInfo->speed << QString::fromStdString(m_pRacev->m_pInfo->unit) \
        << "rpm: " << m_pRacev->m_pInfo->rpm << QString::fromStdString(m_pRacev->m_pInfo->rpm_unit);
#endif

#if 0
    qDebug() << "Worker wakeOne";
    this->m_pRacev->m_cond.wakeOne();
    //qDebug() << "Worker wakeAll";
    //this->m_pRacev->m_cond.wakeAll();
#endif

}
#endif

void Worker::updateFramePayloadQSize(QCanBusFrame& frame, int size) {
    QVariant returnedValue;
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateQBInfo",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, frame.payload().toHex(0)),
        Q_ARG(QVariant, size),
    Q_ARG(QVariant, 0/*Bsize*/));
}

// TODO: global constant, move to header
#define LEN_PAYLOAD 8

#define DELTA_OFFSET (-500)
#define MIN_DELTA (-500)
#define MAX_DELTA (1000)
#define MIN_KHPKM 0
#define MAX_KHPKM 3000
#define MIN_MLEFT 0
#define MAX_MLEFT 1000

void Worker::updateMessage_VCU_HMI_Msg_4
    (QCanBusFrame* pframe/*, GObject* pDst */) {
    QVariant returnedValue; int i = 0;
    int consume_delta = 0; double kh_per_km = 0;
    QString s_delta, s_perkm, s_left;
    QByteArray payload;

    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    try {
	if ( nullptr == pframe ) {
	    cout<< __func__ <<":"<< __LINE__ << " ! "<< endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.size() != 8 ) {
#if defined ( QT_DEBUG )
	    cout<< __func__ <<":"<< __LINE__ << payload.size() << " ! "<< endl;
#endif
	    goto ERROR_HANDLER;
	}
	i = 0; consume_delta
	    = (payload[i]&0xFF)+((payload[i+1]&0xFF)<<8)+DELTA_OFFSET;
	//if ( consume_delta < MIN_DELTA ) consume_delta = MIN_DELTA;
	//if ( MAX_DELTA < consume_delta ) consume_delta = MAX_DELTA;
	if ( MAX_DELTA < consume_delta || consume_delta < MIN_DELTA ) {
	    //qDebug() << __FILE__ << ":" << __LINE__ << "c delta!";
	    goto ERROR_HANDLER;
	}

	i = 2; kh_per_km =
	    static_cast<double>((payload[i]&0xFF)+((payload[i+1]&0xFF)<<8));
	//if ( kh_per_km < MIN_KHPKM ) kh_per_km = MIN_KHPKM;
	//if ( MAX_KHPKM < kh_per_km ) kh_per_km = MAX_KHPKM;

	i = 4; m_pInfo->milage_left =
	    static_cast<double>((payload[i]&0xFF)+((payload[i+1]&0xFF)<<8))/10;
	if ( MAX_MLEFT < m_pInfo->milage_left || m_pInfo->milage_left < MIN_MLEFT ) {
	    //qDebug() << __FILE__ << ":" << __LINE__ << "m left!";
	    goto ERROR_HANDLER;
	}

	s_delta = QString("%1").arg(consume_delta, 4, 10, QChar('0'));
	s_perkm = QString::number(static_cast<double>(kh_per_km), 'f', 1);
	//s_perkm = QString("%1").arg(kh_per_km, 4, 10, QChar('0'));
	//s_left = QString("%1").arg(milage_left, 4, 10, QChar('0'));
	s_left = QString::number(m_pInfo->milage_left, 'f', 1);

#if 0
	qDebug() << "delta" << consume_delta << "khpk" << kh_per_km
	<< "mlft" << milage_left;
#endif

	QMetaObject::invokeMethod(m_pRacev->m_pWinMain,
	"update_VCU_HMI_Msg_4",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_delta),
	Q_ARG(QVariant, s_perkm),
	Q_ARG(QVariant, s_left));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout<< __func__ <<":"<< __LINE__ << " - "<<endl;
    return;
}

/*
 *
 */
void Worker::updateMsg_BMS_Volt_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    QString s_cellVoltages[NUM_CELLS] = {nullptr};
    QVariant returnedValue; int i,x;
    Info* p_info = m_pRacev->m_pInfo;
#if 1
    cout << __func__ << ":" << __LINE__ << " + "
	<< "pk " << pack
	<< endl;
#endif
    for ( i = 0; i < NUM_CELLS; i++ ) {
	x = (pack*NUM_PACKS+i)*BYTES_VOLT;
#if 0
	cout << __func__ << ":" << __LINE__ << " + "
	    << "i " << setfill('0') << setw(2) << i << " "
	    << "x " << setfill('0') << setw(3) << x << " "
	    << endl;
#endif
	p_info->cellVoltages[pack][i] = static_cast<double>(
	    (p_info->cell_voltage[x]&0xFF)
	    + ((p_info->cell_voltage[x+1]&0xFF)<<8) )
	    / static_cast<double>(1000);
    }
#if 0 // TODO: consider validation?
    for ( i = 0; i < static_cast<int>(cellSize); i++ ) {
	if ( p_info->cellVoltages[pack][i] < MIN_V
	    || MAX_V_CELL < p_info->cellVoltages[pack][i] ) {
	    //cout << __func__ << ":" << __LINE__ << "i " << i << " !c" << endl;
	    continue;
	}
    }
#endif
    for ( i = 0; i < NUM_CELLS; i++ ) {
	s_cellVoltages[i] = QString::number(
	    static_cast<double>(p_info->cellVoltages[pack][i]), 'f', PRECISION_VOLTAGE);
    }
#if 0
    cout << __func__ << ":" << __LINE__ << " "
	<< "m 0x" << setfill('0') << setw(16) << hex
	<< m_pRacev->m_pFrameParser->m_bamVoltMsgMap << dec
	<< endl;
    for ( i = 0; i < NUM_CELLS; i++ ) {
	if ( i == (NUM_CELLS/2) ) cout << endl;
	cout << "i " << setfill('0') << setw(2) << i
	    << "[" << setw(4) << setprecision (PRECISION_VOLTAGE) << fixed
	    << p_info->cellVoltages[pack][i] << "] ";
    }
    cout << endl;
#endif
    QMetaObject::invokeMethod(pDstVw, "updateBMS_Volt_Msg01_cell1_7",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_cellVoltages[0]),
	Q_ARG(QVariant, s_cellVoltages[1]),
	Q_ARG(QVariant, s_cellVoltages[2]),
	Q_ARG(QVariant, s_cellVoltages[3]),
	Q_ARG(QVariant, s_cellVoltages[4]),
	Q_ARG(QVariant, s_cellVoltages[5]),
	Q_ARG(QVariant, s_cellVoltages[6]));

    QMetaObject::invokeMethod(pDstVw, "updateBMS_Volt_Msg01_cell8_14",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_cellVoltages[7]),
	Q_ARG(QVariant, s_cellVoltages[8]),
	Q_ARG(QVariant, s_cellVoltages[9]),
	Q_ARG(QVariant, s_cellVoltages[10]),
	Q_ARG(QVariant, s_cellVoltages[11]),
	Q_ARG(QVariant, s_cellVoltages[12]),
	Q_ARG(QVariant, s_cellVoltages[13]));
    return;
}

/*
 *
 */
void Worker::updateMsg_BMS_Temp_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    QVariant returnedValue;
    Info* p_info = m_pRacev->m_pInfo;

    p_info->cellTemperatures[pack][0]
	= (p_info->probe_temperature[pack*NUM_TPROBE+0]/*&0xFF*/) + OFFSET_TEMP;
    if ( p_info->cellTemperatures[pack][0] < OFFSET_TEMP )
	p_info->cellTemperatures[pack][0] = OFFSET_TEMP;
    if ( MAX_TEMP <= p_info->cellTemperatures[pack][0] )
	p_info->cellTemperatures[pack][0] = MAX_TEMP;

    p_info->cellTemperatures[pack][1]
	= (p_info->probe_temperature[pack*NUM_TPROBE+1]/*&0xFF*/) + OFFSET_TEMP;
    if ( p_info->cellTemperatures[pack][1] < OFFSET_TEMP )
	p_info->cellTemperatures[pack][1] = OFFSET_TEMP;
    if ( MAX_TEMP <= p_info->cellTemperatures[pack][1] )
	p_info->cellTemperatures[pack][1] = MAX_TEMP;

    p_info->cellTemperatures[pack][2]
	= (p_info->probe_temperature[pack*NUM_TPROBE+2]/*&0xFF*/) + OFFSET_TEMP;
    if ( p_info->cellTemperatures[pack][2] < OFFSET_TEMP )
	p_info->cellTemperatures[pack][2] = OFFSET_TEMP;
    if ( MAX_TEMP <= p_info->cellTemperatures[pack][2] )
	p_info->cellTemperatures[pack][2] = MAX_TEMP;

    p_info->cellTemperatures[pack][3]
	= (p_info->probe_temperature[pack*NUM_TPROBE+3]/*&0xFF*/) + OFFSET_TEMP;
    if ( p_info->cellTemperatures[pack][3] < OFFSET_TEMP )
	p_info->cellTemperatures[pack][3] = OFFSET_TEMP;
    if ( MAX_TEMP <= p_info->cellTemperatures[pack][3] )
	p_info->cellTemperatures[pack][3] = MAX_TEMP;
#if 0
    cout << __func__ << ":" << __LINE__
	<< " pk " << pack << " "
	<< "0x" << hex << setfill('0') << setw(2)
	<< p_info->probe_temperature[pack*NUM_TPROBE+0] << " "
	<< p_info->probe_temperature[pack*NUM_TPROBE+1] << " "
	<< p_info->probe_temperature[pack*NUM_TPROBE+2] << " "
	<< p_info->probe_temperature[pack*NUM_TPROBE+3] << " "
	<< dec
	<< endl;
#endif
#if 0
	cout << __func__ << ":" << __LINE__ << " pack " << pack << " ";
	for ( i = 0; i < 4; i++ ) {
	    cout << "0x" << setw(2) << hex << p_info->probe_temperature[pack*NUM_TPROBE+i] << " ";
	}
	// cout << "m 0x" << setfill('0') << setw(2) << m_bamTempMsgMap;
	// cout << dec;
	cout << endl;
#endif
    QMetaObject::invokeMethod(pDstVw, "updateBMS_Temp_Msg01",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, p_info->cellTemperatures[pack][0]),
	Q_ARG(QVariant, p_info->cellTemperatures[pack][1]),
	Q_ARG(QVariant, p_info->cellTemperatures[pack][2]),
	Q_ARG(QVariant, p_info->cellTemperatures[pack][3]));
}

//
// pick up related address, when stays on top
//
void Worker::updateMainView(QCanBusFrame& frame) {
    QVariant returnedValue;

    quint32 frame_id = frame.frameId();
    switch ( frame_id ) {
    case VCU_HMI_Msg_1 :
    // mark temporarily updateMessage_VCU_HMI_Msg_1(frame);
        break;
    case VCU_HMI_Msg_2 :
        break;
    case VCU_HMI_Msg_3 :
    case VCU_HMI_Msg_4 :
    //updateMessage_VCU_HMI_Msg_4(frame); break;
    // TODO: refactor
    case BMS_VCU_Msg01 :
#if 0
    case BMS_VCU_Msg02 :
    updateMsg_BMS_VCU_Msg02(frame/*, ptr to GObject */); break;
    case BMS_Volt_Msg01 :
    //updateMsg_BMS_Volt_Msg01(frame/*, ptr to GObject */); break;
    case BMS_Temp_Msg01 :
    //updateMsg_BMS_Temp_Msg01(frame/*, ptr to GObject */); break;
#endif
    // TODO: more address
    default:
    //QString myString
    //    = "0x" + QString::number(frame.frameId(),16).toUpper();
    //qDebug() << "TBD id(Hex)" << myString;
    break;
    }
#if 0
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateModel",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        /* kph */
        Q_ARG(QVariant, m_pRacev->m_pInfo->speed),
        /* rpm */
        Q_ARG(QVariant, m_pRacev->m_pInfo->rpm),
        /* gear */
        Q_ARG(QVariant, QString::fromStdString(m_pRacev->m_pInfo->gear)),
        /* milage */
        Q_ARG(QVariant,static_cast<uint>(m_pRacev->m_pInfo->milage)));
#endif
}

// update ( main ), consider polymorphism
void Worker::updateView(void) {
    QVariant returnedValue;

    Info* p_info = m_pRacev->m_pInfo;
    // TODO: handler
    // updateMessage_VCU_HMI_Msg_1(&p_info->FrameVCU_HMI_MSG01);
    m_pRacev->m_pVCU_HMI_MSG01
	->updateMsg(&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinMain);
    m_pRacev->m_pVCU_HMI_MSG02
	->updateMsg(&p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinMain);
    m_pRacev->m_pVCU_HMI_MSG03
	->updateMsg(&p_info->FrameVCU_HMI_MSG03, m_pRacev->m_pWinMain);
    updateMessage_VCU_HMI_Msg_4(&p_info->FrameVCU_HMI_MSG4);
    m_pRacev->m_pBMS_VCU_MSG01
	->updateMsg(&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinMain);
}

void Worker::updateWindow(QObject *pWindow) {
    QVariant returnedValue;
    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    try {
	QMetaObject::invokeMethod(pWindow, "loadMenuText",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, m_pRacev->m_Locale));
    } catch (const std::exception& ex) {
	cout << "exception " << ex.what() << endl;
    }
    return;
}

// consider polymorphism
void Worker::updateDeploymentView(void) {
    Info* p_info = m_pRacev->m_pInfo;
    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDeploy);
    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinDeploy);
    //cout<< __func__ << ": " << __LINE__ << "-" << endl;
    return;
}

// consider polymorphism
void Worker::updateChartView(void) {
    Info* p_info = m_pRacev->m_pInfo;

    //cout<< __func__ << ": " << __LINE__ << endl;
    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinChart);
    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinChart);
    updateMsg_BMS_Volt_Msg01(m_pRacev->m_indexPack, m_pRacev->m_pWinChart);
    updateMsg_BMS_Temp_Msg01(m_pRacev->m_indexPack, m_pRacev->m_pWinChart);
    //cout<< __func__ << ": " << __LINE__ << "-" << endl;
    return;
}

void Worker::updateChargingView(void) {
    //Info* p_info = m_pRacev->m_pInfo;

    // cout<< __func__ << ": " << __LINE__ << endl;
    // TODO: get current data when active, however,
    // can wait for some seconds.
    return;
}

void Worker::updateDiagnoseView(void) {
    QString s_imei;
    // Info* p_info = m_pRacev->m_pInfo;
    QObject* pDstVw = m_pRacev->m_pWinDiagnose;
    QVariant returnedValue;

    // absolute path required
    QString program = "/bin/cat";
    QString imei_cfg = "/home/racev/IMEI.cfg";
    QStringList arguments;
    //All the other arguments
    arguments << imei_cfg;

    QProcess myProcess;
    myProcess.start(program, arguments);
    if (!myProcess.waitForStarted()) {
	cout << __func__ << ":" << __LINE__ << "!" << endl;
    // Qt defines QT_NO_DEBUG for release builds.
    // Otherwise QT_DEBUG is defined. ( https://is.gd/DfnNx2 )
#if defined ( QT_DEBUG )
    qDebug() << __func__ << ":" << __LINE__
    	<< " cmd '" << program << " " << arguments << "'";
#endif
        return;
    }
    if (!myProcess.waitForFinished()) {
#if defined ( QT_DEBUG )
	qDebug() << __func__ << ":" << __LINE__
	    << "failed:" << myProcess.errorString();
#endif
	s_imei = "0000000000000000";
    }
    else {
	s_imei = myProcess.readAllStandardOutput().data();
	// s_imei = myProcess.readAll().data();
    }

#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " imei ["
	<< s_imei.trimmed().toStdString() << "]" << endl;
#endif
    QMetaObject::invokeMethod(pDstVw, "loadImei",
    Qt::BlockingQueuedConnection,
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, s_imei.trimmed()));

    return;
}

void Worker::updateEngineeringView(void) {
    //Info* p_info = m_pRacev->m_pInfo;

    //cout<< __func__ << ": " << __LINE__ << endl;
    return;
}

//!
//! dequeue, update model(context), update, notify
//!
void Worker::updateModel(void) {
    Info* p_info = m_pRacev->m_pInfo;
#if 0
    // QByteArray cmd_at_mp_ff92 = "AT MP FF92\r";
    Can06Thread *p_can06thread = qobject_cast<Can06Thread*>(m_pRacev->m_pCAN06Thread);
    // class name ( https://is.gd/VPYgv0 )
    cout << typeid(*this).name() << "::" << __func__ <<":"<< __LINE__ << " + "
	<< m_iPollingTurn << endl;
    p_can06thread->writeCommand(
	/*cmd_at_mp_ff92*/m_Commands[m_iPollingTurn++]);
    cout << __func__ << ":" << __LINE__ << " + " << m_iPollingTurn << endl;
    if ( 2 < m_iPollingTurn ) m_iPollingTurn = 0;
#endif
#if 0
    // How can I access my Window object properties
    // from C++ while using QQmlApplicationEngine?
    // ( https://goo.gl/V1ACAu )
    // for "qml objects" you will need to have the objectName property set
    // ( https://goo.gl/LWbdMG )

    // find current active window and update
    // No need to set them artificially big,
    // QML manages z-index automatically. ( https://goo.gl/yvBajs )
#endif
    // TODO: changed for consequtive N frames within X seconds
    if ( "true" == QQmlProperty
	::read(m_pRacev->m_pWinMain, "active") ) {
	// TODO: consider most of the time, main is on the top
	// TODO: or other application is on the top
	//updateMainView(frame);
	//cout<< __func__ <<":"<< __LINE__ << " +"<<endl;
	updateView(/*m_pRacev->m_pWinMain*/);
    }
    else if ( "true" == QQmlProperty
	::read(m_pRacev->m_pWinChart, "active") ) {
	//cout<< __func__ <<":"<< __LINE__ << " +"<<endl;
	updateChartView();
    }
    else if ( "true" == QQmlProperty
	::read(m_pRacev->m_pWinDeploy, "active") ) {
	//cout<< __func__ <<":"<< __LINE__ << " +"<<endl;
	updateDeploymentView();
    }
    /* more to come ... */
    else {
	// qDebug() << "dashboard top 0";
    }
    // cout << __func__ << ":" << __LINE__ << " - " << endl;
}

void Worker::quit() {
    qDebug() << "Worker::quit ";
}

void Worker::onSignalAuth(const QString &entitlement) {
    QVariant returnedValue; int i; QString msg = "not authorized!";
    QCanBusFrame frame_tx; QByteArray array2;
    QString s_yr, s_mo, s_dt, s_hr, s_min, s_sec, str;
#if defined ( SEND_NONCE_ )
    QCanBusFrame frame_nonce1; QCanBusFrame frame_nonce2; QCanBusFrame frame_nonce3;
#endif

    CanThread *pCanThread = reinterpret_cast<CanThread *>(m_pRacev->pCANBusReceiverThread);
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " [" << entitlement.toStdString() << "]" << endl;
#endif
    // TODO: decode function
    // TODO: comparing with hash
    if ( !entitlement.compare("1234")
	&& m_pRacev->m_pWinMain ) {
#define RESPOND_VCU_PINOK
#if defined ( RESPOND_VCU_PINOK )
	// if ( ( m_pRacev->m_pInfo->key_position == 0x01
	//	&& key_position == 0x02 /* OFF -> ACC */ )
	//    || ( m_pRacev->m_pInfo->key_position == 0x02
	//	&& key_position == 0x03 /* ACC -> ON */ ) ) {
	    frame_tx.setFrameId(HMI_TM_MSG01);
	    frame_tx.setFrameType(QCanBusFrame::DataFrame);
#if defined ( SEND_NONCE_ )
	    frame_nonce1.setFrameId(NONCE_1_MSG);
	    frame_nonce1.setFrameType(QCanBusFrame::DataFrame);
	    str = "10FF00";
	    array2 = QByteArray::fromHex(str.toLatin1());
	    frame_nonce1.setPayload(array2);

	    frame_nonce2.setFrameId(NONCE_2_MSG);
	    frame_nonce2.setFrameType(QCanBusFrame::DataFrame);
	    str = "F4FE00";
	    array2 = QByteArray::fromHex(str.toLatin1());
	    frame_nonce2.setPayload(array2);

	    frame_nonce3.setFrameId(NONCE_3_MSG);
	    frame_nonce3.setFrameType(QCanBusFrame::DataFrame);
	    str = "20FF00";
	    array2 = QByteArray::fromHex(str.toLatin1());
	    frame_nonce3.setPayload(array2);
#endif
#define NUM_SHOTS 12
	    for ( i = 0; i < NUM_SHOTS; i++ ) { // Qisda:3 shots,500ms
		QDateTime local(QDateTime::currentDateTime());
		s_yr = QString("%1").arg(local.toString("yyyy").toInt(), 4, 16, QChar('0'));
		s_mo = QString("%1").arg(local.toString("MM").toInt(), 2, 16, QChar('0'));
		s_dt = QString("%1").arg(local.toString("dd").toInt(), 2, 16, QChar('0'));
		s_hr = QString("%1").arg(local.toString("hh").toInt(), 2, 16, QChar('0'));
		s_min = QString("%1").arg(local.toString("mm").toInt(), 2, 16, QChar('0'));
		s_sec = QString("%1").arg(local.toString("ss").toInt(), 2, 16, QChar('0'));
		// send 80 "intentionally", 3 times, interval 500 ms,
		str = s_sec + s_min + s_hr
		    + s_dt + s_mo + s_yr.mid(2,2) + s_yr.mid(0,2) + "80"; // TODO: configurable
		array2 = QByteArray::fromHex(str.toLatin1());
		frame_tx.setPayload(array2);
		pCanThread->Transmit(frame_tx);
		usleep(500*1000); // 500 milliseconds
#if defined ( SEND_NONCE_ )
		pCanThread->Transmit(frame_nonce1);
		pCanThread->Transmit(frame_nonce2);
		pCanThread->Transmit(frame_nonce3);
#endif

#if 0 // defined ( QT_DEBUG )
		cout << __func__ << ":" << __LINE__ << " knock " << i << endl;
#endif

	    }
	// }
#endif
	// QQmlProperty::write(m_pRacev->m_pWinMain, "visible", "true");
	// NOTE: this will make window invisible on the debian9 taskbar.
	// QQmlProperty::write(m_pRacev->m_pWinLogOn, "visible", "false");
	m_pRacev->LogOn(true);
	setWindowActive(m_pRacev->m_pWinMain);
	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authPassed",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue));
    } else {
	m_pRacev->LogOn(false);
	setWindowActive(m_pRacev->m_pWinLogOn);
	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authFailed",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, msg));
    }
}

void Worker::onSignalSessionTimeout(int seconds) {
#if 1 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__
	<< " " << seconds << endl;
#endif
    // m_pRacev->LogOn(false);
    // setWindowActive(m_pRacev->m_pWinBoot);
    //
    // tx and let VCU sending sleep
    QCanBusFrame frame_timeout;
    QByteArray array2;
    QString s_yr, s_mo, s_dt, s_hr, s_min, s_sec, str;

    frame_timeout.setFrameId(HMI_TM_MSG01);
    frame_timeout.setFrameType(QCanBusFrame::DataFrame);
    QDateTime local(QDateTime::currentDateTime());
    s_yr = QString("%1").arg(local.toString("yyyy").toInt(), 4, 16, QChar('0'));
    s_mo = QString("%1").arg(local.toString("MM").toInt(), 2, 16, QChar('0'));
    s_dt = QString("%1").arg(local.toString("dd").toInt(), 2, 16, QChar('0'));
    s_hr = QString("%1").arg(local.toString("hh").toInt(), 2, 16, QChar('0'));
    s_min = QString("%1").arg(local.toString("mm").toInt(), 2, 16, QChar('0'));
    s_sec = QString("%1").arg(local.toString("ss").toInt(), 2, 16, QChar('0'));
    // send 80 "intentionally", 3 times, interval 500 ms,
    str = s_sec + s_min + s_hr
	+ s_dt + s_mo + s_yr.mid(2,2) + s_yr.mid(0,2) + "20"; // TODO: configurable
    array2 = QByteArray::fromHex(str.toLatin1());
    frame_timeout.setPayload(array2);
    CanThread *pCanThread
	= reinterpret_cast<CanThread *>(m_pRacev->pCANBusReceiverThread);
    pCanThread->Transmit(frame_timeout);
#if 1 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__
	<< " send timeout" << endl;
#endif
}

void Worker::onSignalCalibrate(const QString &msg) {
    Info* p_info = m_pRacev->m_pInfo;
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " " << msg.toStdString() << endl;
#endif
    p_info->m_pGSensor->Calibrate(true);
}

void Worker::onSignalZero(const QString &msg) {
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " " << msg.toStdString() << endl;
#endif
}

// launch window
// TODO: to maximize performance, moving MRU window on the top
void Worker::cppSlotRaiseWindow(const QString &msg) {
    // In QT,how to distinguish debug and release in someway like preprocessor
    // ( https://is.gd/QYQKG2 )
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " " << msg.toStdString() << endl;
#endif
    if ( !msg.compare("Battery") && m_pRacev->m_pWinDeploy ) {
	QQmlProperty::write(m_pRacev->m_pWinDeploy, "visible", "true");
    }
    else if ( !msg.compare("ChargingStation")
        && m_pRacev->m_pWinCharging ) {
	QQmlProperty::write(m_pRacev->m_pWinCharging, "visible", "true");
    } //
    else if ( !msg.compare("TPMS")
        && m_pRacev->m_pWinTpms) {
	QQmlProperty::write(m_pRacev->m_pWinTpms, "visible", "true");
    }
    else if ( !msg.compare("Diagnosis")
        && m_pRacev->m_pWinDiagnose ) {
	QQmlProperty::write(m_pRacev->m_pWinDiagnose, "visible", "true");
    }
    else if ( !msg.compare("UNLOCK")
        && m_pRacev->m_pWinUnlock ) {
	QQmlProperty::write(m_pRacev->m_pWinUnlock, "visible", "true");
    }
    //else if ( !msg.compare("Engineering")
     //   && m_pRacev->m_pWinEngineering ) {
    //QQmlProperty::write(m_pRacev->m_pWinEngineering, "visible", "true");
    //}

    else if ( !msg.compare("Vehicle")
        && m_pRacev->m_pWinVehicle ) {
	QQmlProperty::write(m_pRacev->m_pWinVehicle, "visible", "true");
    }
    else if ( !msg.compare("Traction")
        && m_pRacev->m_pWinTraction ) {
	QQmlProperty::write(m_pRacev->m_pWinTraction, "visible", "true");
    }
    else if ( !msg.compare("Brake")
        && m_pRacev->m_pWinBrake ) {
	QQmlProperty::write(m_pRacev->m_pWinBrake, "visible", "true");
    }
    else if ( !msg.compare("Steering")
        && m_pRacev->m_pWinSteering ) {
	QQmlProperty::write(m_pRacev->m_pWinSteering, "visible", "true");
    }

    else if ( !msg.compare("PcuIoAnalog")
        && m_pRacev->m_pWinPcuAnalog) {
	QQmlProperty::write(m_pRacev->m_pWinPcuAnalog, "visible", "true");
    }
    else if ( !msg.compare("BcuIoAnalog")
        && m_pRacev->m_pWinBcuAnalog) {
	QQmlProperty::write(m_pRacev->m_pWinBcuAnalog, "visible", "true");
    }
    else if ( !msg.compare("VcuIoAnalog")
        && m_pRacev->m_pWinVcuAnalog) {
	QQmlProperty::write(m_pRacev->m_pWinVcuAnalog, "visible", "true");
    }
    else if ( !msg.compare("BmsAnalog")
        && m_pRacev->m_pWinBmsAnalog) {
	QQmlProperty::write(m_pRacev->m_pWinBmsAnalog, "visible", "true");
    }

    else if ( !msg.compare("PcuIoDigital")
        && m_pRacev->m_pWinPcuDigital) {
	QQmlProperty::write(m_pRacev->m_pWinPcuDigital, "visible", "true");
    }
    else if ( !msg.compare("BcuIoDigital")
        && m_pRacev->m_pWinBcuDigital) {
	QQmlProperty::write(m_pRacev->m_pWinBcuDigital, "visible", "true");
    }
    else if ( !msg.compare("VcuIoDigital")
        && m_pRacev->m_pWinVcuDigital) {
	QQmlProperty::write(m_pRacev->m_pWinVcuDigital, "visible", "true");
    }
    else if ( !msg.compare("BmsDigital")
        && m_pRacev->m_pWinBmsDigital) {
	QQmlProperty::write(m_pRacev->m_pWinBmsDigital, "visible", "true");
    }
    else if ( !msg.compare("dc2Digital")
        && m_pRacev->m_pWinDcdc) {
	QQmlProperty::write(m_pRacev->m_pWinDcdc, "visible", "true");
    }

    else if ( !msg.compare("IconDesc") && m_pRacev->m_pWinIconDesc) {
	QQmlProperty::write(m_pRacev->m_pWinIconDesc, "visible", "true");
	// TODO: icon desc
    }

    else if ( !msg.compare("History")
        && m_pRacev->m_pWinHistory) {
	QQmlProperty::write(m_pRacev->m_pWinHistory, "visible", "true");
    }
    else if ( !msg.compare("AlarmRecord")
        && m_pRacev->m_pWinAlarmRecord) {
	QQmlProperty::write(m_pRacev->m_pWinAlarmRecord, "visible", "true");
    }
    else if ( !msg.compare("AlarmStatistics")
        && m_pRacev->m_pWinAlarmStatistics) {
	QQmlProperty::write(m_pRacev->m_pWinAlarmStatistics, "visible", "true");
    }
    else if ( !msg.compare("SystemLog")
        && m_pRacev->m_pWinSystemLog) {
	QQmlProperty::write(m_pRacev->m_pWinSystemLog, "visible", "true");
    }
    else if ( !msg.compare("CellAlarmRecord")
        && m_pRacev->m_pWinCellAlarmRecord) {
	QQmlProperty::write(m_pRacev->m_pWinCellAlarmRecord, "visible", "true");
    }
    else if ( !msg.compare("VehicleInformationRecord")
        && m_pRacev->m_pWinVehicleInformationRecord) {
	QQmlProperty::write(m_pRacev->m_pWinVehicleInformationRecord, "visible", "true");
    }
    else if ( !msg.compare("ChargeTrippedRecord")
        && m_pRacev->m_pWinChargeTrippedRecord) {
	QQmlProperty::write(m_pRacev->m_pWinChargeTrippedRecord, "visible", "true");
    }
    else if ( !msg.compare("Parameters")
        && m_pRacev->m_pWinParameters) {
	QQmlProperty::write(m_pRacev->m_pWinParameters, "visible", "true");
    }
    else if ( !msg.compare("GeneralParameters")
        && m_pRacev->m_pWinGeneralParameters) {
	QQmlProperty::write(m_pRacev->m_pWinGeneralParameters,
	    "visible", "true");
    }
    else if ( !msg.compare("ChargeParameters")
        && m_pRacev->m_pWinChargeParameters) {
	QQmlProperty::write(m_pRacev->m_pWinChargeParameters,
	    "visible", "true");
    }
    else if ( !msg.compare("AlarmParameters")
        && m_pRacev->m_pWinAlarmParameters) {
	QQmlProperty::write(m_pRacev->m_pWinAlarmParameters,
	    "visible", "true");
	// directly access QML ListModel from C++
    }
    else if ( !msg.compare("HmiParameters")
        && m_pRacev->m_pWinHmiParameters) {
	QQmlProperty::write(m_pRacev->m_pWinHmiParameters,
	    "visible", "true");
    }
    else if ( !msg.compare("TpmsSetting")
        && m_pRacev->m_pWinTyreParameters) {
	QQmlProperty::write(m_pRacev->m_pWinTyreParameters,
	    "visible", "true");
    }
    else if ( !msg.compare("LogOn")
        && m_pRacev->m_pWinLogOn) {
	cout << __FILE__ << ":" << __LINE__ << " r " << endl;
	QQmlProperty::write(m_pRacev->m_pWinLogOn,
	    "visible", "true");
    }
    else if ( !msg.compare("Boot")
        && m_pRacev->m_pWinBoot ) {
	QQmlProperty::write(m_pRacev->m_pWinBoot,
	    "visible", "true");
    }
    else { }
}

void Worker::cppSlotDeployment(const QString &msg, int index) {
    QVariant returnedValue;
#if 0 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__
	<< " " << msg.toStdString() << ", " << index << endl;
#endif

    m_pRacev->m_selectPack = msg;
    m_pRacev->m_indexPack = index;
#if 0
    // loading component dynamically
    qDebug() << m_pRacev->m_pWinChart;
    QQmlComponent component(p_engine);
    component.loadUrl(QUrl(QStringLiteral("qrc:/BatteryStatus.qml")));
    if ( component.isReady() ) {
    component.create();
    }
    else {
    qWarning() << component.errorString();
    }
    QObject *root_object = p_engine->rootObjects().first();
    if ( !root_object ) {
        qDebug() << "root object!";
    }
    //m_pWinMain = root_object->findChild<QObject*>("hmiroot");
    m_pRacev->m_pWinChart = root_object->findChild<QObject*>("chartWindow");
    qDebug() << m_pRacev->m_pWinChart;
#endif
    QMetaObject::invokeMethod(m_pRacev->m_pWinChart, "setPack",
    Qt::BlockingQueuedConnection,
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, msg),
    Q_ARG(QVariant, index)); /* index, pack, zero-based */

    updateMsg_BMS_Volt_Msg01(index, m_pRacev->m_pWinChart);

    // set chart data
    QQmlProperty::write(m_pRacev->m_pWinChart, "visible", "true");
}

#if 0
void Worker::errorString()
{
    qDebug() << "Worker::errorString ";
}
#endif

// update view from current model
// ( switch and instantly updated by updateModel )
void Worker::onSignalActive(const QString &msg) {
    QVariant returnedValue;
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " " << msg.toStdString() << endl;
#endif
    if ( msg == "Main" ) {
	updateView();
	updateWindow(m_pRacev->m_pWinMain); // TODO: trigger change locale
    }
    else if ( msg == "Deployment" ) {
	updateDeploymentView();
    }
    else if ( msg == "Chart" ) {
	updateChartView();
    }
    else if ( msg == "ChargingStation" ) {
	updateChargingView();
    }
    else if ( msg == "Tpms" ) {
    }
    else if ( msg == "Unlock" ) {
    }
    else if ( msg == "Diagnosis" ) {
	updateDiagnoseView();
    }
    else if ( msg == "Engineering" ) {
	updateEngineeringView();
    }
    else if ( msg == "Vehicle" ) {
    }
    else if ( msg == "Traction" ) {
    }
    else if ( msg == "Brake" ) {
    }
    else if ( msg == "Steering" ) {
    }
    else if ( msg == "BCUAnalog" ) {
    }
    else if ( msg == "BCUAnalog" ) {
    }
    else if ( msg == "VCUAnalog" ) {
    }
    else if ( msg == "PCUDigital" ) {
    }
    else if ( msg == "BCUDigital" ) {
    }
    else if ( msg == "VCUDigital" ) {
    }
    else if ( msg == "DCDC" ) {
    }
    else if ( msg == "IconDescription" ) {
    }

    else if ( msg == "History" ) {
    }
    else if ( msg == "AlarmRecord" ) {
    }
    else if ( msg == "AlarmStatistics" ) {
    }
    else if ( msg == "SystemLog" ) {
    }
    else if ( msg == "CellAlarmRecord" ) {
    }
    else if ( msg == "vehicleInfoRecord" ) {
    }
    else if ( msg == "chargeTrippedRecord" ) {
    }
    else if ( msg == "Parameters" ) {
    }
    else if ( msg == "GeneralParameters" ) {
    }
    else if ( msg == "ChargeParameters" ) {
    }
    else if ( msg == "AlarmParameters" ) {
    }
    else if ( msg == "HmiParameters" ) {
    }
    else if ( msg == "TpmsSetting" ) {
    }
    else if ( msg == "LogOn" ) {
	cout << __FILE__ << ":" << __LINE__ << " & " << endl;
	setWindowActive(m_pRacev->m_pWinLogOn);
    }
    else {}
}

bool Worker::isWindowActive(QObject* pWindow) {
    if ( "true" == QQmlProperty::read(pWindow, "active") )
	return true;
    else return false;
}

void Worker::setWindowActive(QObject* pWindow) {
    // presume pWindow is not null
#if 1
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

/*
 * determine if has alarm record
 */
bool Worker::hasAlarmRecord(quint32 can_addr) {
    if ( can_addr == ALM_MSG_00 || can_addr == ALM_MSG_01
	|| can_addr == ALM_MSG_02 || can_addr == ALM_MSG_03
	|| can_addr == DCDC_MSG00 || can_addr == BCU_ER_MSG01
	|| can_addr == BMS_CMUERR_MSG01 || can_addr == PCU_ST_SYS_3
	|| can_addr == PCU_ST_SYS_4
    )
	return true;
    else
	return false;
}

//#define PRINT_UNIDENTIFIED_ADDR_
void Worker::onSignalCANFrame(quint32 can_addr, QCanBusFrame* pframe) {
    int rc;
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
    QString str_can_addr;
#endif
#define EN_CONSOLE_ // tracing charging sequence,
#if defined ( EN_CONSOLE_ )
    QByteArray payload;
#endif

#if 0 //defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << "-" << endl;
#endif
    Info* p_info = m_pRacev->m_pInfo;
    try {
	// TODO: most frequent on the top
	// TODO: message throughout application execution

	// alarm record archiving
	if ( hasAlarmRecord(can_addr) ) {
	    // TODO: check if any change,
	    // if there is any change, keep a record
#if 0 //defined ( QT_DEBUG )
	    cout << __func__ << ":" << __LINE__
		<< " id "
		<< "0x" << hex << setfill('0') << setw(8) << can_addr
		<< " checking..." << endl;
#endif
	}

	// notion: "core message", GUI not related
	switch ( can_addr ) {
	    case VCU_PWR_STATUS:
		rc = m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
		    &p_info->FrameVCU_PWR_STATUS, m_pRacev->m_pWinLogOn);
		if ( 1 == rc &&
		    ( m_pRacev->IsLogOn() == false
		      && isWindowActive(m_pRacev->m_pWinLogOn) == false ) ) { // logon
		    // QQmlProperty::write(m_pRacev->m_pWinLogOn, "visible", "true");
		    // QQmlProperty::write(m_pRacev->m_pWinBoot, "visible", "false");
		    setWindowActive(m_pRacev->m_pWinLogOn);
#if defined ( QT_DEBUG )
		    cout << __FILE__ << ":" << __LINE__ << " show logon " << endl;
#endif
		}
		else if ( 2 == rc && m_pRacev->IsLogOn() == true ) { // log out
		    // QQmlProperty::write(m_pRacev->m_pWinBoot, "visible", "true");
		    setWindowActive(m_pRacev->m_pWinBoot);
		    // QQmlProperty::write(m_pRacev->m_pWinLogOn, "visible", "false");
		    // QQmlProperty::write(m_pRacev->m_pWinMain, "visible", "false");
		    // TODO: should complete - change all window operations.
#if defined ( QT_DEBUG )
		    cout << __FILE__ << ":" << __LINE__ << " logout " << endl;
#endif
		    m_pRacev->LogOn(false);
		}
	    break;
#if defined ( EN_CONSOLE_ )
	    case BMS_VCU_Msg01:
		m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinCharging);
	    break;
	    case BMS_VCU_Msg03:
		m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		    &p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinCharging);
	    break;
	    case BMS_VCU_Msg04:
		m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		    &p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinCharging);
	    break;
	    case BMS_OBC_MSG01:
		// payload = p_info->FrameBMS_OBC_MSG01.payload();
		m_pRacev->m_pBMS_OBC_MSG01->updateMsg(
		    &p_info->FrameBMS_OBC_MSG01, nullptr);
	    break;
	    case ALM_MSG_00:
		m_pRacev->m_pALM_MSG_00->updateMsg(
		    &p_info->FrameALM_MSG_00, m_pRacev->m_pWinCharging);
	    break;

	    // case VCU_HMI_Msg_1: // B4.3 ??
	    //	payload = p_info->FrameVCU_HMI_MSG01.payload();
	    // break;

#endif
	    default:
	    break;
	}

	if ( isWindowActive(m_pRacev->m_pWinMain) ) {
	    // TODO: check which active window, too, assume main
	    switch ( can_addr ) {
		case VCU_HMI_Msg_1:
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			&p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_3:
		    m_pRacev->m_pVCU_HMI_MSG03->updateMsg(
			&p_info->FrameVCU_HMI_MSG03, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_4:
		    updateMessage_VCU_HMI_Msg_4(&p_info->FrameVCU_HMI_MSG4);
		break;
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinMain);
		break;
		case BMS_VCU_Msg02:
		    //m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinMain);
		break;
		case PCU_ST_MOT_1:
		    m_pRacev->m_pPCU_ST_MOT_1->updateMsg(
			&p_info->FramePCU_ST_MOT_1, m_pRacev->m_pWinMain);
		break;
		case ALM_MSG_00:
		    // m_pRacev->m_pALM_MSG_00->updateMsg(
		//	&p_info->FrameALM_MSG_00, m_pRacev->m_pWinMain);
		break;
		case ALM_MSG_01:
		    m_pRacev->m_pALM_MSG_01->updateMsg(
			&p_info->FrameALM_MSG_01, m_pRacev->m_pWinMain);
		break;
		case ALM_MSG_02:
		    m_pRacev->m_pALM_MSG_02->updateMsg(
			&p_info->FrameALM_MSG_02, m_pRacev->m_pWinMain);
		break;
		case ALM_MSG_03:
		    m_pRacev->m_pALM_MSG_03->updateMsg(
			&p_info->FrameALM_MSG_03, m_pRacev->m_pWinMain);
		break;
		case VCU_PWR_STATUS:
		    m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
			&p_info->FrameVCU_PWR_STATUS, m_pRacev->m_pWinMain);
		break;
		default:// assume there are CANBus frame ids
#if 0 //defined ( PRINT_UNIDENTIFIED_ADDR_ )
		    str_can_addr = QString::number( can_addr, 16 );
		    cout << __func__ << ":" << __LINE__ << " 0x"
		    << str_can_addr.toStdString() << " "
		    << static_cast<void*>(pframe)
		    << endl;
		    //cout<<__FILE__ << ":" << __LINE__<< "-" <<endl;
#endif
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinLogOn) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinChart) ) {
	    switch ( can_addr ) {
		case VCU_HMI_Msg_1:
		    // updateMessage_VCU_HMI_Msg_1(&p_info->FrameVCU_HMI_MSG01);
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			    &p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinChart);
		break;
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			    &p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinChart);
		break;
		case VCU_HMI_Msg_3:
		    m_pRacev->m_pVCU_HMI_MSG03->updateMsg(
			    &p_info->FrameVCU_HMI_MSG03, m_pRacev->m_pWinChart);
		break;
		case VCU_HMI_Msg_4:
		    updateMessage_VCU_HMI_Msg_4(&p_info->FrameVCU_HMI_MSG4);
		break;
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinChart);
		break;
		case BMS_VCU_Msg02:
		    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
			&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinChart);
		break;
		default:// assume there are CANBus frame ids
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
		    str_can_addr = QString::number( can_addr, 16 );
		    cout << __func__ << ":" << __LINE__ << " 0x"
		    << str_can_addr.toStdString() << " "
		    << static_cast<void*>(pframe)
		    << endl;
		    //delete pframe;
		    // TODO: make it clear double free issue
#endif
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinDeploy) ) {
	    switch ( can_addr ) {
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDeploy);
		break;
		case BMS_VCU_Msg02:
		    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
			&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinDeploy);
		break;
		default:// assume there are CANBus frame ids
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
		    str_can_addr = QString::number( can_addr, 16 );
		    cout << __func__ << ":" << __LINE__ << " 0x"
		    << str_can_addr.toStdString() << " "
		    << static_cast<void*>(pframe)
		    << endl;
		    //delete pframe;
		    // FIXME: make sure no double free issue
		    //cout<<__FILE__ << ":" << __LINE__<< "-" <<endl;
#endif
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinCharging) ) {
#if 0
	    QString str_can_addr1 = QString::number( can_addr, 16 );
	    cout << __func__ << ":" << __LINE__ << " 0x"
		<< str_can_addr1.toStdString() << endl;
#endif
	    switch ( can_addr ) {
		//
		//case BMS_VCU_Msg01:
		 //   m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinCharging);
		// break;
		case BMS_VCU_Msg03:
		    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
			&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinCharging);
		break;
		//case BMS_VCU_Msg04:
		 //   m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinCharging);
		//break;
		case BMS_OBC_MSG01:
		    m_pRacev->m_pBMS_OBC_MSG01->updateMsg(
			&p_info->FrameBMS_OBC_MSG01, m_pRacev->m_pWinCharging);
		break;
#if 1 // consider whole charging operations
		// required all the time, not just charging win on top.
		// case ALM_MSG_00:
		  //  m_pRacev->m_pALM_MSG_00->updateMsg(
		//	&p_info->FrameALM_MSG_00, m_pRacev->m_pWinCharging);
		// break;
		case VCU_HMI_Msg_1: // B4.3
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinCharging);
		break;
		case VCU_PWR_STATUS:
		    m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
			&p_info->FrameVCU_PWR_STATUS, m_pRacev->m_pWinCharging);
		break;
#endif
		default:// assume there are CANBus frame ids
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
		    str_can_addr = QString::number( can_addr, 16 );
		    cout << __func__ << ":" << __LINE__ << " 0x"
		    << str_can_addr.toStdString() << " "
		    << static_cast<void*>(pframe)
		    << endl;
#endif
		break;
	    }
	}
	//else if ( isWindowActive(m_pRacev->m_pWinEngineering) ) {
	    // TODO: handle the specific cam frame of interest
	//}
	else if ( isWindowActive(m_pRacev->m_pWinTraction) ) {
	    switch ( can_addr ) {
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinTraction);
		break;
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinTraction);
		break;
		case PCU_IO_SIG00:
		     m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinTraction);
		break;

		case PCU_ST_SYS_1:
		    m_pRacev->m_pPCU_ST_SYS_1->updateMsg(
			&p_info->FramePCU_ST_SYS_1, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_SYS_2:
		    m_pRacev->m_pPCU_ST_SYS_2->updateMsg(
			&p_info->FramePCU_ST_SYS_2, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_SYS_3:
		    m_pRacev->m_pPCU_ST_SYS_3->updateMsg(
			&p_info->FramePCU_ST_SYS_3, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_SYS_4:
		    m_pRacev->m_pPCU_ST_SYS_4->updateMsg(
			&p_info->FramePCU_ST_SYS_4, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_MOT_1:
		    m_pRacev->m_pPCU_ST_MOT_1->updateMsg(
			&p_info->FramePCU_ST_MOT_1, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_MOT_2:
		     m_pRacev->m_pPCU_ST_MOT_2->updateMsg(
			&p_info->FramePCU_ST_MOT_2, m_pRacev->m_pWinTraction);
		break;
		case PCU_ST_MOT_3:
		    // TODO: to be defined.
		    m_pRacev->m_pPCU_ST_MOT_3->updateMsg(
			&p_info->FramePCU_ST_MOT_3, m_pRacev->m_pWinTraction);
		break;
		case PCU_CMD_SYS_1:
		    m_pRacev->m_pPCU_CMD_SYS_1->updateMsg(
			&p_info->FramePCU_CMD_SYS_1, m_pRacev->m_pWinTraction);
		break;
		case PCU_CMD_MOT_1:
		    m_pRacev->m_pPCU_CMD_MOT_1->updateMsg(
			&p_info->FramePCU_CMD_MOT_1, m_pRacev->m_pWinTraction);
		break;
		case PCU_CMD_MOT_2:
		    m_pRacev->m_pPCU_CMD_MOT_2->updateMsg(
			&p_info->FramePCU_CMD_MOT_2, m_pRacev->m_pWinTraction);
		break;
		case PCU_CMD_MOT_3:
		    m_pRacev->m_pPCU_CMD_MOT_3->updateMsg(
			&p_info->FramePCU_CMD_MOT_3, m_pRacev->m_pWinTraction);
		break;

		case VCU_DIAG01:
		    m_pRacev->m_pVCU_DIAG01->updateMsg(
			&p_info->FrameVCU_DIAG01, m_pRacev->m_pWinTraction);
		break;
		case VCU_DIAG02:
		    m_pRacev->m_pVCU_DIAG02->updateMsg(
			&p_info->FrameVCU_DIAG02, m_pRacev->m_pWinTraction);
		break;

		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinBrake) ) {
	    switch ( can_addr ) {
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBrake);
		break;
		case VCU_IOSIG_MSG:
		    // TODO: to be verified
		break;
		case PCU_IO_SIG00:
		    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinBrake);
		break;
		case VCU_DIAG01:
		    m_pRacev->m_pVCU_DIAG01->updateMsg(
			&p_info->FrameVCU_DIAG01, m_pRacev->m_pWinBrake);
		break;
		case VCU_DIAG02:
		    m_pRacev->m_pVCU_DIAG02->updateMsg(
			&p_info->FrameVCU_DIAG02, m_pRacev->m_pWinBrake);
		break;
		case BCU_VCU_MSG0:
		    m_pRacev->m_pBCU_VCU_MSG0->updateMsg(
			&p_info->FrameBCU_VCU_MSG0, m_pRacev->m_pWinBrake);
		break;
		default:
		break;
	    }
	    // TODO: design (window, address) association instead of
	    // long-wind switch case statements.
	}
	else if ( isWindowActive(m_pRacev->m_pWinSteering) ) {
	    switch ( can_addr ) {
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinSteering);
		break;
		case VCU_IOSIG_MSG:
		    // TODO: to be verified
		break;
		case PCU_IO_SIG00:
		    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinSteering);
		break;
		case VCU_DIAG02:
		    m_pRacev->m_pVCU_DIAG02->updateMsg(
			&p_info->FrameVCU_DIAG02, m_pRacev->m_pWinSteering);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinPcuAnalog) ) {
	    switch ( can_addr ) {
		case PCU_IO_SIG00:
		    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinPcuAnalog);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinBcuAnalog) ) {
	    switch ( can_addr ) {
		case BCU_VCU_MSG0:
		    m_pRacev->m_pBCU_VCU_MSG0->updateMsg(
			&p_info->FrameBCU_VCU_MSG0, m_pRacev->m_pWinBcuAnalog);
		break;
		case BCU_VCU_SMD:
		    m_pRacev->m_pBCU_VCU_SMD->updateMsg(
			&p_info->FrameBCU_VCU_SMD, m_pRacev->m_pWinBcuAnalog);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinVcuAnalog) ) {
	    switch ( can_addr ) {
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinVcuAnalog);
		break;
		case BMS_VCU_Msg03:
		    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
			&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinVcuAnalog);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinBmsAnalog) ) {
	    switch ( can_addr ) {
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBmsAnalog);
		break;
		case BCU_ER_MSG01:
		    m_pRacev->m_pBCU_ER_MSG01->updateMsg(
			&p_info->FrameBCU_ER_MSG01, m_pRacev->m_pWinBmsAnalog);
		break;
		case BMS_CMUERR_MSG01:
		    m_pRacev->m_pBMS_CMUERR_MSG01->updateMsg(
			&p_info->FrameBMS_CMUERR_MSG01, m_pRacev->m_pWinBmsAnalog);
		break;
		case BMS_VCU_Msg02:
		    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
			&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinBmsAnalog);
		break;
		case BMS_VCU_Msg03:
		    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
			&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinBmsAnalog);
		break;
		case BMS_VCU_Msg04:
		    m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
			&p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinBmsAnalog);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinPcuDigital) ) {
	    switch ( can_addr ) {
		case PCU_IO_SIG00:
		    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinPcuDigital);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinBcuDigital) ) {
	    switch ( can_addr ) {
		case BCU_VCU_MSG0:
		    m_pRacev->m_pBCU_VCU_MSG0->updateMsg(
			&p_info->FrameBCU_VCU_MSG0, m_pRacev->m_pWinBcuDigital);
		break;
		case BCU_VCU_SMD:
		    m_pRacev->m_pBCU_VCU_SMD->updateMsg(
			&p_info->FrameBCU_VCU_SMD, m_pRacev->m_pWinBcuDigital);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinVcuDigital) ) {
	    switch ( can_addr ) {
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinVcuDigital);
		break;
		case BMS_VCU_Msg03:
		    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
			&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinVcuDigital);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinBmsDigital) ) {
	    switch ( can_addr ) {
		case BCU_ER_MSG01:
		    m_pRacev->m_pBCU_ER_MSG01->updateMsg(
			&p_info->FrameBCU_ER_MSG01, m_pRacev->m_pWinBmsDigital);
		break;
		case BMS_VCU_Msg04:
		    m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
			    &p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinBmsDigital);
		break;
		case BMS_VCU_Msg02:
		    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
			    &p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinBmsDigital);
		break;
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBmsDigital);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinDcdc) ) {
	    switch ( can_addr ) {
		case DCDC_MSG00:
		    m_pRacev->m_pDCDC_MSG00->updateMsg(
			&p_info->FrameDCDC_MSG00, m_pRacev->m_pWinDcdc);
		break;
		case BMS_VCU_Msg01:
		    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
			    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDcdc);
		break;
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			    &p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinDcdc);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinDiagnose) ) {
	    // TODO: handle the specific cam frame of interest
	    switch ( can_addr ) {
		case BMS_VCU_Msg03:
		    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
			&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinDiagnose);
		break;
		case PCU_IO_SIG00:
		    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
			&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinDiagnose);
		break;
		case BCU_VCU_MSG0:
		    m_pRacev->m_pBCU_VCU_MSG0->updateMsg(
			&p_info->FrameBCU_VCU_MSG0, m_pRacev->m_pWinDiagnose);
		break;
		case BCU_ER_MSG01:
		    m_pRacev->m_pBCU_ER_MSG01->updateMsg(
			&p_info->FrameBCU_ER_MSG01, m_pRacev->m_pWinDiagnose);
		break;
		default:// assume there are CANBus frame ids
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
		    str_can_addr = QString::number( can_addr, 16 );
		    cout << __func__ << ":" << __LINE__ << " 0x"
		    << str_can_addr.toStdString() << " "
		    << static_cast<void*>(pframe)
		    << endl;
#endif
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinTpms) ) {
	    switch ( can_addr ) {
		case TPMS_MSG01:
		    m_pRacev->m_pTPMS_MSG01->updateMsg(
			&p_info->FrameTPMS_MSG01, m_pRacev->m_pWinTpms);
		break;
		case TPMS_MSG02:
		    m_pRacev->m_pTPMS_MSG02->updateMsg(
			&p_info->FrameTPMS_MSG02, m_pRacev->m_pWinTpms);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinUnlock) ) {
	    // cout << __FILE__ << ":" << __LINE__ << "-" << endl;
	    switch ( can_addr ) {
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			    &p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinUnlock);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinTpms) ) {
	    // cout << __FILE__ << ":" << __LINE__ << "-" << endl;
	    switch ( can_addr ) {
		case TPMS_MSG01: // TODO:
		    m_pRacev->m_pTPMS_MSG01->updateMsg(
			&p_info->FrameTPMS_MSG01, m_pRacev->m_pWinTpms);
		break;
		case TPMS_MSG02:
		    m_pRacev->m_pTPMS_MSG02->updateMsg(
			&p_info->FrameTPMS_MSG02, m_pRacev->m_pWinTpms);
		break;
		default:
		break;
	    }
	}
	else if ( isWindowActive(m_pRacev->m_pWinIconDesc) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinAlarmRecord) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinAlarmStatistics) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinSystemLog) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinCellAlarmRecord) ) {
	}
	else if (
	    isWindowActive(m_pRacev->m_pWinVehicleInformationRecord) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinChargeTrippedRecord) ) {
	}
	else if ( isWindowActive(m_pRacev->m_pWinHistory) ) {
	}
	else { }
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

void Worker::onSignalErrorFrame(uint direction, uint stat, uint rx_err_cnt, uint tx_err_cnt) {
    try {
	// FIXME: not complains until bus stop
	if ( 128 <= rx_err_cnt && 128 <= tx_err_cnt ) {
	    cout << __func__ << ":" << __LINE__ << " err "
		<< setfill('0') << setw(1) << direction << " "
		<< setfill('0') << setw(1) << stat << " "
		<< setfill('0') << setw(3) << rx_err_cnt << " "
		<< setfill('0') << setw(3) << tx_err_cnt
		<< endl;
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what();
    }
    return;
}

// FIXME: too early to fire
void Worker::onSignalLoadCompleted(const QString &msg) {
    qint64 ts = 0;
    try {
	ts = QDateTime::currentMSecsSinceEpoch();
	cout << __func__ << ":" << __LINE__
	    << " takes " << ( ts - m_pRacev->m_iStartUpTimeStamp ) << " ms "
	    << msg.toStdString() << endl;
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

/*
 * passing QString item
 * onSignalUnlock is 'on demand' ( user click )
 * while onTickSlope is repetitive
 *
 */
void Worker::onSignalUnlock(const QString &item, const QString &unlock) {
    QCanBusFrame frame_tx;
    QString s_slope; // TODO: hardware integration, get the slope
    QString s_lock; double slope_reading; uint16_t slope_value;
    int i_item = 0, i_unlock = 0;
    bool ok;
    try {
	//ts = QDateTime::currentMSecsSinceEpoch();
#if 0
	cout << __func__ << ":" << __LINE__
	    << " item " << item.toStdString()
	    << " unlock " << unlock.toStdString() << endl;
#endif
	i_item = item.toInt(&ok, 10);
	i_unlock = unlock.toInt(&ok, 10);
	if ( i_unlock ) {
	    m_pRacev->m_unlockBits |= (1<<(i_item+1));
	}
	else {
	    m_pRacev->m_unlockBits &= ~(1<<(i_item+1));
	}
	s_lock = QString("%1").arg(m_pRacev->m_unlockBits, 2, 16, QChar('0'));
#if 0
	cout << __func__ << ":" << __LINE__
	    << " i " << i_item << " lock " << i_unlock
	    << " b 0x" << hex << m_pRacev->m_unlockBits << std::dec
	    << " s_lock " << s_lock.toStdString()
	    << endl;
#endif
	slope_reading = m_pRacev->m_pInfo->m_fSlope;
	//cout << __func__ << ":" << __LINE__ << " "
	//    << std::setw(5) << setprecision(1) << fixed << slope_reading << " "
	//    << endl;
	slope_reading = ( slope_reading  + 100 ) * 10; // @see spec
	//cout << __func__ << ":" << __LINE__ << " " << slope_reading << " "
	//   << endl;
	slope_value = static_cast<uint16_t>(slope_reading);
	//cout << __func__ << ":" << __LINE__ << " " << slope_value << " "
	//    << endl;
	s_slope = QString("%1").arg((slope_value&0x00FF), 2, 16, QChar('0'))
	    + QString("%1").arg(((slope_value&0xFF00)>>8), 2, 16, QChar('0'));
	frame_tx.setFrameId(VCU_FN_DISABLE);
	frame_tx.setFrameType(QCanBusFrame::DataFrame);
	QString str = s_lock + "0000000000" + s_slope;
	QByteArray array2 = QByteArray::fromHex(str.toLatin1());
	frame_tx.setPayload(array2);
	reinterpret_cast<CanThread *>(m_pRacev->pCANBusReceiverThread)->Transmit(frame_tx);
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

void Worker::onSignalReset(const QString &msg) {
    QCanBusFrame frame_tx;
    QString s_reset;
    unsigned int i_reset = 0;

    try {
	//ts = QDateTime::currentMSecsSinceEpoch();
	// recording reset action? at (thread ) writing frame log
#if 0
	cout << __func__ << ":" << __LINE__
	    << " item " << item.toStdString()
	    << " unlock " << unlock.toStdString() << endl;
#endif
	// Assume reset command "no memory", one at a time
	if ( !msg.compare("DRVRT") ) {
	    i_reset |= 1;
	}
	else if ( !msg.compare("MTRTime") ) {
	    i_reset |= (1<<1);
	}
	else if ( !msg.compare("BRKdrvRT") ) {
	    i_reset |= (1<<2);
	}
	else if ( !msg.compare("BRKMVRT") ) {
	    i_reset |= (1<<3);
	}
	else if ( !msg.compare("HdDrvRT") ) {
	    i_reset |= (1<<4);
	}
	else if ( !msg.compare("HdMtrRT") ) {
	    i_reset |= (1<<5);
	}
	else {
	    // TODO:
	}
	s_reset = QString("%1").arg(i_reset, 2, 16, QChar('0'));
#if 0
	cout << __func__ << ":" << __LINE__
	    << " i_reset 0x" << setw(2) << hex << i_reset << std::dec
	    << " s_reset " << s_reset.toStdString()
	    << endl;
#endif
	frame_tx.setFrameId(VCU_DMRT_CLR);
	frame_tx.setFrameType(QCanBusFrame::DataFrame);
	QString str = s_reset + "00000000000000";
	QByteArray array2 = QByteArray::fromHex(str.toLatin1());
	frame_tx.setPayload(array2);
	reinterpret_cast<CanThread *>(m_pRacev->pCANBusReceiverThread)->Transmit(frame_tx);
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

/*
 * @see https://tinyurl.com/yxcmz9sx
 */
void Worker::onAlarmParameterChecked(int row, int col, bool checked) {
#if 1
	cout << __func__ << ":" << __LINE__
	    << " row " << row
	    << " col " << col
	    << " chk " << checked
	    << endl;
#endif
	// TODO:
    try {
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

#if defined ( CLOCK_THREAD_ )
/*
 * @see 020.ClockThread-ticking-jobs
 */
void Worker::onSignalTicksSec(unsigned int n_seconds) {
#if 0
    cout <<
	__FILE__ << "::" << __func__ <<":"<< __LINE__
	<< " #sec " << n_seconds << endl;
#endif
    // TODO: according to signal tick, do data logging
    // VCU 1st priority
    switch ( n_seconds ) {
	case 1:
	    emit signalAccelerometer();
	    emit signalTickSlope();
	    break;
	case 2: break;
	case 5:
	    emit signalLogVehicleInfo();
	    break;
	case 10: break;
	case 20: break;
	case 30: break;
	case 60:
	    emit signalSyncGpsTimeToHw();
	break;
    }
}

/*
 * send slope, repeatitively.
 */
void Worker::onTickSlope(void) {
    // cout << __func__ << ":" << __LINE__ << "+" << endl;
    QCanBusFrame frame_tx;
    QString s_slope; // TODO: hardware integration, get the slope
    QString s_lock;
    double slope_reading = m_pRacev->m_pInfo->m_fSlope;
    uint16_t slope_value;
    try {
	s_lock = QString("%1").arg(m_pRacev->m_unlockBits, 2, 16, QChar('0'));
	slope_reading = ( slope_reading  + 100 ) * 10; // @see spec
	slope_value = static_cast<uint16_t>(slope_reading);
	s_slope = QString("%1").arg((slope_value&0x00FF), 2, 16, QChar('0'))
	    + QString("%1").arg(((slope_value&0xFF00)>>8), 2, 16, QChar('0'));
	frame_tx.setFrameId(VCU_FN_DISABLE);
	frame_tx.setFrameType(QCanBusFrame::DataFrame);
	QString str = s_lock + "0000000000" + s_slope;
	QByteArray array2 = QByteArray::fromHex(str.toLatin1());
	frame_tx.setPayload(array2);
	reinterpret_cast<CanThread *>(m_pRacev->pCANBusReceiverThread)->Transmit(frame_tx);
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__
	    << " exception" << ex.what() << endl;
    }
    // cout << __func__ << ":" << __LINE__ << "-" << endl;
    return;
}

/*
 *
 */
void Worker::onSignalAccelerometer(void) {
    double x, y, z, roll;
    QString s_x, s_y, s_z, s_pitch, s_roll;
    int calibrate = 0, zero_position = 0;
    QVariant returnedValue;
    // TODO: find out why get 6911x via CAssistant every 180 ms instead of 1000 ms
    try {
	m_pRacev->m_pInfo->m_pGSensor->Get(
	    &x, &y, &z, &m_pRacev->m_pInfo->m_fSlope, &roll/*,&yaw*/);
	s_x = QString::number(static_cast<double>(x), 'f', 3);
	s_y = QString::number(static_cast<double>(y), 'f', 3);
	s_z = QString::number(static_cast<double>(z), 'f', 3);
	s_pitch = QString::number(m_pRacev->m_pInfo->m_fSlope, 'f', 1);
	s_roll = QString::number(static_cast<double>(roll), 'f', 1);

	QMetaObject::invokeMethod(m_pRacev->m_pWinDiagnose, "tickGSensor",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_x),
	    Q_ARG(QVariant, s_y),
	    Q_ARG(QVariant, s_z),
	    Q_ARG(QVariant, s_pitch),
	    Q_ARG(QVariant, s_roll),
	    Q_ARG(QVariant, 0/*s_yaw*/), // TODO:
	    Q_ARG(QVariant, calibrate),
	    Q_ARG(QVariant, zero_position));
#if 0 // display on main screen
	QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "tickGSensor",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_x),
	    Q_ARG(QVariant, s_y),
	    Q_ARG(QVariant, s_z),
	    Q_ARG(QVariant, s_pitch),
	    Q_ARG(QVariant, s_roll),
	    Q_ARG(QVariant, 0/*s_yaw*/), // TODO:
	    Q_ARG(QVariant, calibrate),
	    Q_ARG(QVariant, zero_position));
#endif
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
    // cout << __func__ << ":" << __LINE__ << "-" << endl;
    return;
}
#endif

#if defined ( GPS_THREAD_ )
void Worker::onSignalGPS(void) {
    QVariant returnedValue;
    QString s_latitude, s_longitude;
    QString s_dir_latitude, s_dir_longitude;

    // cout << __FILE__ << ":" << __LINE__ << " 1" << endl;
    if ( !isWindowActive(m_pRacev->m_pWinDiagnose) ) return;
    // cout << __FILE__ << ":" << __LINE__ << " 2" << endl;

    // Qt - Converting float to QString
    // @see https://tinyurl.com/y5sczpmn
    s_latitude.setNum(m_pInfo->latitude);
    s_longitude.setNum(m_pInfo->longitude);
    // QString from std string
    // @see https://tinyurl.com/y3l4ndfm
    s_dir_latitude = QString::fromStdString(m_pInfo->dir_latitude);
    s_dir_longitude = QString::fromStdString(m_pInfo->dir_longitude);

    QMetaObject::invokeMethod(m_pRacev->m_pWinDiagnose, "tickGPS",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_latitude),
	Q_ARG(QVariant, s_dir_latitude),
	Q_ARG(QVariant, s_longitude),
	Q_ARG(QVariant, s_dir_longitude));
    return;
}

// TODO: get time, capability, set gps time
// @see hidePowerCords
void Worker::onSyncGpsTimeToHw(void) {
    // cout << __FILE__ << ":" << __LINE__ << " +" << endl;
    // TODO:
    return;
    struct tm time = { 0 };
    int Year = 2019;
    int Month = 10;
    int Day = 16;
    int Hour = 11;
    int Minute = 51;
    int Second = 33;
    int rc = 0;

    time.tm_year = Year - 1900;
    time.tm_mon  = Month - 1;
    time.tm_mday = Day;
    time.tm_hour = Hour;
    time.tm_min  = Minute;
    time.tm_sec  = Second;

    if (time.tm_year < 0) time.tm_year = 0;

    time_t t = mktime(&time);

    if (t != static_cast<time_t>(t)-1)
	rc = stime(&t);
    if ( rc ) {
	cout << __FILE__ << ":" << __LINE__ << " "
	    << errno << ":[" << strerror(errno) << "]" << endl;
    }
    return;
}
#endif
