#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QQmlProperty>

#include "../../constants.h"
#include "BMS_OBC_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BMS_OBC_MSG01::BMS_OBC_MSG01
///
/// HMI context
///
Handler_BMS_OBC_MSG01::Handler_BMS_OBC_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_OBC_MSG01() +";
}

Handler_BMS_OBC_MSG01::~Handler_BMS_OBC_MSG01() {
    //qDebug() << "Handler_BMS_OBC_MSG01() ~";
}

void Handler_BMS_OBC_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    QString s_mx_allowed_chg_voltage; QString s_mx_allowed_chg_current;
    uint8_t charger_enable;
    // TODO: kwh calculation on the screen
    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    cout << __FILE__ << ":" << __LINE__ << "!" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->mx_allowed_chg_voltage = static_cast<float>(
	    (payload[0]&0xFF) + ((payload[1]&0xFF)<<8) )/static_cast<float>(10);
	// saturation control
	if ( MAX_CHARGE_VOLTAGE < p_racev->m_pInfo->mx_allowed_chg_voltage ) {
	    p_racev->m_pInfo->mx_allowed_chg_voltage = MAX_CHARGE_VOLTAGE;
	}
	if ( p_racev->m_pInfo->mx_allowed_chg_voltage <= MIN_CHARGE_VOLTAGE ) {
	    p_racev->m_pInfo->mx_allowed_chg_voltage = MIN_CHARGE_VOLTAGE;
	}

	p_racev->m_pInfo->mx_allowed_chg_current
	    = abs( static_cast<float>((payload[2]&0xFF)
		+ ((payload[3]&0xFF)<<8) + OFFSET_CURRENT ));
	p_racev->m_pInfo->mx_allowed_chg_current *= static_cast<float>(FACTOR_CURRENT);
	// assume saturation control
	if ( MAX_CHARGE_CURRENT < p_racev->m_pInfo->mx_allowed_chg_current ) {
	    p_racev->m_pInfo->mx_allowed_chg_current = MAX_CHARGE_CURRENT;
	}
	if ( p_racev->m_pInfo->mx_allowed_chg_current <= MIN_CHARGE_CURRENT ) {
	    p_racev->m_pInfo->mx_allowed_chg_current = MIN_CHARGE_CURRENT;
	}
	p_racev->m_pInfo->chg_time_left_mins
	    = static_cast<unsigned int>(
		    (payload[4]&0xFF)+((payload[5]&0xFF)<<8));

	// TODO: check if any value is greater than 600 mins
	// assume BMS handles this.

	p_racev->m_pInfo->num_chg_times
	    = (payload[6]&0xFF)+((payload[7]&0x3F)<<8);

	charger_enable = (payload[7]&0xC0)>>6;
	if ( p_racev->m_pInfo->charger_enable == 0 && charger_enable == 1 )
	    cout << __FILE__ << ":" << __LINE__ << ": charger enable" << endl;
	if ( p_racev->m_pInfo->charger_enable == 1 && charger_enable == 0 )
	    cout << __FILE__ << ":" << __LINE__ << ": charger disable" << endl;

	s_mx_allowed_chg_voltage
	    = QString::number(static_cast<double>(
		p_racev->m_pInfo->mx_allowed_chg_voltage), 'f', 1);
	s_mx_allowed_chg_current = QString::number(
	    static_cast<double>(
		p_racev->m_pInfo->mx_allowed_chg_current), 'f', 1);
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << mx_allowed_chg_current << " " << s_mx_allowed_chg_current;
#endif

	if ( pDstVw &&
	    "true" == QQmlProperty::read(pDstVw, "active") ) {
	    QMetaObject::invokeMethod(pDstVw, "updateBMS_OCU_Msg01",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_mx_allowed_chg_voltage),
	    Q_ARG(QVariant, s_mx_allowed_chg_current),
	    Q_ARG(QVariant, p_racev->m_pInfo->chg_time_left_mins),
	    Q_ARG(QVariant, p_racev->m_pInfo->num_chg_times),
	    Q_ARG(QVariant, charger_enable));
	}
	p_racev->m_pInfo->charger_enable = charger_enable;
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    cout << __FILE__ <<":"<< __LINE__ << " - " << endl;
    return;
}

