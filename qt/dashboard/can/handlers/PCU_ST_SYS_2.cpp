#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_SYS_2.h"

///
/// \brief Handler_PCU_ST_SYS_2::PCU_ST_SYS_2
///
/// HMI context
///
Handler_PCU_ST_SYS_2::Handler_PCU_ST_SYS_2(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_SYS_2() +";
}

Handler_PCU_ST_SYS_2::~Handler_PCU_ST_SYS_2() {
    //qDebug() << "Handler_PCU_ST_SYS_2() ~";
}

void Handler_PCU_ST_SYS_2::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    int temp = 0;
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
	i = 3; temp = (payload[i]&0xFF) + OFFSET_MTEMP;
	// saturation control
	if ( ULIMIT_MTEMP < temp ) {
	    temp = ULIMIT_MTEMP;
	}
	if ( temp < LLIMIT_MTEMP ) {
	    temp = LLIMIT_MTEMP;
	}
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_SYS_2",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, temp));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

