#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_HMI_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_VCU_HMI_MSG01::VCU_HMI_MSG01
///
/// HMI context
///
Handler_VCU_HMI_MSG01::Handler_VCU_HMI_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_HMI_MSG01() +";
}

Handler_VCU_HMI_MSG01::~Handler_VCU_HMI_MSG01() {
    //qDebug() << "Handler_VCU_HMI_MSG01() ~";
}

void Handler_VCU_HMI_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) { // TODO: apply to all handlers
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->left_turn = (payload[0]&0x01);
	p_racev->m_pInfo->right_turn = (payload[0]&0x02)>>1;
	p_racev->m_pInfo->head_light = (payload[0]&0x04)>>2;
	p_racev->m_pInfo->side_light = (payload[0]&0x08)>>3;
	p_racev->m_pInfo->hazard_light = (payload[0]&0x10)>>4;
	p_racev->m_pInfo->access_light = (payload[0]&0x20)>>5;
	p_racev->m_pInfo->door_open = (payload[0]&0x40)>>6;
	p_racev->m_pInfo->rear_defogger_light = (payload[0]&0x80)>>7;
	if ( pDstVw == p_racev->m_pWinDcdc
	    || pDstVw == p_racev->m_pWinUnlock
	    || pDstVw == p_racev->m_pWinMain ) {
	    // byte 0
	    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->left_turn),
		Q_ARG(QVariant, p_racev->m_pInfo->right_turn),
		Q_ARG(QVariant, p_racev->m_pInfo->head_light),
		Q_ARG(QVariant, p_racev->m_pInfo->side_light),
		Q_ARG(QVariant, p_racev->m_pInfo->hazard_light),
		Q_ARG(QVariant, p_racev->m_pInfo->access_light),
		Q_ARG(QVariant, p_racev->m_pInfo->door_open),
		Q_ARG(QVariant, p_racev->m_pInfo->rear_defogger_light));
	    updateMessage_VCU_HMI_Msg_1_Byte_1(pframe,pDstVw);
	    updateMessage_VCU_HMI_Msg_1_Byte_2(pframe,pDstVw);
	    updateMessage_VCU_HMI_Msg_1_Byte_3(pframe,pDstVw);
	    updateMessage_VCU_HMI_Msg_1_Byte_4(pframe,pDstVw);
	    updateMessage_VCU_HMI_Msg_1_Byte_5(pframe,pDstVw);
	    if ( p_racev->m_pInfo->key_position == KEY_ON ) {
		updateMessage_VCU_HMI_Msg_1_Byte_6(pframe,pDstVw); // 6 and 7
		// TODO: only main required speed
	    }
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    // cout << __FILE__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_1(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    // cout << "VCU_HMI_Msg_1+" << endl;
    QByteArray payload = pframe->payload();
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    // already guarded by previous call
    // if ( /*payload.isEmpty()*/pframe->payload().size() != 8 ) {
	// ( http://tinyurl.com/yyzfux2f )
    //	cout << __FILE__ << ":" << __LINE__ << " 8!" << endl;
    // 	goto ERROR_HANDLER;
    // }
    p_racev->m_pInfo->ecas_kneeling = (payload[1] & 0x01);
    p_racev->m_pInfo->rear_fog_light = (payload[1] & 0x02)>>1;
    p_racev->m_pInfo->alarm_getoff = (payload[1] & 0x04)>>2;
    p_racev->m_pInfo->motor_overrun = (payload[1] & 0x08)>>3;
    p_racev->m_pInfo->regen_brake = (payload[1] & 0x10)>>4;
    p_racev->m_pInfo->parking = (payload[1] & 0x20)>>5;
    p_racev->m_pInfo->motor_op = (payload[1] & 0x40)>>6;

    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1_Byte_1",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, p_racev->m_pInfo->ecas_kneeling),
        Q_ARG(QVariant, p_racev->m_pInfo->rear_fog_light),
        Q_ARG(QVariant, p_racev->m_pInfo->alarm_getoff),
        Q_ARG(QVariant, p_racev->m_pInfo->motor_overrun),
        Q_ARG(QVariant, p_racev->m_pInfo->regen_brake),
        Q_ARG(QVariant, p_racev->m_pInfo->parking),
        Q_ARG(QVariant, p_racev->m_pInfo->motor_op));
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_2(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload = pframe->payload();
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    // assume frame integrity guarded by caller
    p_racev->m_pInfo->abs = (payload[2] & 0x03);
    p_racev->m_pInfo->ecas_warn = (payload[2] & 0x0C) >> 2;
    p_racev->m_pInfo->lining = (payload[2] & 0x30) >> 4;
    p_racev->m_pInfo->emergency_exit = (payload[2] & 0xC0) >> 6;

    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1_Byte_2",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, p_racev->m_pInfo->abs),
        Q_ARG(QVariant, p_racev->m_pInfo->ecas_warn),
        Q_ARG(QVariant, p_racev->m_pInfo->lining),
        Q_ARG(QVariant, p_racev->m_pInfo->emergency_exit));
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_3(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    //qDebug() << "VCU_HMI_Msg_1+";
    QByteArray payload = pframe->payload();
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    // assume frame integrity guarded by caller
    p_racev->m_pInfo->motor_alarm = (payload[3] & 0x03);
    p_racev->m_pInfo->air_alarm = (payload[3] & 0x0C) >> 2;
    p_racev->m_pInfo->psteering_alarm = (payload[3] & 0x30) >> 4;
    p_racev->m_pInfo->mpower_alarm = (payload[3] & 0xC0) >> 6;

    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1_Byte_3",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, p_racev->m_pInfo->motor_alarm),
        Q_ARG(QVariant, p_racev->m_pInfo->air_alarm),
        Q_ARG(QVariant, p_racev->m_pInfo->psteering_alarm),
        Q_ARG(QVariant, p_racev->m_pInfo->mpower_alarm));
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_4(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    // cout << "VCU_HMI_Msg_1+" << endl;
    QByteArray payload = pframe->payload();
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev); // TODO: review redudant assignment

    p_racev->m_pInfo->v24_alarm = (payload[4] & 0x03); // TODO: bit shifting?
#if 0 // TODO: yellow area, TBD
    lv_alarm = (payload[4] & 0x04) >> 2;
    charge_abort = (payload[4] & 0x30) >> 4;
    brake = (payload[4] & 0xC0) >> 6;
    wiper = (payload[4] & 0xC0) >> 6;
    lb_light = (payload[4] & 0xC0) >> 6;
#endif
    QMetaObject::invokeMethod(pDstVw,"update_VCU_HMI_Msg_1_Byte_4",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, p_racev->m_pInfo->v24_alarm),
        Q_ARG(QVariant, p_racev->m_pInfo->lv_alarm),
        Q_ARG(QVariant, p_racev->m_pInfo->charge_abort),
        Q_ARG(QVariant, p_racev->m_pInfo->brake),
        Q_ARG(QVariant, p_racev->m_pInfo->wiper),
        Q_ARG(QVariant, p_racev->m_pInfo->lb_light));
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_5(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    // cout << "VCU_HMI_Msg_1+" << endl;
    QByteArray payload;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    payload = pframe->payload();
    p_racev->m_pInfo->gear = (payload[5] & 0x07);
    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1_Byte_5",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, p_racev->m_pInfo->gear));
    return;
}

void Handler_VCU_HMI_MSG01::updateMessage_VCU_HMI_Msg_1_Byte_6(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    QByteArray payload = pframe->payload();
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    try {
	// assume frame integrity guarded by caller
	p_racev->m_pInfo->reading = (payload[6]&0xFF) + ((payload[7]&0xFF)<<8);
	p_racev->m_pInfo->speed = static_cast<int>(
	    static_cast<float>(p_racev->m_pInfo->reading)/static_cast<float>(100));
	if ( p_racev->m_pInfo->speed < SPEED_LLIMIT
	    || SPEED_ULIMIT <= p_racev->m_pInfo->speed ) {
	    cout <<__FILE__ << ":" << __LINE__<< " !" << endl;
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
	p_racev->m_pInfo->addSpeedMAFilter(p_racev->m_pInfo->speed);
	// TODO:
#if 0
	qDebug() << "speed" << speed << "MA" << p_info->m_speed;
#endif
	QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_1_Byte_6",
	Qt::BlockingQueuedConnection,
	Q_RETURN_ARG(QVariant, returnedValue),
	Q_ARG(QVariant, p_racev->m_pInfo->speed));
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }

ERROR_HANDLER:
    return;
}
