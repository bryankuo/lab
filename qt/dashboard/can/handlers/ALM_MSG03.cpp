#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "ALM_MSG03.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG03::ALM_MSG03
///
/// HMI context
///
Handler_ALM_MSG03::Handler_ALM_MSG03(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_ALM_MSG03() +";
}

Handler_ALM_MSG03::~Handler_ALM_MSG03() {
    //qDebug() << "Handler_ALM_MSG03() ~";
}

void Handler_ALM_MSG03::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;

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
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

