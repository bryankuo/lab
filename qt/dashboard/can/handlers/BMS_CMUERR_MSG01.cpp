#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BMS_CMUERR_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BMS_CMUERR_MSG01::BMS_CMUERR_MSG01
///
/// HMI context
///
Handler_BMS_CMUERR_MSG01::Handler_BMS_CMUERR_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_CMUERR_MSG01() +";
}

Handler_BMS_CMUERR_MSG01::~Handler_BMS_CMUERR_MSG01() {
    //qDebug() << "Handler_BMS_CMUERR_MSG01() ~";
}

void Handler_BMS_CMUERR_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    unsigned int b0, b1, b2, b3, b4, b5, b6, b7; int i;
#define NUM_BYTE 8

    const char* fn_call[NUM_BYTE] = {
	"updateBMS_CMUERR_MSG01_Byte0",
	"updateBMS_CMUERR_MSG01_Byte1",
	"updateBMS_CMUERR_MSG01_Byte2",
	"updateBMS_CMUERR_MSG01_Byte3",
	"updateBMS_CMUERR_MSG01_Byte4",
	"updateBMS_CMUERR_MSG01_Byte5",
	"updateBMS_CMUERR_MSG01_Byte6",
	"updateBMS_CMUERR_MSG01_Byte7"
    };

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

	for ( i = 0; i < NUM_BYTE; i++ ) {
	    b0 = (payload[i]&0x01);
	    b1 = ((payload[i]&0x02)>>1);
	    b2 = ((payload[i]&0x04)>>2);
	    b3 = ((payload[i]&0x08)>>3);
	    b4 = ((payload[i]&0x10)>>4);
	    b5 = ((payload[i]&0x20)>>5);
	    b6 = ((payload[i]&0x40)>>6);
	    b7 = ((payload[i]&0x80)>>7);
	    QMetaObject::invokeMethod(pDstVw, fn_call[i],
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, b0),
		Q_ARG(QVariant, b1),
		Q_ARG(QVariant, b2),
		Q_ARG(QVariant, b3),
		Q_ARG(QVariant, b4),
		Q_ARG(QVariant, b5),
		Q_ARG(QVariant, b6),
		Q_ARG(QVariant, b7));
#if 0 //defined (QT_DEBUG)
	    cout << typeid(*this).name()
		<< "::" << __func__ <<":"<< __LINE__ << " i " << i
		<< " " << fn_call[i] << endl;
#endif
	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

