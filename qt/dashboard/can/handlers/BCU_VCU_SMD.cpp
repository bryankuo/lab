#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BCU_VCU_SMD.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BCU_VCU_SMD::BCU_VCU_SMD
///
/// HMI context
///
Handler_BCU_VCU_SMD::Handler_BCU_VCU_SMD(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BCU_VCU_SMD() +";
}

Handler_BCU_VCU_SMD::~Handler_BCU_VCU_SMD() {
    //qDebug() << "Handler_BCU_VCU_SMD() ~";
}

void Handler_BCU_VCU_SMD::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    // unsigned int ds1 = 0, ds2 = 0, ds3 = 0, ds4 = 0, ds5 = 0, ds6 = 0;
    int td1 = 0, td2 = 0, td3 = 0, td4 = 0, td5 = 0, td6 = 0;

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

	p_racev->m_pInfo->smoke_detect[0] = (payload[0]&0x01);
	p_racev->m_pInfo->smoke_detect[1] = ((payload[0]&0x02)>>1);
	p_racev->m_pInfo->smoke_detect[2] = ((payload[0]&0x04)>>2);
	p_racev->m_pInfo->smoke_detect[3] = ((payload[0]&0x08)>>3);
	p_racev->m_pInfo->smoke_detect[4] = ((payload[0]&0x10)>>4);
	p_racev->m_pInfo->smoke_detect[5] = ((payload[0]&0x20)>>5);
	p_racev->m_pInfo->smoke_detect[6] = 0; // TBD
	p_racev->m_pInfo->smoke_detect[7] = 0; // TBD

	td1 = (payload[2]&0xFF) + OFFSET_TEMP;
	if ( td1 < MIN_TEMP ) td1 = MIN_TEMP;
	if ( MAX_TEMP < td1 ) td1 = MAX_TEMP;

	td2 = (payload[3]&0xFF) + OFFSET_TEMP;
	if ( td2 < MIN_TEMP ) td2 = MIN_TEMP;
	if ( MAX_TEMP < td2 ) td2 = MAX_TEMP;

	td3 = (payload[4]&0xFF) + OFFSET_TEMP;
	if ( td3 < MIN_TEMP ) td3 = MIN_TEMP;
	if ( MAX_TEMP < td3 ) td3 = MAX_TEMP;

	td4 = (payload[5]&0xFF) + OFFSET_TEMP;
	if ( td4 < MIN_TEMP ) td4 = MIN_TEMP;
	if ( MAX_TEMP < td4 ) td4 = MAX_TEMP;

	td5 = (payload[6]&0xFF) + OFFSET_TEMP;
	if ( td5 < MIN_TEMP ) td5 = MIN_TEMP;
	if ( MAX_TEMP < td5 ) td5 = MAX_TEMP;

	td6 = (payload[7]&0xFF) + OFFSET_TEMP;
	if ( td6 < MIN_TEMP ) td6 = MIN_TEMP;
	if ( MAX_TEMP < td6 ) td6 = MAX_TEMP;

	if ( pDstVw == p_racev->m_pWinBcuDigital ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_SMD",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, td1),
		Q_ARG(QVariant, td2),
		Q_ARG(QVariant, td3),
		Q_ARG(QVariant, td4),
		Q_ARG(QVariant, td5),
		Q_ARG(QVariant, td6));
	}
	if ( pDstVw == p_racev->m_pWinBcuAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_SMD_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[0]),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[1]),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[2]),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[3]),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[4]),
		Q_ARG(QVariant, p_racev->m_pInfo->smoke_detect[5]));
	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

