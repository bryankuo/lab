#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_MOT_3.h"

///
/// \brief Handler_PCU_ST_MOT_3::PCU_ST_MOT_3
///
/// HMI context
///
Handler_PCU_ST_MOT_3::Handler_PCU_ST_MOT_3(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_MOT_3() +";
}

Handler_PCU_ST_MOT_3::~Handler_PCU_ST_MOT_3() {
    //qDebug() << "Handler_PCU_ST_MOT_3() ~";
}

void Handler_PCU_ST_MOT_3::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    int temp1 = 0, temp2 = 0;
    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
    if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	// TODO: to be defined
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_MOT_3",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, temp1),
	    Q_ARG(QVariant, temp2));
    } catch (const std::exception& ex) {
    cout << __FILE__ << ":" << __LINE__ << " exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

