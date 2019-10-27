#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_SYS_4.h"

///
/// \brief Handler_PCU_ST_SYS_4::PCU_ST_SYS_4
///
/// HMI context
///
Handler_PCU_ST_SYS_4::Handler_PCU_ST_SYS_4(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_SYS_4() +";
}

Handler_PCU_ST_SYS_4::~Handler_PCU_ST_SYS_4() {
    //qDebug() << "Handler_PCU_ST_SYS_4() ~";
}

void Handler_PCU_ST_SYS_4::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    unsigned int code2 = 0;
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
	i = 0; code2 = (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8)
	    + ((payload[i+2]&0xFF)<<16)+ ((payload[i+3]&0xFF)<<24);
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_SYS_4",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, code2));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

