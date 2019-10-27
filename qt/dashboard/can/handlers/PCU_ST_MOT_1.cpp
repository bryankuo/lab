#include <iostream>
#include <iomanip>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_MOT_1.h"
#include "../../racev.h"

///
/// \brief Handler_PCU_ST_MOT_1::PCU_ST_MOT_1
///
/// HMI context
///
Handler_PCU_ST_MOT_1::Handler_PCU_ST_MOT_1(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_MOT_1() +";
}

Handler_PCU_ST_MOT_1::~Handler_PCU_ST_MOT_1() {
    //qDebug() << "Handler_PCU_ST_MOT_1() ~";
}

void Handler_PCU_ST_MOT_1::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    float rpm = 0, dclv = 0, mechpwr = 0;
    QString s_rpm, s_dclv, s_mechpwr;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
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
	i = 0; rpm = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_RPM) ;
	rpm *= static_cast<float>(FACTOR_RPM);
	if ( ULIMIT_RPM < rpm ) {
	    rpm = ULIMIT_RPM;
	}
	if ( rpm < LLIMIT_RPM ) {
	    rpm = LLIMIT_RPM;
	}

	i = 2; p_racev->m_pInfo->torq =
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_ATORQUE;
	// saturation control
	if ( ULIMIT_TORQUE < p_racev->m_pInfo->torq ) {
	    p_racev->m_pInfo->torq = ULIMIT_TORQUE;
	}
	if ( p_racev->m_pInfo->torq < LLIMIT_TORQUE ) {
	    p_racev->m_pInfo->torq = LLIMIT_TORQUE;
	}

	i = 4; dclv = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8)) ;
	// saturation control
	dclv *= static_cast<float>(FACTOR_DCLV);
	if ( ULIMIT_DCLV < dclv ) {
	    dclv = ULIMIT_DCLV;
	}
	if ( dclv < LLIMIT_DCLV ) {
	    dclv = LLIMIT_DCLV;
	}

	i = 6; mechpwr = static_cast<float>((payload[i]&0xFF)
	    + ((payload[i+1]&0xFF)<<8) + OFFSET_MECHPWR ) ;
	mechpwr *= static_cast<float>(FACTOR_PWR);
	// saturation control
	if ( ULIMIT_MTPWR < mechpwr ) {
	    mechpwr = ULIMIT_MTPWR;
	}
	if ( mechpwr < LLIMIT_MTPWR ) {
	    mechpwr = LLIMIT_MTPWR;
	}
#if 0 //defined ( QT_DEBUG )
	// precision ( https://is.gd/w94aZM )
	// set default precision ( https://is.gd/50cojx )
	std::streamsize ss = std::cout.precision();
	cout << __func__ << ":" << __LINE__
	    << std::fixed << std::setprecision(1)
	    << " rpm " << rpm
	    << std::setprecision(ss)
	    << " toq " << p_racev->m_pInfo->torq
	    << std::fixed << std::setprecision(2)
	    << " dcl " << dclv
	    << std::fixed << std::setprecision(3)
	    << " mpw " << mechpwr
	    << endl;
#endif
	s_rpm = QString::number(static_cast<double>(rpm), 'f', 1);
	s_dclv = QString::number(static_cast<double>(dclv), 'f', 2);
	s_mechpwr = QString::number(static_cast<double>(mechpwr), 'f', 3);

	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_MOT_1",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_rpm),
	    Q_ARG(QVariant, p_racev->m_pInfo->torq),
	    Q_ARG(QVariant, s_dclv),
	    Q_ARG(QVariant, s_mechpwr));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

