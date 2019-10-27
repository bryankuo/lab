#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QQmlProperty>

#include "../../constants.h"
#include "BMS_VCU_MSG04.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BMS_VCU_MSG04::BMS_VCU_MSG04
///
/// HMI context
///
Handler_BMS_VCU_MSG04::Handler_BMS_VCU_MSG04(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_VCU_MSG04() +";
}

Handler_BMS_VCU_MSG04::~Handler_BMS_VCU_MSG04() {
    //qDebug() << "Handler_BMS_VCU_MSG04() ~";
}

void Handler_BMS_VCU_MSG04::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    uint8_t charging_state;
    unsigned int battery_type = 0; float ri_voltage = 0;
    unsigned int bms_code = 0; QString s_ri_voltage;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	charging_state = (payload[0]&0xFF);
	battery_type = (payload[1]&0xFF);
	ri_voltage = static_cast<float>(
	    (payload[2]&0xFF) + ((payload[3]&0xFF)<<8) );
	ri_voltage *= static_cast<float>(FACTOR_VOLTAGE);
	s_ri_voltage = QString::number(static_cast<double>(ri_voltage), 'f', 1);
	bms_code = (payload[6]&0xFF);
	if ( p_racev->m_pInfo->charging_state != charging_state ) {
	    switch ( charging_state ) {
		case 0:
		    cout << __FILE__ << ":" << __LINE__ << ": bms4 charging is not running" << endl;
		break;
		case 1:
		    cout << __FILE__ << ":" << __LINE__ << ": bms4 charging is in progress" << endl;
		break;
		case 2:
		    cout << __FILE__ << ":" << __LINE__ << ": bms4 charging is done" << endl;
		break;
		case 3:
		    cout << __FILE__ << ":" << __LINE__ << ": bms4 charging is under balancing" << endl;
		break;
		default:
		break;
	    }
	}

	// TODO: and is active?
	if ( pDstVw ) {
	    QMetaObject::invokeMethod(pDstVw, "updateBMS_VCU_MSG04",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, charging_state),
		Q_ARG(QVariant, battery_type),
		Q_ARG(QVariant, s_ri_voltage),
		Q_ARG(QVariant, bms_code));
	}
	p_racev->m_pInfo->charging_state = charging_state;
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

