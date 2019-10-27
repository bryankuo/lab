#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_DIAG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_VCU_DIAG01::VCU_DIAG01
///
/// HMI context
///
Handler_VCU_DIAG01::Handler_VCU_DIAG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_DIAG01() +";
}

Handler_VCU_DIAG01::~Handler_VCU_DIAG01() {
    //qDebug() << "Handler_VCU_DIAG01() ~";
}

void Handler_VCU_DIAG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
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
	// Traction
	i = 0; p_racev->m_pInfo->main_dvr_rt = static_cast<unsigned int>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8));
	i = 2; p_racev->m_pInfo->main_mt_rt = static_cast<unsigned int>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8));

	// Brake
	i = 4; p_racev->m_pInfo->penumatic_dvr_rt = static_cast<unsigned int>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8));
	i = 6; p_racev->m_pInfo->penumatic_mt_rt = static_cast<unsigned int>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8));
#if 0
	cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__
	    << " brake "<< endl;
#endif

	if ( pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinTraction ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_VCU_DIAG01",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->main_dvr_rt),
		Q_ARG(QVariant, p_racev->m_pInfo->main_mt_rt),
		Q_ARG(QVariant, p_racev->m_pInfo->penumatic_dvr_rt),
		Q_ARG(QVariant, p_racev->m_pInfo->penumatic_mt_rt));
	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

