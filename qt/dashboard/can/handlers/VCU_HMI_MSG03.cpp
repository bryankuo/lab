#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_HMI_MSG03.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_VCU_HMI_MSG03::VCU_HMI_MSG03
///
/// HMI context
///
Handler_VCU_HMI_MSG03::Handler_VCU_HMI_MSG03(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_HMI_MSG03() +";
}

Handler_VCU_HMI_MSG03::~Handler_VCU_HMI_MSG03() {
    //qDebug() << "Handler_VCU_HMI_MSG03() ~";
}

void Handler_VCU_HMI_MSG03::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    QString s_total,s_trip;
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
	p_racev->m_pInfo->total = (payload[0]&0xFF) + ((payload[1]&0xFF)<<8)
	+ ((payload[2]&0xFF)<<16) + ((payload[3]&0xFF)<<24);
	if ( p_racev->m_pInfo->total < MIN_MILAGE
	    || MAX_MILAGE <= p_racev->m_pInfo->total ) {
	    cout << __FILE__ << ":" << __LINE__ << " mlg!" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->trip = (payload[4]&0xFF) + ((payload[5]&0xFF)<<8)
	+ ((payload[6]&0xFF)<<16) + ((payload[7]&0xFF)<<24);
	if ( 10000000 <= p_racev->m_pInfo->trip ) {
	    p_racev->m_pInfo->trip -= MAX_MILAGE;
	}
	// ( https://stackoverflow.com/a/7235523 )
	s_total.sprintf("%08.1f", p_racev->m_pInfo->total/10.0);
	s_trip.sprintf("%08.1f", p_racev->m_pInfo->trip/10.0);
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << "total" << s_total << "trip" << s_trip;
#endif
	QMetaObject::invokeMethod(pDstVw, "update_VCU_HMI_Msg_3",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_total),
	    Q_ARG(QVariant, s_trip));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    // cout << __FILE__ <<":"<< __LINE__ << " - "<< endl;
    return;
}
