#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QQmlProperty>

#include "../../constants.h"
#include "ALM_MSG00.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG00::ALM_MSG00
///
/// HMI context
///
Handler_ALM_MSG00::Handler_ALM_MSG00(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_ALM_MSG00() +";
}

Handler_ALM_MSG00::~Handler_ALM_MSG00() {
    //qDebug() << "Handler_ALM_MSG00() ~";
}

void Handler_ALM_MSG00::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    uint8_t is_charging_in_progress;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	is_charging_in_progress = (payload[4]&0x01);
	if ( 1 == is_charging_in_progress )
	    cout << __FILE__ << ":" << __LINE__
		<< ": alarm charge in progress." << endl;
	else
	    cout << __FILE__ << ":" << __LINE__
		<< ": alarm charge not in progress." << endl;
	if ( pDstVw &&
	    "true" == QQmlProperty::read(pDstVw, "active") ) {
	    QMetaObject::invokeMethod(pDstVw, "updateALM_MSG00",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, is_charging_in_progress));
	}
	p_racev->m_pInfo->is_charging_in_progress = is_charging_in_progress;
    } catch (const std::exception& ex) {
	cout << "exception: " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

