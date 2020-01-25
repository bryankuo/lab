#include <iostream>
#include <stdexcept>
#include <iomanip>
#include <cmath>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <string.h>
#include <syslog.h>

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

using namespace std;

Worker::Worker()
{
    //qDebug() << "Worker+";
}

Worker::Worker(QQmlApplicationEngine *pEngine, Racev* pRacev):
    p_engine(pEngine),
    m_pRacev(pRacev),
    m_pInfo(pRacev->m_pInfo),
    m_bIsRunning(true),
    m_iTicks2Sec(0),
    m_iTicks5Sec(0),
    m_iTicks10Sec(0),
    m_iTicks20Sec(0),
    m_iTicks30Sec(0),
    m_iTicks60Sec(0)
{
    cout << __FILE__ << ":" << __LINE__ << " Worker +" << endl;
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

void Worker::doWork(/*const QString &parameter*/) { // consider passing racev as parameter
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif

#if defined ( EN_SYSLOG_ )
    syslog(LOG_DEBUG, "%s", "start worker thread");
    // The use of closelog() is optional.
    // ( https://linux.die.net/man/3/syslog )
    // worked. debian9 is at /var/log/syslog or /var/log/debug
#endif
    do {
	sleep(1);
	m_iTicks2Sec++; m_iTicks5Sec++;
	m_iTicks10Sec++; m_iTicks20Sec++;
	m_iTicks30Sec++; m_iTicks60Sec++;
	//cout << __FILE__ << ":" << __LINE__ << " " << __func__ << "+"
	//	<< " tick " << setfill('0') << setw(2) << m_iTicks60Sec << endl;
	if ( 60 <= m_iTicks60Sec ) {
	    m_iTicks60Sec = 0;
	    emit signalTicksSec(60);
	}
	if ( 30 <= m_iTicks30Sec ) {
	    m_iTicks30Sec = 0;
	    emit signalTicksSec(30);
	}
	if ( 20 <= m_iTicks20Sec ) {
	    m_iTicks20Sec = 0;
	    emit signalTicksSec(20);
	}
	if ( 10 <= m_iTicks10Sec ) {
	    m_iTicks10Sec = 0;
	    emit signalTicksSec(10);
	}
	if ( 5 <= m_iTicks5Sec ) {
	    m_iTicks5Sec = 0;
	    emit signalTicksSec(5);
	}
	if ( 2 <= m_iTicks2Sec ) {
	    m_iTicks2Sec = 0;
	    emit signalTicksSec(2);
	}
	emit signalTicksSec(1);
    } while ( m_bIsRunning );
    // emit resultReady(result);
    emit workFinished();
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
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateSystemInfo", // disabled
            Qt::AutoConnection, /* https://goo.gl/kUjJva */
	    // maybe Qt::DirectConnection ?
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

#if 0
void Worker::updateFramePayloadQSize(QCanBusFrame& frame, int size) {
    QVariant returnedValue;
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateQBInfo", // disabled
        Qt::AutoConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, frame.payload().toHex(0)),
        Q_ARG(QVariant, size),
    Q_ARG(QVariant, 0/*Bsize*/));
}
#endif

#define EN_CHART_VOLT_TEMP
// FIXME: figure out why signal/slot not applies
/*
 *
 */
void Worker::updateMsg_BMS_Volt_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    QString s_cellVoltages[NUM_CELLS] = {nullptr};
    QVariant returnedValue; int i,x;
    Info* p_info = m_pRacev->m_pInfo;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = nullptr;

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    try {
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
#if 0 //defined ( QT_DEBUG )
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

#if defined ( EN_CHART_VOLT_TEMP ) // EN_INVOKE_METHOD_
	pCurrentWindow = p_racev->getActiveWindow();
	if ( pCurrentWindow == p_racev->m_pWinChart ) {
	    QMetaObject::invokeMethod(pCurrentWindow, "updateBMS_Volt_Msg01_cell1_7", // remains
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_cellVoltages[0]),
		Q_ARG(QVariant, s_cellVoltages[1]),
		Q_ARG(QVariant, s_cellVoltages[2]),
		Q_ARG(QVariant, s_cellVoltages[3]),
		Q_ARG(QVariant, s_cellVoltages[4]),
		Q_ARG(QVariant, s_cellVoltages[5]),
		Q_ARG(QVariant, s_cellVoltages[6]));

	    QMetaObject::invokeMethod(pCurrentWindow, "updateBMS_Volt_Msg01_cell8_14", // remains
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_cellVoltages[7]),
		Q_ARG(QVariant, s_cellVoltages[8]),
		Q_ARG(QVariant, s_cellVoltages[9]),
		Q_ARG(QVariant, s_cellVoltages[10]),
		Q_ARG(QVariant, s_cellVoltages[11]),
		Q_ARG(QVariant, s_cellVoltages[12]),
		Q_ARG(QVariant, s_cellVoltages[13]));
	}
#elif defined ( EN_PUSHING_REF2QML_ )
	if ( p_racev->isActiveWindow(p_racev->m_pWinChart) ) {
	    emit signalBmsVoltMSG01Cell00To06(
		s_cellVoltages[0],
		s_cellVoltages[1],
		s_cellVoltages[2],
		s_cellVoltages[3],
		s_cellVoltages[4],
		s_cellVoltages[5],
		s_cellVoltages[6]);

	    emit signalBmsVoltMSG01Cell07To13(
		s_cellVoltages[0],
		s_cellVoltages[1],
		s_cellVoltages[2],
		s_cellVoltages[3],
		s_cellVoltages[4],
		s_cellVoltages[5],
		s_cellVoltages[6]);
#if 0 //defined ( QT_DEBUG )
	    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " post emit " << endl;
#endif

	}
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    return;
}

/*
 *
 */
void Worker::updateMsg_BMS_Temp_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    QVariant returnedValue;
    Info* p_info = m_pRacev->m_pInfo;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = nullptr;

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    try {
	p_info->m_TemperatureMutex.lock();
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

#if defined ( EN_CHART_VOLT_TEMP ) // EN_INVOKE_METHOD_
	pCurrentWindow = p_racev->getActiveWindow();
	if ( pCurrentWindow == p_racev->m_pWinChart ) {
	    QMetaObject::invokeMethod(pCurrentWindow, "updateBMS_Temp_Msg01", // remains
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_info->cellTemperatures[pack][0]),
		Q_ARG(QVariant, p_info->cellTemperatures[pack][1]),
		Q_ARG(QVariant, p_info->cellTemperatures[pack][2]),
		Q_ARG(QVariant, p_info->cellTemperatures[pack][3]));
	}
#elif defined ( EN_PUSHING_REF2QML_ ) // FIXME:
	if ( p_racev->isActiveWindow(p_racev->m_pWinChart) ) {
	    emit signalBmsTempMSG01(
		p_info->cellTemperatures[pack][0],
		p_info->cellTemperatures[pack][1],
		p_info->cellTemperatures[pack][2],
		p_info->cellTemperatures[pack][3]);
	}
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    p_info->m_TemperatureMutex.unlock();
}

void Worker::updateWindow(QObject *pWindow) {
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = p_racev->getActiveWindow();
    // QVariant returnedValue;
#if defined ( QT_DEBUG )
    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " + " << endl;
#endif
    try {
#if defined ( EN_INVOKE_METHOD_ )
	QMetaObject::invokeMethod(pWindow, "loadMenuText", // TBD
	    Qt::DirectConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, m_pRacev->m_Locale));
#elif defined ( EN_PUSHING_REF2QML_ )

#if defined ( QT_DEBUG )
	cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " 1 " << endl;
#endif

	emit signalLoadMenuText(m_pRacev->m_Locale);
#endif
	if ( p_racev->isActiveWindow(p_racev->m_pWinMain) ) {
	    //
	    // FIXME: it is possible when frame still zero
	    //
	    // POC test
#if defined ( QT_DEBUG )
    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " 2 " << endl;
#endif

	    p_racev->m_pVCU_HMI_MSG01
		->updateMsg(nullptr, pCurrentWindow); // &p_info->FrameVCU_HMI_MSG01
	    p_racev->m_pVCU_HMI_MSG02->updateMsg(
		    nullptr); // &p_info->FrameVCU_HMI_MSG02
	    p_racev->m_pVCU_HMI_MSG03
		->updateMsg(nullptr, pCurrentWindow); // &p_info->FrameVCU_HMI_MSG03
	    p_racev->m_pVCU_HMI_MSG04
		->updateMsg(nullptr, pCurrentWindow); // &p_info->FrameVCU_HMI_MSG04
	    // note: some 'core' message has already update the screen
	    // FIXME:
	}

    } catch (const std::exception& ex) {
	cout << __FILE__ <<":"<< __LINE__ << " "
	    << __func__ << " exception " << ex.what() << endl;
    }
#if defined ( QT_DEBUG )
    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " - " << endl;
#endif
    return;
}

// consider polymorphism
/*
 * is used on 'active' refresh
 */
void Worker::updateDeploymentView(void) {
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< __func__ << " + " << endl;
#endif
    Info* p_info = m_pRacev->m_pInfo;
    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDeploy);
    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinDeploy);
    //cout<< __func__ << ": " << __LINE__ << "-" << endl;
    return;
}

// consider polymorphism
// this is triggered by notifyUpdate 'signal' / updateModel 'slot'
void Worker::updateChartView(void) {
    Info* p_info = m_pRacev->m_pInfo;
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinChart);
    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinChart);
    updateMsg_BMS_Volt_Msg01(m_pRacev->m_indexPack, m_pRacev->m_pWinChart);
    updateMsg_BMS_Temp_Msg01(m_pRacev->m_indexPack, m_pRacev->m_pWinChart);
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
#endif
    return;
}

void Worker::updateChargingView(void) {
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << endl;
#endif
    return;
}

void Worker::updateDiagnoseView(void) {
    QString s_imei;
    // Info* p_info = m_pRacev->m_pInfo;
    QObject* pDstVw = m_pRacev->m_pWinDiagnose;
    QVariant returnedValue;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = nullptr;

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif

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
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " imei ["
	<< s_imei.trimmed().toStdString() << "]" << endl;
#endif

#if defined ( EN_INVOKE_METHOD_ )
    pCurrentWindow = p_racev->getActiveWindow();
    if ( pCurrentWindow == p_racev->m_pWinDiagnose ) {
	QMetaObject::invokeMethod(pCurrentWindow, "loadImei", // TBD
	Qt::DirectConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_imei.trimmed()));
    }
#elif defined ( EN_PUSHING_REF2QML_ )
    emit signalDisplayIMEI(s_imei.trimmed());
// qmicli --device=/dev/cdc-wdm0 --device-open-proxy --dms-get-ids \
//  | grep -e "IMEI" | grep -oP "(?<=').*?(?=')" > /home/racev/IMEI.cfg
// grep a string between two single quotes
// ( https://stackoverflow.com/a/35202408 )
// Automatically execute script at Linux startup with Debian 9 (Stretch)
// ( https://is.gd/RZu8Ej )
#endif
    return;
}

//!
//! dequeue, update model(context), update, notify
//!
// slot connected by signal 'notifyUpdate'
void Worker::updateModel(void) {
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    // m_pRacev->m_CanvasMutex.unlock();
    // Info* p_info = m_pRacev->m_pInfo;
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
    if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinMain) ) {
	// TODO: or other application is on the top
	// Presume no other application on top
	// updateWindow(m_pRacev->m_pWinMain);
    }
    else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinChart) ) {
	// updateChartView(); // FIXME:
    }
    else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDeploy) ) {
	//cout<< __func__ <<":"<< __LINE__ << " +"<<endl;
	updateDeploymentView(); // testing, check if stay on top occurs
    }
    /* more to come ... */
    else {
	// qDebug() << "dashboard top 0";
    }
    // m_pRacev->m_CanvasMutex.unlock();
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
}

void Worker::quit() {
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
}

void Worker::onSignalAuth(const QString &entitlement) {
    QVariant returnedValue;
    QString msg_pswd_ng = "PASSWORD NG! x";
    QCanBusFrame frame_tx; QByteArray array2;
    QCanBusFrame frame_auth3; int logon;
    QString s_yr, s_mo, s_dt, s_hr, s_min, s_sec, str;
#if 0 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__
	<< " [" << entitlement.toStdString() << "]" << endl;
#endif

    // TODO: decode function
    // TODO: comparing with hash
    // TODO: a function and 'role' checking/selection
    // TODO: m_pRacev->isAuthorized(group, user, credential)
    if ( !entitlement.compare("1234") ) {

	// trick to make logon disappear such that
	// no flicker change screen
	m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);

	m_pRacev->setActiveWindow(m_pRacev->m_pWinMain);
	// NOTE: this will make window invisible on the debian9 taskbar.
	m_pRacev->LogOn(true);
	logon = 1;

#if defined ( CAN_TX_THREAD_ )
	emit signalTransmit(HMI_TM_MSG01, 1);
#endif

	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authPassed", // not CANBus related, keep watching unless is required to refactor
	    Qt::DirectConnection,
	    Q_RETURN_ARG(QVariant, returnedValue));
	    // Q_ARG(QVariant, logon));
#if defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__ << " " << __func__
	    << " auth " << logon << endl;
#endif
    }
    else {
	m_pRacev->LogOn(false);
	logon = 0;
	m_pRacev->num_logon_fail++;
	QString msg = msg_pswd_ng + QString::number( m_pRacev->num_logon_fail, 10 );
	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authFailed", // not CANBus related, keep watching unless is required to refactor
	    Qt::DirectConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, msg));
	    // Q_ARG(QVariant, logon));
#if defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__ << " " << __func__
	    << " auth " << logon << endl;
#endif
	if ( 2 < m_pRacev->num_logon_fail ) {
#define EN_BOOT_ACTIVELY_
#if defined ( EN_BOOT_ACTIVELY_ )
	    m_pRacev->LogOn(false);
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);
#endif

#if defined ( QT_DEBUG )
	    cout << __FILE__ << ":" << __LINE__
		<< " send auth " << m_pRacev->num_logon_fail
		<< endl;
#endif

#if defined ( CAN_TX_THREAD_ )
	    emit signalTransmit(HMI_TM_MSG01, 2);
#endif
	    m_pRacev->num_logon_fail = 0; // reset, assume receive sleep
	}
    }
}

void Worker::onSignalSessionTimeout(int seconds) {
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< __func__ << " + " << seconds << endl;
#endif

#if defined ( EN_BOOT_ACTIVELY_ )
    m_pRacev->LogOn(false);
    m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);
#endif

#if defined ( CAN_TX_THREAD_ )
    emit signalTransmit(HMI_TM_MSG01, 3);
#endif

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< __func__ << " - " << seconds << endl;
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

/*
 */
    // TODO: use qml objectName instead

void Worker::onOpenChildWindow(const QString &msg) {
    // In QT,how to distinguish debug and release in someway like preprocessor
    // ( https://is.gd/QYQKG2 )
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +"
	<< " " << msg.toStdString() << endl;
#endif
    if ( !msg.compare("Battery") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinDeploy);
	}
    }
    else if ( !msg.compare("ChargingStation") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinCharging);
	}
    }
    else if ( !msg.compare("TPMS") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinTpms);
	}
    }
    else if ( !msg.compare("Diagnosis") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinDiagnose);
	}
    }
    else if ( !msg.compare("UNLOCK") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinUnlock);
	}
    }

    else if ( !msg.compare("IconDesc") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinIconDesc);
	}
    }

    else if ( !msg.compare("vehicleInfoWindow") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinVehicle);
	}
    }
	else if ( !msg.compare("tractionWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinTraction);
	}
	else if ( !msg.compare("brakeWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBrake);
	}
	else if ( !msg.compare("steeringWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinSteering);
	}

	else if ( !msg.compare("pcuAnalog") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinPcuAnalog);
	}
	else if ( !msg.compare("bcuAnalogWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBcuAnalog);
	}
	else if ( !msg.compare("vcuAnalogWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinVcuAnalog);
	}
	else if ( !msg.compare("bmsAnalogWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBmsAnalog);
	}

	else if ( !msg.compare("pcuDigitalWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinPcuDigital);
	}
	else if ( !msg.compare("bcuDigitalWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBcuDigital);
	}
	else if ( !msg.compare("vcuDigitalWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinVcuDigital);
	}
	else if ( !msg.compare("bmsDigitalWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinBmsDigital);
	}
	else if ( !msg.compare("dcDcWindow") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinDcdc);
	}

    else if ( !msg.compare("historyWindow") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinHistory);
	}
    }
	else if ( !msg.compare("alarmRecordWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinAlarmRecord);
	}
	else if ( !msg.compare("alarmStatisticsWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinAlarmStatistics);
	}
	else if ( !msg.compare("sysLogWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinSystemLog);
	}
	else if ( !msg.compare("cellAlarmRecWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinCellAlarmRecord);
	}
	else if ( !msg.compare("vehicleInfoRecordWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinVehicleInformationRecord);
	}
	else if ( !msg.compare("chargeTrippedRecordWin") ) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinChargeTrippedRecord);
	}

    else if ( !msg.compare("Parameters") ) {
	if( m_pRacev->m_pInfo->speed <= 0 ) {
	    // only allowed when standing still
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinParameters);
	}
    }
	else if ( !msg.compare("GeneralParameters")
	    && m_pRacev->m_pWinGeneralParameters) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinGeneralParameters);
	}
	else if ( !msg.compare("ChargeParameters")
	    && m_pRacev->m_pWinChargeParameters) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinChargeParameters);
	}
	else if ( !msg.compare("AlarmParameters")
	    && m_pRacev->m_pWinAlarmParameters) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinAlarmParameters);
	    // directly access QML ListModel from C++
	}
	else if ( !msg.compare("HmiParameters")
	    && m_pRacev->m_pWinHmiParameters) { // FIXME: extra check may be unecessary
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinHmiParameters);
	}
	else if ( !msg.compare("TpmsSetting")
	    && m_pRacev->m_pWinTyreParameters) {
	    m_pRacev->setActiveWindow(m_pRacev->m_pWinTyreParameters);
	}

    else if ( !msg.compare("LogOn")
        && m_pRacev->m_pWinLogOn) {
	m_pRacev->setActiveWindow(m_pRacev->m_pWinLogOn);
    }
    else if ( !msg.compare("Boot")
        && m_pRacev->m_pWinBoot ) {
	m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);
    }
    else { }
}

void Worker::onSignalPack(const QString &msg, int index) {
    QVariant returnedValue;
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__
	<< " " << msg.toStdString() << ", " << index << " "
	<< m_pRacev->m_pWinChart
	<< endl;
#endif

    m_pRacev->m_selectPack = msg;
    m_pRacev->m_indexPack = index;

    // continue using invokeMethod.
    // for those CANBus related use signal/slot as much as possible
    QMetaObject::invokeMethod(m_pRacev->m_pWinChart, "setPack", // not CANBus related, keep watching unless is required to refactor
    Qt::DirectConnection,
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, msg),
    Q_ARG(QVariant, index)); // index, pack, zero-based

    updateMsg_BMS_Volt_Msg01(index, m_pRacev->m_pWinChart);
    // set chart data
    // QQmlProperty::write(m_pRacev->m_pWinChart, "visible", "true");
    // TODO: check for those calling QQmlProperty::write
    m_pRacev->setActiveWindow(m_pRacev->m_pWinChart);
}

// update view from current model
// ( switch and instantly updated by updateModel )
// TODO: by qml objectName
// FIXME: validate QObject pointer if changed after open/close
void Worker::onSignalActive(const QString &msg) {
    QObject *pWindow = m_pRacev->m_pRoot->findChild<QObject*>(msg); // objectName

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< msg.toStdString() << " [" << pWindow << "]" << endl;
#endif
    m_pRacev->m_CanvasMutex.lock();
    if ( !msg.compare("bootWindow") ) {
#if 0 //defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__
	    << " " << msg.toStdString() << endl;
#endif
	m_pRacev->m_pWinBoot = pWindow;
    }
    else if ( msg == "LogOn" ) {
#if 0 //defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__
	    << " " << msg.toStdString() << endl;
#endif
	m_pRacev->m_pWinLogOn = pWindow;
    }
    else if ( !msg.compare("hmiroot") ) {
	m_pRacev->m_pWinMain = pWindow;

	// TODO: find a better approach to tell threads start
	m_pRacev->m_bIsReady = true;

#if 0 //defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " ready" << endl;
#endif
	// TODO: trigger change locale
	// update whole window by required id, filed, member variable...etc.
	updateWindow(m_pRacev->m_pWinMain);
    }
    else if ( !msg.compare("deploymentWindow") ) {
	m_pRacev->m_pWinDeploy = pWindow;
	updateDeploymentView();
	// updateWindow(m_pRacev->m_pWinDeploy);
    }
	else if ( !msg.compare("chartWindow") ) {
	    m_pRacev->m_pWinChart = pWindow;
	    updateChartView();
	}

    else if ( !msg.compare("chargingWindow") ) {
	m_pRacev->m_pWinCharging = pWindow;
	// updateChargingView();
    }
    else if ( !msg.compare("tpmsWindow") ) {
	m_pRacev->m_pWinTpms = pWindow;
    }
    else if ( !msg.compare("diagnoseWindow") ) {
	m_pRacev->m_pWinDiagnose = pWindow;
	updateDiagnoseView();
    }
    else if ( !msg.compare("unlockWindow") ) {
	m_pRacev->m_pWinUnlock = pWindow;
    }
    else if ( !msg.compare("vehicleInfoWindow") ) {
	m_pRacev->m_pWinVehicle = pWindow;
    }
	else if ( !msg.compare("tractionWindow") ) {
	    m_pRacev->m_pWinTraction = pWindow;
	}
	else if ( !msg.compare("brakeWindow") ) {
	    m_pRacev->m_pWinBrake = pWindow;
	}
	else if ( !msg.compare("steeringWindow") ) {
	    m_pRacev->m_pWinSteering = pWindow;
	}

	else if ( !msg.compare("pcuAnalog") ) {
	    m_pRacev->m_pWinPcuAnalog = pWindow;
	}
	else if ( !msg.compare("bcuAnalogWindow") ) {
	    m_pRacev->m_pWinBcuAnalog = pWindow;
	}
	else if ( !msg.compare("vcuAnalogWindow") ) {
	    m_pRacev->m_pWinVcuAnalog = pWindow;
	}
	else if ( !msg.compare("bmsAnalogWindow") ) {
	    m_pRacev->m_pWinBmsAnalog = pWindow;
	}

	else if ( !msg.compare("pcuDigitalWindow") ) {
	    m_pRacev->m_pWinPcuDigital = pWindow;
	}
	else if ( !msg.compare("bcuDigitalWindow") ) {
	    m_pRacev->m_pWinBcuDigital = pWindow;
	}
	else if ( !msg.compare("vcuDigitalWindow") ) {
	    m_pRacev->m_pWinVcuDigital = pWindow;
	}
	else if ( !msg.compare("bmsDigitalWindow") ) {
	    m_pRacev->m_pWinBmsDigital = pWindow;
	}
	else if ( !msg.compare("dcDcWindow") ) {
	    m_pRacev->m_pWinDcdc = pWindow;
	}

    else if ( !msg.compare("iconDescriptionWindow") ) {
	m_pRacev->m_pWinIconDesc = pWindow;
    }

    else if ( !msg.compare("historyWindow") ) {
	m_pRacev->m_pWinHistory = pWindow;
    }
	else if ( !msg.compare("alarmRecordWin") ) {
	    m_pRacev->m_pWinAlarmRecord = pWindow;
	}
	else if ( !msg.compare("alarmStatisticsWin") ) {
	    m_pRacev->m_pWinAlarmStatistics = pWindow;
	}
	else if ( !msg.compare("sysLogWin") ) {
	    m_pRacev->m_pWinSystemLog = pWindow;
	}
	else if ( !msg.compare("cellAlarmRecWin") ) {
	    m_pRacev->m_pWinCellAlarmRecord = pWindow;
	}
	else if ( !msg.compare("vehicleInfoRecordWin") ) {
	    m_pRacev->m_pWinVehicleInformationRecord = pWindow;
	}
	else if ( !msg.compare("chargeTrippedRecordWin") ) {
	    m_pRacev->m_pWinChargeTrippedRecord = pWindow;
	}

    else if ( !msg.compare("parametersWindow") ) {
	m_pRacev->m_pWinParameters = pWindow;
    }
	else if ( !msg.compare("generalWindow") ) {
	    m_pRacev->m_pWinGeneralParameters = pWindow;
	}
	else if ( !msg.compare("chargeWindow") ) {
	    m_pRacev->m_pWinChargeParameters = pWindow;
	}
	else if ( !msg.compare("alarmWindow") ) {
	    m_pRacev->m_pWinAlarmParameters = pWindow;
	}
	else if ( !msg.compare("hmiSettingWindow") ) {
	    m_pRacev->m_pWinHmiParameters = pWindow;
	}
	else if ( !msg.compare("tyresWindow") ) {
	    m_pRacev->m_pWinTyreParameters = pWindow;
	}

    else {
#if defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " ? " << endl;
#endif
    }
    m_pRacev->m_CanvasMutex.unlock();
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
#endif
}

/*
 * to deal with those windows opened via menu
 * ( they all have a parent )
    for each qml window, it is responsible for its own closing,
    ( close and signal ... either use our own or, use 'closing' QT 5.1 later)
    @see https://tinyurl.com/ykxcjv9q
    the worker object handles the rest of jobs.
 */
void Worker::onSignalWindowClose(const QString &msg) {
    QObject *pWindow = m_pRacev->m_pRoot->findChild<QObject*>(msg); // objectName
    QObject *pParentWindow = pWindow->parent(); // nullptr;

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< msg.toStdString() << "[" << pWindow << "]" << endl;
#endif
    Q_ASSERT( pWindow != nullptr );

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " * "
        << pParentWindow << "[" << pParentWindow->objectName().toStdString() << "]" << endl;
#endif
    // keep aligned with menu structure
    if ( !msg.compare("hmiroot") ) {
	pParentWindow = m_pRacev->m_pWinLogOn;
    }
    else if ( !msg.compare("chargingWindow") || !msg.compare("deploymentWindow")
	|| !msg.compare("tpmsWindow") || !msg.compare("diagnoseWindow")
	|| !msg.compare("unlockWindow") || !msg.compare("iconDescriptionWindow")
	|| !msg.compare("vehicleInfoWindow") || !msg.compare("historyWindow")
	|| !msg.compare("parametersWindow") ) {
	pParentWindow = m_pRacev->m_pWinMain;
    }
    else if ( !msg.compare("chartWindow") ) {
	pParentWindow = m_pRacev->m_pWinDeploy;
	// m_pRacev->m_pWinChart = nullptr; // do not set null
#if 0 //defined ( QT_DEBUG )
	cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - set chart null" << endl;
#endif
    }
    else if ( !msg.compare("tractionWindow")
	|| !msg.compare("brakeWindow") || !msg.compare("steeringWindow")
	// analog
	|| !msg.compare("pcuAnalog") || !msg.compare("bcuAnalogWindow")
	|| !msg.compare("vcuAnalogWindow")
	|| !msg.compare("bmsAnalogWindow")
	// digital
	|| !msg.compare("pcuDigitalWindow")
	|| !msg.compare("bcuDigitalWindow")
	|| !msg.compare("vcuDigitalWindow")
	|| !msg.compare("bmsDigitalWindow")
	|| !msg.compare("dcDcWindow") ) {
	pParentWindow = m_pRacev->m_pWinVehicle;
    }
    else if ( !msg.compare("alarmRecordWin")
	|| !msg.compare("alarmStatisticsWin")
	|| !msg.compare("sysLogWin")
	|| !msg.compare("cellAlarmRecWin")
	|| !msg.compare("vehicleInfoRecordWin")
	|| !msg.compare("chargeTrippedRecordWin") ) {
	pParentWindow = m_pRacev->m_pWinHistory;
    }
    else if ( !msg.compare("generalWindow") || !msg.compare("alarmWindow")
	|| !msg.compare("chargeWindow") || !msg.compare("hmiSettingWindow")
	|| !msg.compare("tyresWindow") ) {
	pParentWindow = m_pRacev->m_pWinParameters;
    }
    else {
    }

    if ( pParentWindow ) {
	m_pRacev->setActiveWindow(pParentWindow);
    }
// TODO: !msg.compare("bootWindow")
}

void Worker::onSignalQmlCompleted(const QString &msg) {
    // m_pRacev->m_bIsReady = true;
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< msg.toStdString() << endl;
#endif
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

/*
 *
 * notes:
 * invokeMethod in other thread:
 * @see https://tinyurl.com/t65jahw
 * Qt Connection Type:
 * @see https://tinyurl.com/y2r2zt8r
 *
 */
//#define PRINT_UNIDENTIFIED_ADDR_
void Worker::onSignalCANFrame(quint32 can_addr, QCanBusFrame* pframe) {
    int rc;
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
    QString str_can_addr;
#endif
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " + " << endl;
#endif

    // TODO: verify if canvas mutex is required, if not,
    // remove it.
    m_pRacev->m_CanvasMutex.lock();

    Info* p_info = m_pRacev->m_pInfo;
    try {
#if 0 //defined ( QT_DEBUG )
	cout << __FILE__ <<":"<< __LINE__ << " " << __func__
	    << " id " << hex << setfill('0') << setw(8) << can_addr << dec
	    << endl;
#endif

	// TODO: most frequent on the top
	// TODO: message throughout application execution

	// alarm record archiving
	if ( hasAlarmRecord(can_addr) ) {
	    // TODO: check if any change,
	    // if there is any change, keep a record
	}

	// notion: "core message", GUI not related, it is "model"
	switch ( can_addr ) { // core
	    case VCU_PWR_STATUS:
		rc = m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
		    &p_info->FrameVCU_PWR_STATUS, nullptr/*m_pRacev->m_pWinLogOn*/);
		switch ( p_info->bms_state ) {
#if defined ( CHARGE_SHOW_ACTIVE_ )
		    case BMS_STATE_CHARGE:
			if ( 1 == rc
			    && ( false == m_pRacev->isActiveWindow(
				    m_pRacev->m_pWinCharging ) ) ) {
			    m_pRacev->setActiveWindow(m_pRacev->m_pWinCharging);
			    cout << __FILE__ << ":" << __LINE__ << " charging logon" << endl;
			}
			else if ( 2 == rc
			    && ( false == m_pRacev->isActiveWindow(
				    m_pRacev->m_pWinBoot ) ) ) {
				m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);
				cout << __FILE__ << ":" << __LINE__ << " charging logout" << endl;
			}
			else {
			}
		    break;
#endif
		    case BMS_STATE_IDLE:
		    case BMS_STATE_DISCHARGE:
		    case BMS_STATE_ABNORMAL:
		    default: // default behaviour
		    // TODO: back from BMS_STATE_CHARGE
#if defined ( NORMAL_SCENARIO_ )
		    if ( 1 == rc ) {
			if ( m_pRacev->IsLogOn() == false ) {
			    // logon
			    if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinLogOn) == false ) {
				m_pRacev->setActiveWindow(m_pRacev->m_pWinLogOn);
				// cout << __FILE__ << ":" << __LINE__ <<
				//    " show logon" << endl;
			    }
			    else {
				// cout << __FILE__ << ":" << __LINE__ <<
				//    " already logon" << endl;
			    }
			}
			else {
			    // suppose back from charging
			    if ( p_info->key_position == KEY_ON
				|| p_info->key_position == KEY_ACC ) {
			    }
			}
		    }
		    // as long as receiving sleep, sleep.
		    else if ( 2 == rc ) {
			m_pRacev->LogOn(false);
			// log out
			if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBoot) == false ) {
			    m_pRacev->setActiveWindow(m_pRacev->m_pWinBoot);
			    // TODO: should complete - change all window operations.
			    cout << __FILE__ << ":" << __LINE__ << " logout " << endl;
			}
		    }
#endif
		    break;
		}
	    break;
	    case BMS_VCU_Msg01:
		m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		    &p_info->FrameBMS_VCU_MSG01, nullptr );
	    break;
	    case BMS_VCU_Msg03:
		m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		    pframe, nullptr ); // &p_info->FrameBMS_VCU_MSG03
	    break;
	    case BMS_VCU_Msg04:
		m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		    pframe, nullptr ); // &p_info->FrameBMS_VCU_MSG04
	    break;
	    case BMS_OBC_MSG01:
		m_pRacev->m_pBMS_OBC_MSG01->updateMsg(
		    pframe, nullptr); // &p_info->FrameBMS_OBC_MSG01
	    break;

	    // alarm is thought as a kind of 'core message'
	    case ALM_MSG_00:
		m_pRacev->m_pALM_MSG_00->updateMsg(
		    &p_info->FrameALM_MSG_00, nullptr);
	    break;
	    case ALM_MSG_01:
		m_pRacev->m_pALM_MSG_01->updateMsg(
		    &p_info->FrameALM_MSG_01, nullptr);
	    break;
	    case ALM_MSG_02:
		m_pRacev->m_pALM_MSG_02->updateMsg(
		    &p_info->FrameALM_MSG_02, nullptr);
	    break;
	    case ALM_MSG_03:
		m_pRacev->m_pALM_MSG_03->updateMsg(
		    &p_info->FrameALM_MSG_03, nullptr);
	    break;
	    case DCDC_MSG00: // ALM_MSG_04
		m_pRacev->m_pDCDC_MSG00->updateMsg(
		    &p_info->FrameDCDC_MSG00, nullptr);
	    break;

	    // case VCU_HMI_Msg_1: // B4.3 ??
	    //	payload = p_info->FrameVCU_HMI_MSG01.payload();
	    // break;
	    default:
	    break;
	}

	if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinMain) ) {
	    switch ( can_addr ) {
		case VCU_HMI_Msg_1:
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			pframe, m_pRacev->m_pWinMain);
#if 0 //defined ( QT_DEBUG )
		    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " 1 " << endl;
#endif
		break;
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
            &p_info->FrameVCU_HMI_MSG02);
		break;
		case VCU_HMI_Msg_3:
		    m_pRacev->m_pVCU_HMI_MSG03->updateMsg(
			&p_info->FrameVCU_HMI_MSG03, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_4:
		    m_pRacev->m_pVCU_HMI_MSG04->updateMsg(
			&p_info->FrameVCU_HMI_MSG04, m_pRacev->m_pWinMain);
		break;
		// case BMS_VCU_Msg01:
		//    m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinMain);
		// break;
		case BMS_VCU_Msg02:
		    //m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinMain);
		break;
		case PCU_ST_MOT_1:
		    m_pRacev->m_pPCU_ST_MOT_1->updateMsg(
			&p_info->FramePCU_ST_MOT_1, m_pRacev->m_pWinMain);
		break;
		//case ALM_MSG_00:
		    // m_pRacev->m_pALM_MSG_00->updateMsg(
		//	&p_info->FrameALM_MSG_00, m_pRacev->m_pWinMain);
		//break;
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
		// case VCU_PWR_STATUS:
		//     m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
		//	&p_info->FrameVCU_PWR_STATUS, m_pRacev->m_pWinMain);
		// break;
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinLogOn) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinChart) ) {
	    switch ( can_addr ) {
		case VCU_HMI_Msg_1:
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinChart);
#if 0 //defined ( QT_DEBUG )
		    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " 2 " << endl;
#endif
		break;
		case VCU_HMI_Msg_2:
#if 0 //defined ( QT_DEBUG )
	    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " * " << endl;
#endif
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			&p_info->FrameVCU_HMI_MSG02);
		break;
		case VCU_HMI_Msg_3:
		    m_pRacev->m_pVCU_HMI_MSG03->updateMsg(
			    &p_info->FrameVCU_HMI_MSG03, m_pRacev->m_pWinChart);
		break;
		case VCU_HMI_Msg_4:
		    m_pRacev->m_pVCU_HMI_MSG04->updateMsg(
			    &p_info->FrameVCU_HMI_MSG04, m_pRacev->m_pWinChart);
		break;
		// case BMS_VCU_Msg01:
		    // m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinChart);
		// break;
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDeploy) ) {
	    switch ( can_addr ) {
		// case BMS_VCU_Msg01:
		    // m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDeploy);
		// break;
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinCharging) ) {
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
		//case BMS_VCU_Msg03:
		//    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinCharging);
		// break;
		//case BMS_VCU_Msg04:
		 //   m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinCharging);
		//break;
		// case BMS_OBC_MSG01:
		  //  m_pRacev->m_pBMS_OBC_MSG01->updateMsg(
		//	&p_info->FrameBMS_OBC_MSG01, m_pRacev->m_pWinCharging);
		// break;
#if 1 // consider whole charging operations
		// required all the time, not just charging win on top.
		// case ALM_MSG_00:
		  //  m_pRacev->m_pALM_MSG_00->updateMsg(
		//	&p_info->FrameALM_MSG_00, m_pRacev->m_pWinCharging);
		// break;
		case VCU_HMI_Msg_1: // B4.3
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinCharging);
		    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " 1 " << endl;
		break;
		// case VCU_PWR_STATUS:
		  //  m_pRacev->m_pVCU_PWR_STATUS->updateMsg(
		//	&p_info->FrameVCU_PWR_STATUS, m_pRacev->m_pWinCharging);
		// break;
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
	//else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinEngineering) ) {
	    // TODO: handle the specific cam frame of interest
	//}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinTraction) ) {
	    switch ( can_addr ) {
		// case BMS_VCU_Msg01:
		    // m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinTraction);
		// break;
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinTraction);
		break;
		//case PCU_IO_SIG00:
		 //    m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinTraction);
		//break;

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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBrake) ) {
	    switch ( can_addr ) {
		// case BMS_VCU_Msg01:
		  //  m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBrake);
		// break;
		case VCU_IOSIG_MSG:
		    // TODO: to be verified
		break;
		//case PCU_IO_SIG00:
		 //   m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinBrake);
		//break;
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinSteering) ) {
	    switch ( can_addr ) {
		// case BMS_VCU_Msg01:
		  //  m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinSteering);
		// break;
		case VCU_IOSIG_MSG:
		    // TODO: to be verified
		break;
		//case PCU_IO_SIG00:
		 //   m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinSteering);
		//break;
		case VCU_DIAG02:
		    m_pRacev->m_pVCU_DIAG02->updateMsg(
			&p_info->FrameVCU_DIAG02, m_pRacev->m_pWinSteering);
		break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinPcuAnalog) ) {
	    switch ( can_addr ) {
		//case PCU_IO_SIG00:
		 //   m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinPcuAnalog);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBcuAnalog) ) {
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinVcuAnalog) ) {
	    switch ( can_addr ) {
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinVcuAnalog);
		break;
		// case BMS_VCU_Msg03:
		//    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinVcuAnalog);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBmsAnalog) ) {
	    switch ( can_addr ) {
		// case BMS_VCU_Msg01:
		  //  m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBmsAnalog);
		// break;
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
		// case BMS_VCU_Msg03:
		//    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinBmsAnalog);
		// break;
		//case BMS_VCU_Msg04:
		 //   m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinBmsAnalog);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinPcuDigital) ) {
	    switch ( can_addr ) {
		//case PCU_IO_SIG00:
		 //   m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinPcuDigital);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBcuDigital) ) {
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinVcuDigital) ) {
	    switch ( can_addr ) {
		case VCU_IOSIG_MSG:
		    m_pRacev->m_pVCU_IOSIG_MSG->updateMsg(
			&p_info->FrameVCU_IOSIG_MSG, m_pRacev->m_pWinVcuDigital);
		break;
		// case BMS_VCU_Msg03:
		//    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinVcuDigital);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinBmsDigital) ) {
	    switch ( can_addr ) {
		case BCU_ER_MSG01:
		    m_pRacev->m_pBCU_ER_MSG01->updateMsg(
			&p_info->FrameBCU_ER_MSG01, m_pRacev->m_pWinBmsDigital);
		break;
		//case BMS_VCU_Msg04:
		 //   m_pRacev->m_pBMS_VCU_MSG04->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG04, m_pRacev->m_pWinBmsDigital);
		//break;
		case BMS_VCU_Msg02:
		    m_pRacev->m_pBMS_VCU_MSG02->updateMsg(
			    &p_info->FrameBMS_VCU_MSG02, m_pRacev->m_pWinBmsDigital);
		break;
		// case BMS_VCU_Msg01:
		  //  m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinBmsDigital);
		//break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDcdc) ) {
	    switch ( can_addr ) {
		// note: some of the alarms here,
		// therefore is categorized as 'core message'
		// case DCDC_MSG00:
		//    m_pRacev->m_pDCDC_MSG00->updateMsg(
		//	&p_info->FrameDCDC_MSG00, m_pRacev->m_pWinDcdc);
		// break;
		//case BMS_VCU_Msg01:
		 //   m_pRacev->m_pBMS_VCU_MSG01->updateMsg(
		//	    &p_info->FrameBMS_VCU_MSG01, m_pRacev->m_pWinDcdc);
		// break;
		case VCU_HMI_Msg_2:
#if defined ( QT_DEBUG )
		    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " * " << endl;
#endif
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
                &p_info->FrameVCU_HMI_MSG02);
		break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDiagnose) ) {
	    // TODO: handle the specific cam frame of interest
	    switch ( can_addr ) {
		// case BMS_VCU_Msg03:
		//    m_pRacev->m_pBMS_VCU_MSG03->updateMsg(
		//	&p_info->FrameBMS_VCU_MSG03, m_pRacev->m_pWinDiagnose);
		// break;
		//case PCU_IO_SIG00:
		 //   m_pRacev->m_pPCU_IO_SIG00->updateMsg(
		//	&p_info->FramePCU_IO_SIG00, m_pRacev->m_pWinDiagnose);
		//break;
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinTpms) ) {
	    switch ( can_addr ) {
		case TPMS_MSG01:
		    m_pRacev->m_pTPMS_MSG01->updateMsg(
			&p_info->FrameTPMS_MSG01, m_pRacev->m_pWinTpms);
		break;
		case TPMS_MSG02:
#if defined ( QT_DEBUG )
		    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " * " << endl;
#endif
		    m_pRacev->m_pTPMS_MSG02->updateMsg(
			&p_info->FrameTPMS_MSG02, m_pRacev->m_pWinTpms);
		break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinUnlock) ) {
	    // cout << __FILE__ << ":" << __LINE__ << "-" << endl;
	    switch ( can_addr ) {
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
                &p_info->FrameVCU_HMI_MSG02);
		break;
		default:
		break;
	    }
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinTpms) ) {
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
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinIconDesc) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinAlarmRecord) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinAlarmStatistics) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinSystemLog) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinCellAlarmRecord) ) {
	}
	else if (
	    m_pRacev->isActiveWindow(m_pRacev->m_pWinVehicleInformationRecord) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinChargeTrippedRecord) ) {
	}
	else if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinHistory) ) {
	}
	else { }
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    m_pRacev->m_CanvasMutex.unlock();
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ <<":"<< __LINE__ << " " << __func__ << " - " << endl;
#endif
    return;
}

void Worker::onSignalErrorFrame(uint direction, uint stat, uint rx_err_cnt, uint tx_err_cnt) {
    try {
	// FIXME: not complains until bus stop
	if ( CNT_CAN_ERROR_PASSIVE <= rx_err_cnt
		&& CNT_CAN_ERROR_PASSIVE <= tx_err_cnt ) {
	    cout << __func__ << ":" << __LINE__ << " err "
		<< setfill('0') << setw(1) << direction << " "
		<< setfill('0') << setw(1) << stat << " "
		<< setfill('0') << setw(3) << rx_err_cnt << " "
		<< setfill('0') << setw(3) << tx_err_cnt
		<< endl;
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " " << __func__
	    << " exception " << ex.what() << endl;
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
	cout << __FILE__ << ":" << __LINE__ << " " << __func__
	    << " exception " << ex.what() << endl;
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
    int i_item = 0, i_unlock = 0; bool ok;
    try {
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

#if defined ( CAN_TX_THREAD_ )
	emit signalTransmit(VCU_FN_DISABLE, 1);
#endif

    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    return;
}

void Worker::onSignalReset(const QString &msg) {
    try {
	//ts = QDateTime::currentMSecsSinceEpoch();
	// recording reset action? at (thread ) writing frame log
#if 0
	cout << __func__ << ":" << __LINE__
	    << " item " << item.toStdString()
	    << " unlock " << unlock.toStdString() << endl;
#endif
	// Assume reset command "no memory", one at a time
	m_pRacev->i_reset = 0;
	if ( !msg.compare("DRVRT") ) {
	    m_pRacev->i_reset |= 1;
	}
	else if ( !msg.compare("MTRTime") ) {
	    m_pRacev->i_reset |= (1<<1);
	}
	else if ( !msg.compare("BRKdrvRT") ) {
	    m_pRacev->i_reset |= (1<<2);
	}
	else if ( !msg.compare("BRKMVRT") ) {
	    m_pRacev->i_reset |= (1<<3);
	}
	else if ( !msg.compare("HdDrvRT") ) {
	    m_pRacev->i_reset |= (1<<4);
	}
	else if ( !msg.compare("HdMtrRT") ) {
	    m_pRacev->i_reset |= (1<<5);
	}
	else {
	    // TODO:
	}
#if defined ( CAN_TX_THREAD_ )
	emit signalTransmit(VCU_DMRT_CLR, 1);
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
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
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    return;
}

#if defined ( CLOCK_THREAD_ )
/*
 * @see 020.ClockThread-ticking-jobs
 */
void Worker::onSignalTicksSec(unsigned int n_seconds) {
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << n_seconds << endl;
#endif

    // VCU 1st priority
    switch ( n_seconds ) {
	case 1:
#if defined ( CAN_THREAD_ )
	    // if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinMain) ) {
	    // TODO: move to diagnostics
		emit signalCANBusInfo(n_seconds);
	    // }
#endif
	    // emit notifyUpdate();
	    // main screen, or a triggering source
	    // on current active windows
	    // test without update by page

	    emit signalAccelerometer();
#if 1
	    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << endl;
	    cout << "trigger " << endl;
	    for ( int i=0; i<NUM_BYTE_ALARM; i++ ) {
		cout << hex
		<< setfill('0') << setw(2)
		<< (m_pRacev->m_pInfo->m_AlarmTrigger[i]&0xFF) << " ";
	    }
	    cout << "\nalarm" << endl;
	    for ( int i=0; i<NUM_BYTE_ALARM; i++ ) {
		cout << hex
		<< setfill('0') << setw(2)
		<< (m_pRacev->m_pInfo->m_Alarm[i]&0xFF) << " ";
	    }
	    cout << dec << endl;
#endif
	    break;
	case 2:
	    emit signalTickSlope(); // tx
	    break;
	case 5:
	    break;
	case 10:
	    emit signalLogVehicleInfo();
	    break;
	case 20:
	    break;
	case 30:
#if defined ( GPS_THREAD_ )
	    emit signalSyncGpsTimeToHw();
#endif
	    break;
	case 60:
	    break;
    }
}

/*
 * send slope, repeatitively.
 */
void Worker::onTickSlope(void) {
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif
    try {
#if defined ( CAN_TX_THREAD_ )
	emit signalTransmit(VCU_FN_DISABLE, 2);
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
#if 0//defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " -" << endl;
#endif
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

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif

    try {
	m_pRacev->m_pInfo->m_pGSensor->Get(
	    &x, &y, &z, &m_pRacev->m_pInfo->m_fSlope, &roll/*,&yaw*/);
	s_x = QString::number(static_cast<double>(x), 'f', 3);
	s_y = QString::number(static_cast<double>(y), 'f', 3);
	s_z = QString::number(static_cast<double>(z), 'f', 3);
	s_pitch = QString::number(m_pRacev->m_pInfo->m_fSlope, 'f', 1);
	s_roll = QString::number(static_cast<double>(roll), 'f', 1);

#if defined ( EN_INVOKE_METHOD_ )
	pCurrentWindow = m_pRacev->getActiveWindow();
	if ( pCurrentWindow == m_pRacev->m_pWinDiagnose ) {
	    QMetaObject::invokeMethod(pCurrentWindow, "tickGSensor", // refactored
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_x),
		Q_ARG(QVariant, s_y),
		Q_ARG(QVariant, s_z),
		Q_ARG(QVariant, s_pitch),
		Q_ARG(QVariant, s_roll),
		Q_ARG(QVariant, 0/*s_yaw*/), // TODO:
		Q_ARG(QVariant, calibrate),
		Q_ARG(QVariant, zero_position));
	}
#elif defined ( EN_PUSHING_REF2QML_ )
	if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDiagnose) ) {
	    emit signalDisplayGSensor(
		s_x,
		s_y,
		s_z,
		s_pitch,
		s_roll,
		0/*s_yaw*/, // TODO:
		calibrate,
		zero_position);
	}
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
#if 0//defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " -" << endl;
#endif
    return;
}
#endif

#if defined ( GPS_THREAD_ )
/*
 * the signal is used to update diagnose screen.
 */
void Worker::onSignalGPS(void) {
    QVariant returnedValue;
    QString s_latitude, s_longitude;
    QString s_dir_latitude, s_dir_longitude;
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif

    // Qt - Converting float to QString
    // @see https://tinyurl.com/y5sczpmn
    s_latitude.setNum(m_pInfo->latitude);
    s_longitude.setNum(m_pInfo->longitude);
    // QString from std string
    // @see https://tinyurl.com/y3l4ndfm
    s_dir_latitude = QString::fromStdString(m_pInfo->dir_latitude);
    s_dir_longitude = QString::fromStdString(m_pInfo->dir_longitude);

    // FIXME:
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " "
	<< m_pInfo->dir_latitude << " "
	<< s_dir_latitude.toStdString() << " "
	<< endl;
#endif

#if defined ( EN_INVOKE_METHOD_ )
    QMetaObject::invokeMethod(m_pRacev->m_pWinDiagnose, "tickGPS", // refactored
	Qt::DirectConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_latitude),
	Q_ARG(QVariant, s_dir_latitude),
	Q_ARG(QVariant, s_longitude),
	Q_ARG(QVariant, s_dir_longitude));
#elif defined ( EN_PUSHING_REF2QML_ )
    if ( m_pRacev->isActiveWindow(m_pRacev->m_pWinDiagnose) ) {
	emit signalDisplayCoordinates(
	    s_latitude,
	    s_dir_latitude,
	    s_longitude,
	    s_dir_longitude);
    }
#endif
    return;
}

// TODO: get time, capability, set gps time
// @see hidePowerCords
void Worker::onSyncGpsTimeToHw(void) {
#if 0//defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif
    // TODO:
    return;
    // TODO: @see https://tinyurl.com/yfus5tuc
#if 0
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
#endif
}
#endif
