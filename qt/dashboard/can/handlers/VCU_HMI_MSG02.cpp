#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_HMI_MSG02.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_VCU_HMI_MSG02::VCU_HMI_MSG02
///
/// HMI context
///
Handler_VCU_HMI_MSG02::Handler_VCU_HMI_MSG02(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_HMI_MSG02() +";
}

Handler_VCU_HMI_MSG02::~Handler_VCU_HMI_MSG02() {
    //qDebug() << "Handler_VCU_HMI_MSG02() ~";
}

void Handler_VCU_HMI_MSG02::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    int air_unlock = 0;
    int passenger_unlock = 0; int emergency_unlock = 0;
    int wproff_unlock = 0; int ecas_unlock = 0;
    int isolation_abnormal_unlock = 0; int v24_carlock_unlock = 0;
    QString s_air; QString s_v24;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    cout << __func__ << ":" << __LINE__ << "!" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();

	if ( payload.isEmpty() ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << "!" << endl;
	    goto ERROR_HANDLER;
	}
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->motor_temp = (payload[0]&0xFF) + OFFSET_TEMP;
	if ( p_racev->m_pInfo->motor_temp < MIN_TEMP )
	    p_racev->m_pInfo->motor_temp = MIN_TEMP;
	if ( MAX_TEMP <= p_racev->m_pInfo->motor_temp )
	    p_racev->m_pInfo->motor_temp = MAX_TEMP;
	p_racev->m_pInfo->itank_temp1 = (payload[1]&0xFF) + OFFSET_TEMP;
	p_racev->m_pInfo->otank_temp2 = (payload[2]&0xFF) + OFFSET_TEMP;
	if ( p_racev->m_pInfo->otank_temp2 < LLIMIT_WTEMP )
	    p_racev->m_pInfo->otank_temp2 = LLIMIT_WTEMP;
	if ( ULIMIT_WTEMP < p_racev->m_pInfo->otank_temp2 )
	    p_racev->m_pInfo->otank_temp2 = ULIMIT_WTEMP;

	p_racev->m_pInfo->air_pressure = static_cast<float>((payload[3]&0xFF));
	p_racev->m_pInfo->air_pressure *= static_cast<float>(FACTOR_APRESSURE);
	if ( p_racev->m_pInfo->air_pressure < LLIMIT_APRESSURE )
	    p_racev->m_pInfo->air_pressure = LLIMIT_APRESSURE;
	if ( ULIMIT_APRESSURE < p_racev->m_pInfo->air_pressure )
	    p_racev->m_pInfo->air_pressure = ULIMIT_APRESSURE;
	s_air = QString::number(
	    static_cast<double>(p_racev->m_pInfo->air_pressure), 'f', 1);

	p_racev->m_pInfo->v24 = static_cast<float>((payload[4]&0xFF)+((payload[5]&0xFF)<<8));
	p_racev->m_pInfo->v24 *= static_cast<float>(FACTOR_V24);
	if ( p_racev->m_pInfo->v24 < MIN_V24 )
	    p_racev->m_pInfo->v24 = MIN_V24;
	if ( MAX_V24 < p_racev->m_pInfo->v24 )
	    p_racev->m_pInfo->v24 = MAX_V24;
	s_v24 = QString::number(
		static_cast<double>(p_racev->m_pInfo->v24), 'f', 1);
	air_unlock = (payload[6]&0x02);
	passenger_unlock = (payload[6]&0x04);
	emergency_unlock = (payload[6]&0x08);
	wproff_unlock = (payload[6]&0x10);
	ecas_unlock = (payload[6]&0x20);
	isolation_abnormal_unlock = (payload[6]&0x40);
	v24_carlock_unlock = (payload[6]&0x80);
#if 0
	qDebug() << __FILE__ << ":" << __LINE__
	<<"air_pressure" << p_racev->m_pInfo->air_pressure
	<< "motor_temp" << p_racev->m_pInfo->motor_temp
	<< "otank_temp2" << p_racev->m_pInfo->otank_temp2
	<< "v24" << p_racev->m_pInfo->v24;
#endif
	if ( pDstVw == p_racev->m_pWinDcdc
	    || pDstVw == p_racev->m_pWinUnlock
	    || pDstVw == p_racev->m_pWinMain ) {
	    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_2_Byte_0_5",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_air),
		Q_ARG(QVariant, p_racev->m_pInfo->motor_temp),
		Q_ARG(QVariant, p_racev->m_pInfo->otank_temp2),
		Q_ARG(QVariant, s_v24));
	}

	if ( /*pDstVw == p_racev->m_pWinDcdc
	    || */pDstVw == p_racev->m_pWinUnlock
	    || pDstVw == p_racev->m_pWinMain ) {
	    QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_2_Byte_6",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, air_unlock),
		Q_ARG(QVariant, passenger_unlock),
		Q_ARG(QVariant, emergency_unlock),
		Q_ARG(QVariant, wproff_unlock),
		Q_ARG(QVariant, ecas_unlock),
		Q_ARG(QVariant, isolation_abnormal_unlock),
		Q_ARG(QVariant, v24_carlock_unlock));
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

