#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QQmlProperty>

#include "../../constants.h"
#include "BMS_VCU_MSG01.h"
#include "../../racev.h"

///
/// \brief Handler_BMS_VCU_MSG01::BMS_VCU_MSG01
///
/// HMI context
///
Handler_BMS_VCU_MSG01::Handler_BMS_VCU_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_VCU_MSG01() +";
}

Handler_BMS_VCU_MSG01::~Handler_BMS_VCU_MSG01() {
    //qDebug() << "Handler_BMS_VCU_MSG01() ~";
}

void Handler_BMS_VCU_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0;
    QByteArray payload;
    float t_voltage = 0; double t_current = 0; int soc = 0;
    uint8_t bms_state; int f_level = 0; int mcntctr_nc = 0;
    int mcntctr_st = 0; int pcell_alrm = 0; float c_remains = 0;
    QString s_voltage, s_current/*, s_soc, s_bstatus,
    s_flvl, s_mcnt_nc, s_mcnt_st, s_pcellalrm*/, s_cremains;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
#if 0 // defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " + " << endl;
#endif
    try {
	if ( nullptr == pframe ) {
	    cout << __func__ << ":" << __LINE__ << " ! " << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ // typeid(*this).name()
		<<"::" << __func__
		<< ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
#if 0
	qDebug() << __func__ << ":" << __LINE__
	//<< pframe->isValid()
	<< "," << payload.toHex(0);
#endif
	i = 0; t_voltage = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) );
	t_voltage *= static_cast<float>(FACTOR_VOLTAGE);
	if ( t_voltage < MIN_V ) t_voltage = MIN_V;
	if ( MAX_V < t_voltage ) t_voltage = MAX_V;
	s_voltage = QString::number(static_cast<double>(t_voltage), 'f', 1);

	i = 2;
	t_current = static_cast<double>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_CURRENT );
	t_current *= static_cast<double>(FACTOR_CURRENT);
	if ( t_current < MIN_CURRENT ) t_current = MIN_CURRENT;
	if ( MAX_CURRENT < t_current ) t_current = MAX_CURRENT;
	/*if ( t_current < MIN_CURRENT || MAX_A < t_current ) {
	    cout << typeid(*this).name()
		<<"::" << __func__
		<< ":" << __LINE__ << " ! " << endl;
	    goto ERROR_HANDLER;
	}*/

	s_current = QString::number(static_cast<double>(t_current), 'f', 1);

	i = 4; soc = (payload[i]&0xFF);
	if ( soc < MIN_SOC ) soc = MIN_SOC;
	if ( MAX_SOC < soc ) soc = MAX_SOC;
	/*if ( soc < MIN_SOC || MAX_SOC < soc ) {
	    cout << typeid(*this).name()
		<<"::" << __func__
		<< ":" << __LINE__ << " ! " << endl;
	    goto ERROR_HANDLER;
	}*/
	bms_state = (payload[5]&0x03);
#if defined ( QT_DEBUG )
	if ( p_racev->m_pInfo->bms_state != bms_state )
	    switch ( bms_state ) {
		case 0:
		    cout << __FILE__ << ":" << __LINE__ << ": bms state idle" << endl;
		break;
		case 1:
		    cout << __FILE__ << ":" << __LINE__ << ": bms state discharge." << endl;
		break;
		case 2:
		    cout << __FILE__ << ":" << __LINE__ << ": bms state is charging." << endl;
		break;
		case 3:
		    cout << __FILE__ << ":" << __LINE__ << ": bms state is stop/abnormal." << endl;
		break;
		default:
		break;
	    }
#endif

	f_level = ((payload[i]&0x1C)>>2);
	mcntctr_nc = ((payload[i]&0x20)>>5);
	mcntctr_st = ((payload[i]&0x40)>>6);
	pcell_alrm = ((payload[i]&0x80)>>7);

	i = 6; c_remains = static_cast<float>(
	    (payload[i]&0xFF)+((payload[i+1]&0xFF)<<8) );
	c_remains *= static_cast<double>(FACTOR_RMN);
	if ( c_remains < MIN_RMN ) c_remains = MIN_RMN;
	if ( MAX_RMN < c_remains ) c_remains = MAX_RMN;
	s_cremains = QString::number(static_cast<double>(c_remains), 'f', 1);
#if 0
	qDebug() << "v" << s_voltage
	<< "a" << s_current
	<< "soc" << soc
	<< "b" << bms_state
	<< "fl" << f_level
	<< "mctn" << mcntctr_nc
	<< "mcts" << mcntctr_st
	<< "pcal" << pcell_alrm
	<< "crmn" << s_cremains;
#endif
	if ( pDstVw &&
	    "true" == QQmlProperty::read(pDstVw, "active") ) {
	    QMetaObject::invokeMethod(pDstVw, "updateBMS_VCU_MSG01",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_voltage),
		Q_ARG(QVariant, s_current),
		Q_ARG(QVariant, soc),
		Q_ARG(QVariant, bms_state),
		Q_ARG(QVariant, f_level),
		Q_ARG(QVariant, mcntctr_nc),
		Q_ARG(QVariant, mcntctr_st),
		Q_ARG(QVariant, pcell_alrm),
		Q_ARG(QVariant, s_cremains));
	}
	p_racev->m_pInfo->bms_state = bms_state;
    } catch (const std::exception& ex) {
	cout << "exception " << ex.what() << endl;
    }
ERROR_HANDLER:
#if 0
    cout << typeid(*this).name()
	<<"::" << __func__
	<< ":" << __LINE__ << " - " << endl;
#endif
    return;
}

