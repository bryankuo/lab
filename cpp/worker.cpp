#include <iostream>
#include <stdexcept>
#include <iomanip>
#include <cmath>

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
// #include "info.h"
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

Worker::Worker(QQmlApplicationEngine *pEngine, Racev* pRacev)
    : p_engine(pEngine),m_pRacev(pRacev),m_pInfo(pRacev->m_pInfo)
{
    //qDebug() << "Worker(e,r)+";
    // QByteArray cmd_at_mp_ff92 = "AT MP FF92\r";
}

Worker::~Worker()
{
    qDebug() << "Worker-";
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

#define MIN_MILAGE 0
#define MAX_MILAGE 10000000 // 0.1 km

#define DELTA_OFFSET (-500)
#define MIN_DELTA (-500)
#define MAX_DELTA (1000)
#define MIN_KHPKM 0
#define MAX_KHPKM 3000
#define MIN_MLEFT 0
#define MAX_MLEFT 1000

#if 0
void Worker::updateMessage_VCU_HMI_Msg_1_Byte_1(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 1;
    //qDebug() << "VCU_HMI_Msg_1+";
    int ecas_kneeling = 0; int rear_fog_light = 0; int alarm_getoff = 0;
    int motor_overrun= 0; int regen_brake = 0; int parking = 0;
    int motor_op = 0;
    QByteArray payload = pframe->payload();

    if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
    // ( http://tinyurl.com/yyzfux2f )
	qDebug() << __FILE__ << ":" << __LINE__ << "8!";
	goto ERROR_HANDLER;
    }
    ecas_kneeling = (payload[i] & 0x01);
    rear_fog_light = (payload[i] & 0x02);
    alarm_getoff = (payload[i] & 0x04);
    motor_overrun = (payload[i] & 0x08);
    regen_brake = (payload[i] & 0x10);
    parking = (payload[i] & 0x20);
    motor_op = (payload[i] & 0x40);

    QMetaObject::invokeMethod(
    m_pRacev->m_pWinMain, "update_VCU_HMI_Msg_1_Byte_1",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, ecas_kneeling),
        Q_ARG(QVariant, rear_fog_light),
        Q_ARG(QVariant, alarm_getoff),
        Q_ARG(QVariant, motor_overrun),
        Q_ARG(QVariant, regen_brake),
        Q_ARG(QVariant, parking),
        Q_ARG(QVariant, motor_op));
ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1_Byte_2(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 2;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload = pframe->payload();
    int abs = 0; int ecas_warn = 0; int lining = 0;
    int emergency_exit = 0;

    if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
    // ( http://tinyurl.com/yyzfux2f )
    qDebug() << __FILE__ << ":" << __LINE__ << "8!";
    goto ERROR_HANDLER;
    }
    abs = (payload[i] & 0x03);
    ecas_warn = (payload[i] & 0x0C) >> 2;
    lining = (payload[i] & 0x30) >> 4;
    emergency_exit = (payload[i] & 0xC0) >> 6;

    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "update_VCU_HMI_Msg_1_Byte_2",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, abs),
        Q_ARG(QVariant, ecas_warn),
        Q_ARG(QVariant, lining),
        Q_ARG(QVariant, emergency_exit));
ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1_Byte_3(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 3;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload = pframe->payload();
    int motor_alarm = 0; int air_alarm = 0; int psteering_alarm = 0;
    int mpower_alarm = 0;

    if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
    // ( http://tinyurl.com/yyzfux2f )
    qDebug() << __FILE__ << ":" << __LINE__ << "8!";
    goto ERROR_HANDLER;
    }
    motor_alarm = (payload[i] & 0x03);
    air_alarm = (payload[i] & 0x0C) >> 2;
    psteering_alarm = (payload[i] & 0x30) >> 4;
    mpower_alarm = (payload[i] & 0xC0) >> 6;

    QMetaObject::invokeMethod(m_pRacev->m_pWinMain,
    "update_VCU_HMI_Msg_1_Byte_3",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, motor_alarm),
        Q_ARG(QVariant, air_alarm),
        Q_ARG(QVariant, psteering_alarm),
        Q_ARG(QVariant, mpower_alarm));
ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1_Byte_4(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 4;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload = pframe->payload();
    int v24_alarm = 0; int lv_alarm = 0; int charge_abort = 0;
    int brake = 0; int wiper = 0; int lb_light = 0;

    if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
    // ( http://tinyurl.com/yyzfux2f )
    qDebug() << __FILE__ << ":" << __LINE__ << "8!";
    goto ERROR_HANDLER;
    }
    v24_alarm = (payload[i] & 0x03);
#if 0 // TODO: yellow area, TBD
    lv_alarm = (payload[i] & 0x04) >> 2;
    charge_abort = (payload[i] & 0x30) >> 4;
    brake = (payload[i] & 0xC0) >> 6;
    wiper = (payload[i] & 0xC0) >> 6;
    lb_light = (payload[i] & 0xC0) >> 6;
#endif
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain,
    "update_VCU_HMI_Msg_1_Byte_4",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, v24_alarm),
        Q_ARG(QVariant, lv_alarm),
        Q_ARG(QVariant, charge_abort),
        Q_ARG(QVariant, brake),
        Q_ARG(QVariant, wiper),
        Q_ARG(QVariant, lb_light));
ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1_Byte_5(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 5;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload;

    payload = pframe->payload();
    if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
    // ( http://tinyurl.com/yyzfux2f )
    qDebug() << __FILE__ << ":" << __LINE__ << "8!";
    goto ERROR_HANDLER;
    }
    m_pRacev->m_pInfo->gear = (payload[i] & 0x07);
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "update_VCU_HMI_Msg_1_Byte_5",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, m_pRacev->m_pInfo->gear));
ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1_Byte_6(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 6;
    QByteArray payload;
    int reading = 0; int speed = 0;
    Info* p_info = m_pRacev->m_pInfo;

    try {
	if ( nullptr == pframe ) {
	    cout<<__FILE__ << ":" << __LINE__<< "!" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.isEmpty() ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout<<__FILE__ << ":" << __LINE__<< "!" << endl;
	    goto ERROR_HANDLER;
	}
	if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "8!";
	    goto ERROR_HANDLER;
	}
	reading = (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8);
	speed = static_cast<int>(
	    static_cast<float>(reading)/static_cast<float>(100));
	if ( speed < SPEED_LLIMIT || SPEED_ULIMIT <= speed ) {
	    cout<<__FILE__ << ":" << __LINE__<< "!" << endl;
	    goto ERROR_HANDLER;
	}
#if 0
#define FACTOR_SPEED 2 // assume not jump over half of MA
	// MA filter
	if ( p_info->m_speed/FACTOR_SPEED < speed ) {
	    cout<<__func__ << ":" << __LINE__<< " leap!" << endl;
	    goto ERROR_HANDLER;
	}
#endif
	p_info->addSpeedMAFilter(speed);
	// TODO:
#if 0
	qDebug() << "speed" << speed << "MA" << p_info->m_speed;
#endif
	QMetaObject::invokeMethod(m_pRacev->m_pWinMain,
	"update_VCU_HMI_Msg_1_Byte_6",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, speed));
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }

ERROR_HANDLER:
    return;
}

void Worker::updateMessage_VCU_HMI_Msg_1(QCanBusFrame* pframe) {
    QVariant returnedValue; //int i = 0;
//cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    int left_turn = 0; int right_turn = 0; int head_light = 0;
    int side_light= 0; int hazard_light = 0; int evacuation_light = 0;
    int rear_defogger_light = 0; int access_light= 0;
    QByteArray payload;

    try {
	if ( nullptr == pframe ) {
	    //qDebug() << __FILE__ << ":" << __LINE__ << "VCU_HMI_Msg_1!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.isEmpty() || pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "VCU_HMI_Msg_1!";
	    goto ERROR_HANDLER;
	}

	left_turn = (payload[0]&0x01);
	right_turn = (payload[0]&0x02)>>1;
	head_light = (payload[0]&0x04)>>2;
	side_light = (payload[0]&0x08)>>3;
	hazard_light = (payload[0]&0x10)>>4;
	access_light = (payload[0]&0x20)>>5;
	evacuation_light = (payload[0]&0x40)>>6;
	rear_defogger_light = (payload[0]&0x80)>>7;

	// byte 0
	QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "update_VCU_HMI_Msg_1",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, left_turn),
	    Q_ARG(QVariant, right_turn),
	    Q_ARG(QVariant, head_light),
	    Q_ARG(QVariant, side_light),
	    Q_ARG(QVariant, hazard_light),
	    Q_ARG(QVariant, access_light),
	    Q_ARG(QVariant, evacuation_light),
	    Q_ARG(QVariant, rear_defogger_light));

	updateMessage_VCU_HMI_Msg_1_Byte_1(pframe);

	updateMessage_VCU_HMI_Msg_1_Byte_2(pframe);
	updateMessage_VCU_HMI_Msg_1_Byte_3(pframe);
	updateMessage_VCU_HMI_Msg_1_Byte_4(pframe);
	updateMessage_VCU_HMI_Msg_1_Byte_5(pframe);

	updateMessage_VCU_HMI_Msg_1_Byte_6(pframe); // 6 and 7
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
ERROR_HANDLER:
    //delete pframe; // ( https://bre.is/48KAICiOq )
    //pframe = nullptr;
    // ( https://is.gd/3VKJ2l )
    //cout<< __func__ <<":"<< __LINE__ << " - "<<endl;
    return;
}
#endif

void Worker::updateMessage_VCU_HMI_Msg_3(QCanBusFrame* pframe) {
    QVariant returnedValue; int i = 0;
    int total = 0; int trip = 0;
    QString s_total, s_trip;
    QByteArray payload;

    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    try {
	if ( nullptr == pframe ) {
	    //qDebug() << __FILE__ << ":" << __LINE__ << "VCU_HMI_Msg_3!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.isEmpty() || pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
#if defined ( QT_DEBUG )
	    cout << __FILE__ << ":" << __LINE__ << "!" << endl;
#endif
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	i = 0; total = (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8)
	+ ((payload[i+2]&0xFF)<<16) + ((payload[i+3]&0xFF)<<24);
	//if ( MAX_MILAGE <= total ) {
	//    total -= MAX_MILAGE;
	//}
	if ( total < MIN_MILAGE || MAX_MILAGE <= total ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "mlg!";
	    goto ERROR_HANDLER;
	}
	i = 4; trip = (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8)
	+ ((payload[i+2]&0xFF)<<16) + ((payload[i+3]&0xFF)<<24);
	if ( 10000000 <= trip ) {
	    trip -= MAX_MILAGE;
	}
	// ( https://stackoverflow.com/a/7235523 )
	s_total.sprintf("%08.1f", total/10.0);
	s_trip.sprintf("%08.1f", trip/10.0);
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << "total" << s_total << "trip" << s_trip;
#endif
	QMetaObject::invokeMethod(m_pRacev->m_pWinMain,
	    "update_VCU_HMI_Msg_3",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_total),
	    Q_ARG(QVariant, s_trip));
ERROR_HANDLER:
	//cout<< __func__ <<":"<< __LINE__ << endl;
	static_cast<void> (0) ; // ( https://stackoverflow.com/a/26695654 )
    } catch (const std::exception& ex) {
	qDebug() << "exception" << ex.what();
    }
    return;
}

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
	if ( payload.isEmpty() || pframe->payload().size() != 8 ) {
#if defined ( QT_DEBUG )
		cout<< __func__ <<":"<< __LINE__ << " ! "<<endl;
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

// TODO: refactor
void Worker::updateMsg_BMS_OCU_Msg01(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    float mx_allowed_chg_voltage = 0;
    float mx_allowed_chg_current = 0;
    unsigned int chg_time_left_mins = 0;
    unsigned int num_chg_times = 0;
    unsigned int charger_ctrl_cmds = 0;
    QString s_mx_allowed_chg_voltage; QString s_mx_allowed_chg_current;
    // TODO: kwh calculation on the screen
    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.isEmpty() || pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	i = 0; mx_allowed_chg_voltage = static_cast<float>((payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<float>(10);
	// saturation control
	if ( 750.0f < mx_allowed_chg_voltage ) {
	    mx_allowed_chg_voltage = 750.0f;
	}
	if ( mx_allowed_chg_voltage <= 0.0f ) {
	    mx_allowed_chg_voltage = 0.0f;
	}

	i = 2; mx_allowed_chg_current
	    = abs( static_cast<float>((payload[i]&0xFF)
		+ ((payload[i+1]&0xFF)<<8) + OFFSET_CURRENT ));
	mx_allowed_chg_current *= static_cast<float>(FACTOR_CURRENT);
	// saturation control
	if ( 40.0f < mx_allowed_chg_current ) {
	    mx_allowed_chg_current = 40.0f; // FIXME: constant
	}
	if ( mx_allowed_chg_current <= 0.0f ) {
	    mx_allowed_chg_current = 0.0f;
	}

	i = 4; chg_time_left_mins
	    = static_cast<unsigned int>((payload[i]&0xFF)+((payload[i+1]&0xFF)<<8));
	// TODO: check if any value is greater than 600 mins
	i = 6; num_chg_times = (payload[i]&0xFF)+((payload[i+1]&0x3F)<<8);
	i = 7; charger_ctrl_cmds = ((payload[i]&0xC0)>>6);
	s_mx_allowed_chg_voltage = QString::number(
		static_cast<double>(mx_allowed_chg_voltage), 'f', 1);
	s_mx_allowed_chg_current = QString::number(
		static_cast<double>(mx_allowed_chg_current), 'f', 1);
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << mx_allowed_chg_current << " " << s_mx_allowed_chg_current;
#endif
	QMetaObject::invokeMethod(pDstVw, "updateBMS_OCU_Msg01",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, s_mx_allowed_chg_voltage),
	Q_ARG(QVariant, s_mx_allowed_chg_current),
	Q_ARG(QVariant, chg_time_left_mins),
	Q_ARG(QVariant, num_chg_times),
	Q_ARG(QVariant, charger_ctrl_cmds));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

void Worker::updateMsg_BMS_Volt_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    static const size_t cellSize = NUM_CELLS;
    QString s_cellVoltages[cellSize] = {nullptr};
    QVariant returnedValue; int frame_idx = pack*4+1;
    int i = 0; int i1 = 0; QByteArray payload, payload1;
    QCanBusFrame frame, frame1;
    QString numStr;

    frame = m_pRacev->m_pInfo
	->cached_cell_voltage[
	    static_cast<const unsigned int>(frame_idx)];
    //qDebug() << "updateMsg_BMS_Volt_Msg01+";
    payload = frame.payload();
    i = 1; m_pRacev->m_pInfo->cellVoltages[pack][0] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    i = 3; m_pRacev->m_pInfo->cellVoltages[pack][1] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    i = 5; m_pRacev->m_pInfo->cellVoltages[pack][2] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    frame1 = m_pRacev->m_pInfo->cached_cell_voltage[frame_idx+1];
    payload1 = frame1.payload();
    i = 7; i1 = 1;
    m_pRacev->m_pInfo->cellVoltages[pack][3] = static_cast<double>( (payload[i]&0xFF)
    + ((payload1[i1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 2; m_pRacev->m_pInfo->cellVoltages[pack][4] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 4; m_pRacev->m_pInfo->cellVoltages[pack][5] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 6; m_pRacev->m_pInfo->cellVoltages[pack][6] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);
    frame = m_pRacev->m_pInfo->cached_cell_voltage[frame_idx+2];
    payload = frame.payload();
    i = 1; m_pRacev->m_pInfo->cellVoltages[pack][7] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    i = 3; m_pRacev->m_pInfo->cellVoltages[pack][8] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    i = 5; m_pRacev->m_pInfo->cellVoltages[pack][9] = static_cast<double>( (payload[i]&0xFF)
    + ((payload[i+1]&0xFF)<<8) )/static_cast<double>(1000);
    frame1 = m_pRacev->m_pInfo->cached_cell_voltage[frame_idx+3];
    payload1 = frame1.payload();
    i = 7; i1 = 1;
    m_pRacev->m_pInfo->cellVoltages[pack][10] = static_cast<double>( (payload[i]&0xFF)
    + ((payload1[i1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 2; m_pRacev->m_pInfo->cellVoltages[pack][11] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 4; m_pRacev->m_pInfo->cellVoltages[pack][12] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);
    i1 = 6; m_pRacev->m_pInfo->cellVoltages[pack][13] = static_cast<double>( (payload1[i1]&0xFF)
    + ((payload1[i1+1]&0xFF)<<8) )/static_cast<double>(1000);

    for ( i = 0; i < static_cast<int>(cellSize); i++ ) {
	if ( m_pRacev->m_pInfo->cellVoltages[pack][i] < MIN_V
	    || MAX_V_CELL < m_pRacev->m_pInfo->cellVoltages[pack][i] ) {
	    //cout << __func__ << ":" << __LINE__ << "i " << i << " !c" << endl;
	    continue;
	}
    }

    for ( i = 0; i < static_cast<int>(cellSize); i++ ) {
    s_cellVoltages[i] = QString::number(
        static_cast<double>(m_pRacev->m_pInfo->cellVoltages[pack][i]), 'f', 3);
    //s_cellVoltages[i] // FIXME:
     //   = numStr.sprintf("%f.2f", static_cast<double>(m_pRacev->m_pInfo->cellVoltages[pack][i]));
    }
#if 0
    std::cout.precision(3);
    for ( i = 0; i < static_cast<int>(cellSize); i++ ) {
    std::cout << m_pRacev->m_pInfo->cellVoltages[pack][i] << " ";
    if ( 0 == i%10 )
        cout << endl;
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
//ERROR_HANDLER:
    return;
}

void Worker::updateMsg_BMS_Temp_Msg01(
    int pack/*0-based*/, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; int page = 0;
    int frame_idx; QCanBusFrame frame;

    // qDebug() << "updateMsg_BMS_Temp_Msg01+";
    frame_idx = pack / 2; page = pack % 2;
    frame = m_pRacev->m_pInfo->cached_probe_temperature[frame_idx];
    QByteArray payload = frame.payload();

    i = page*NUM_TPROBE + 0;
    m_pRacev->m_pInfo->cellTemperatures[pack][0] = (payload[i]&0xFF) + OFFSET_TEMP;
    if ( m_pRacev->m_pInfo->cellTemperatures[pack][0] < OFFSET_TEMP )
	m_pRacev->m_pInfo->cellTemperatures[pack][0] = OFFSET_TEMP;
    if ( MAX_TEMP <= m_pRacev->m_pInfo->cellTemperatures[pack][0] )
	m_pRacev->m_pInfo->cellTemperatures[pack][0] = MAX_TEMP;
    i = page*NUM_TPROBE + 1;
    m_pRacev->m_pInfo->cellTemperatures[pack][1] = (payload[i]&0xFF) + OFFSET_TEMP;
    if ( m_pRacev->m_pInfo->cellTemperatures[pack][1] < OFFSET_TEMP )
	m_pRacev->m_pInfo->cellTemperatures[pack][1] = OFFSET_TEMP;
    if ( MAX_TEMP <= m_pRacev->m_pInfo->cellTemperatures[pack][1] )
	m_pRacev->m_pInfo->cellTemperatures[pack][1] = MAX_TEMP;
    i = page*NUM_TPROBE + 2;
    m_pRacev->m_pInfo->cellTemperatures[pack][2] = (payload[i]&0xFF) + OFFSET_TEMP;
    if ( m_pRacev->m_pInfo->cellTemperatures[pack][2] < OFFSET_TEMP )
	m_pRacev->m_pInfo->cellTemperatures[pack][2] = OFFSET_TEMP;
    if ( MAX_TEMP <= m_pRacev->m_pInfo->cellTemperatures[pack][2] )
	m_pRacev->m_pInfo->cellTemperatures[pack][2] = MAX_TEMP;
    i = page*NUM_TPROBE + 3;
    m_pRacev->m_pInfo->cellTemperatures[pack][3] = (payload[i]&0xFF) + OFFSET_TEMP;
    if ( m_pRacev->m_pInfo->cellTemperatures[pack][3] < OFFSET_TEMP )
	m_pRacev->m_pInfo->cellTemperatures[pack][3] = OFFSET_TEMP;
    if ( MAX_TEMP <= m_pRacev->m_pInfo->cellTemperatures[pack][3] )
	m_pRacev->m_pInfo->cellTemperatures[pack][3] = MAX_TEMP;

    QMetaObject::invokeMethod(pDstVw, "updateBMS_Temp_Msg01",
    Qt::BlockingQueuedConnection,
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, m_pRacev->m_pInfo->cellTemperatures[pack][0]),
    Q_ARG(QVariant, m_pRacev->m_pInfo->cellTemperatures[pack][1]),
    Q_ARG(QVariant, m_pRacev->m_pInfo->cellTemperatures[pack][2]),
    Q_ARG(QVariant, m_pRacev->m_pInfo->cellTemperatures[pack][3]));
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
    //updateMessage_VCU_HMI_Msg_3(frame); break;
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
    updateMessage_VCU_HMI_Msg_3(&p_info->FrameVCU_HMI_MSG3);
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
ERROR_HANDLER:
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
    QVariant returnedValue; QString msg = "not authorized!";
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " [" << entitlement.toStdString() << "]" << endl;
#endif
    // TODO: decode function
    if ( !entitlement.compare("1234") && m_pRacev->m_pWinMain ) {
	QQmlProperty::write(m_pRacev->m_pWinMain, "visible", "true");
	// NOTE: this will make window invisible on the debian9 taskbar.
	QQmlProperty::write(m_pRacev->m_pWinLogOn, "visible", "false");
	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authPassed",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue));
    } else {
	QMetaObject::invokeMethod(m_pRacev->m_pWinLogOn, "authFailed",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, msg));
    }
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
    else if ( !msg.compare("Engineering")
        && m_pRacev->m_pWinEngineering ) {
    QQmlProperty::write(m_pRacev->m_pWinEngineering, "visible", "true");
    }

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
	QQmlProperty::write(m_pRacev->m_pWinLogOn,
	    "visible", "true");
    }

    else { }
}

void Worker::cppSlotDeployment(const QString &msg, int index) {
    QVariant returnedValue;
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

    else {}
}

bool Worker::isWindowActive(QObject* pWindow) {
    if ( "true" == QQmlProperty::read(pWindow, "active") )
	return true;
    else return false;
}

//#define PRINT_UNIDENTIFIED_ADDR_
void Worker::onSignalCANFrame(quint32 can_addr, QCanBusFrame* pframe) {
#if defined ( PRINT_UNIDENTIFIED_ADDR_ )
    QString str_can_addr;
#endif
#if 0 //defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << "-" << endl;
#endif
    Info* p_info = m_pRacev->m_pInfo;
    try {
	// TODO: most frequent on the top
	// TODO: message throughout application execution
	if ( isWindowActive(m_pRacev->m_pWinMain) ) {
	    // TODO: check which active window, too, assume main
	    switch ( can_addr ) {
		case VCU_HMI_Msg_1:
		    // updateMessage_VCU_HMI_Msg_1(&p_info->FrameVCU_HMI_MSG01);
		    m_pRacev->m_pVCU_HMI_MSG01->updateMsg(
			&p_info->FrameVCU_HMI_MSG01, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_2:
		    m_pRacev->m_pVCU_HMI_MSG02->updateMsg(
			&p_info->FrameVCU_HMI_MSG02, m_pRacev->m_pWinMain);
		break;
		case VCU_HMI_Msg_3:
		    updateMessage_VCU_HMI_Msg_3(&p_info->FrameVCU_HMI_MSG3);
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
		    m_pRacev->m_pALM_MSG_00->updateMsg(
			&p_info->FrameALM_MSG_00, m_pRacev->m_pWinMain);
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
		    updateMessage_VCU_HMI_Msg_3(&p_info->FrameVCU_HMI_MSG3);
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
		    //delete pframe; // FIXME: double free
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
		    //delete pframe; // FIXME: double free
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
		case BMS_OBC_Msg01:
		    updateMsg_BMS_OCU_Msg01(
			&p_info->FrameBMS_OBC_Msg01, m_pRacev->m_pWinCharging);
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
	else if ( isWindowActive(m_pRacev->m_pWinEngineering) ) {
	    // TODO: handle the specific cam frame of interest
	}
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
	qDebug() << "exception" << ex.what();
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
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
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
	cout << "exception" << ex.what() << endl;
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
