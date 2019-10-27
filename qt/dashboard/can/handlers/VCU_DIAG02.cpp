#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_DIAG02.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_VCU_DIAG02::VCU_DIAG02
///
/// HMI context
///
Handler_VCU_DIAG02::Handler_VCU_DIAG02(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_DIAG02() +";
}

Handler_VCU_DIAG02::~Handler_VCU_DIAG02() {
    //qDebug() << "Handler_VCU_DIAG02() ~";
}

void Handler_VCU_DIAG02::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    unsigned int ap_buildup_time = 0;
    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
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
	p_racev->m_pInfo->hyd_rt = static_cast<unsigned int>(
	    (payload[0]&0xFF)+((payload[1]&0xFF)<<8));
	p_racev->m_pInfo->hym_rt = static_cast<unsigned int>(
	    (payload[2]&0xFF)+((payload[3]&0xFF)<<8));
	ap_buildup_time = static_cast<unsigned int>((payload[6]&0xFF));
	if ( pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinSteering ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_VCU_DIAG02",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->hyd_rt),
		Q_ARG(QVariant, p_racev->m_pInfo->hym_rt),
		Q_ARG(QVariant, ap_buildup_time));
	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

