#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_ST_MOT_2.h"

///
/// \brief Handler_PCU_ST_MOT_2::PCU_ST_MOT_2
///
/// HMI context
///
Handler_PCU_ST_MOT_2::Handler_PCU_ST_MOT_2(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_ST_MOT_2() +";
}

Handler_PCU_ST_MOT_2::~Handler_PCU_ST_MOT_2() {
    //qDebug() << "Handler_PCU_ST_MOT_2() ~";
}

void Handler_PCU_ST_MOT_2::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    float dclc = 0;
    QString s_dclc;
    int mt_run = 0, mt_fault = 0, mt_ready4_run = 0, mt_ready4_ref = 0;
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
	i = 2; dclc = static_cast<float>((payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8)) ;
	dclc *= static_cast<float>(0.05); dclc += static_cast<float>(OFFSET_DCLINK_CURRENT);
	// saturation control
	if ( 1676.75f < dclc ) {
	    dclc = 1676.75f;
	}
	if ( dclc < -1600.0f ) {
	    dclc = -1600.0f;
	}
	s_dclc = QString::number(static_cast<double>(dclc), 'f', 2);
	i = 6; mt_run = ((payload[i]&0x03));
	mt_fault = ((payload[i]&0x0C)>>2);
	mt_ready4_run = ((payload[i]&0x30)>>4);
	mt_ready4_ref = ((payload[i]&0xC0)>>6);
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_ST_MOT_2",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_dclc),
	    Q_ARG(QVariant, mt_run),
	    Q_ARG(QVariant, mt_fault),
	    Q_ARG(QVariant, mt_ready4_run),
	    Q_ARG(QVariant, mt_ready4_ref));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

