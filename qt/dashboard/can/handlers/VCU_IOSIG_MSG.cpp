#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "VCU_IOSIG_MSG.h"
#include "../../racev.h"

///
/// \brief Handler_VCU_IOSIG_MSG::VCU_IOSIG_MSG
///
/// HMI context
///
Handler_VCU_IOSIG_MSG::Handler_VCU_IOSIG_MSG(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_IOSIG_MSG() +";
}

Handler_VCU_IOSIG_MSG::~Handler_VCU_IOSIG_MSG() {
    //qDebug() << "Handler_VCU_IOSIG_MSG() ~";
}

void Handler_VCU_IOSIG_MSG::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; /*int i = 0;*/ QByteArray payload;
    int mctactor = 0, p3keyon = 0, p4Start = 0, hv_ctr = 0, pc_ctr = 0;
    unsigned int l_detect = 0;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    unsigned int g_sensor = 0, gs1 = 0, gs2 = 0, gs3 = 0,
	gs4 = 0, speed_s = 0, bms_kick_vcu = 0, start_b = 0;
    unsigned int hpc_fb = 0, ac_fb = 0, cpc_fb = 0, cmc_fb = 0,
	nw_bms = 0, p3ko = 0, p4start = 0, hv_contract = 0;
    unsigned int pf_contractor = 0, ac_cntr = 0, cp_cntr = 0, cm_cntr = 0,
	dcdc_cntr = 0, lkd_cntr = 0;
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

	mctactor = (payload[1]&0x01);
	p3keyon = ((payload[1]&0x20)>>5);
	p4Start = ((payload[1]&0x40)>>6);
	hv_ctr = ((payload[1]&0x80)>>7);
	pc_ctr = (payload[2]&0x01);
	l_detect = (payload[3]&0xFF);
#if 0
	cout << __func__ << ":" << __LINE__ << " "
	    << std::hex << "0x" << ctrl_mode << " 0x" << mtr_cmd << std::dec
	    << endl;
#endif
	g_sensor = (payload[0]&0x01);
	gs1 = ((payload[0]&0x02)>>1);
	gs2 = ((payload[0]&0x04)>>2);
	gs3 = ((payload[0]&0x08)>>3);
	gs4 = ((payload[0]&0x10)>>4);
	speed_s = ((payload[0]&0x20)>>5);
	bms_kick_vcu = ((payload[0]&0x40)>>6);
	start_b = ((payload[0]&0x80)>>7);

	hpc_fb = (payload[1]&0x01);
	ac_fb = ((payload[1]&0x02)>>1);
	cpc_fb = ((payload[1]&0x04)>>2);
	cmc_fb = ((payload[1]&0x08)>>3);
	nw_bms = ((payload[1]&0x10)>>4);
	p3ko = ((payload[1]&0x20)>>5);
	p4start = ((payload[1]&0x40)>>6);
	hv_contract = ((payload[1]&0x80)>>7);

	pf_contractor = (payload[2]&0x01);
	ac_cntr = ((payload[2]&0x02)>>1);
	cp_cntr = ((payload[2]&0x04)>>2);
	cm_cntr = ((payload[2]&0x08)>>3);
	dcdc_cntr = ((payload[2]&0x10)>>4);
	lkd_cntr = ((payload[2]&0x20)>>5);

	if ( pDstVw == p_racev->m_pWinDiagnose
	    || pDstVw == p_racev->m_pWinTraction ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_VCU_IOSIG_MSG",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, mctactor),
		Q_ARG(QVariant, p3keyon),
		Q_ARG(QVariant, p4Start),
		Q_ARG(QVariant, hv_ctr),
		Q_ARG(QVariant, pc_ctr));
	}
	else if ( pDstVw == p_racev->m_pWinVcuDigital ) {
	    cout << __func__ << ":" << __LINE__;
	    QMetaObject::invokeMethod(pDstVw,
		"updateMsg_VCU_IOSIG_MSG_Byte3",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, l_detect));
	}
	else if ( pDstVw == p_racev->m_pWinVcuAnalog ) {
	    QMetaObject::invokeMethod(pDstVw,
		"updateMsg_VCU_IOSIG_MSG_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, g_sensor),
		Q_ARG(QVariant, gs1),
		Q_ARG(QVariant, gs2),
		Q_ARG(QVariant, gs3),
		Q_ARG(QVariant, gs4),
		Q_ARG(QVariant, speed_s),
		Q_ARG(QVariant, bms_kick_vcu),
		Q_ARG(QVariant, start_b));
	    QMetaObject::invokeMethod(pDstVw,
		"updateMsg_VCU_IOSIG_MSG_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, hpc_fb),
		Q_ARG(QVariant, ac_fb),
		Q_ARG(QVariant, cpc_fb),
		Q_ARG(QVariant, cmc_fb),
		Q_ARG(QVariant, nw_bms),
		Q_ARG(QVariant, p3ko),
		Q_ARG(QVariant, p4start),
		Q_ARG(QVariant, hv_contract));

	    QMetaObject::invokeMethod(pDstVw,
		"updateMsg_VCU_IOSIG_MSG_Byte2",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, pf_contractor),
		Q_ARG(QVariant, ac_cntr),
		Q_ARG(QVariant, cp_cntr),
		Q_ARG(QVariant, cm_cntr),
		Q_ARG(QVariant, dcdc_cntr),
		Q_ARG(QVariant, lkd_cntr));

	}
	else {
	}

    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

