#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_SYS_1.h"

///
/// \brief Handler_PCU_ST_SYS_1::PCU_ST_SYS_1
///
/// HMI context
///
Handler_PCU_ST_SYS_1::Handler_PCU_ST_SYS_1(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_SYS_1() +";
}

Handler_PCU_ST_SYS_1::~Handler_PCU_ST_SYS_1() {
    //qDebug() << "Handler_PCU_ST_SYS_1() ~";
}

void Handler_PCU_ST_SYS_1::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    unsigned int run = 0, fault = 0, warning = 0;
    QString s_bcu_alarm_lcounter;
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
    i = 0; run = (payload[i]&0x03); fault = ((payload[i]&0x0C)>>2);
	warning = ((payload[i]&0x30)>>4);
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_SYS_1",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, run ),
	    Q_ARG(QVariant, fault ),
	    Q_ARG(QVariant, warning));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

