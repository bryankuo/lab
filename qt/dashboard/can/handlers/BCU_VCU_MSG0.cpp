#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BCU_VCU_MSG0.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BCU_VCU_MSG0::BCU_VCU_MSG0
///
/// HMI context
///
Handler_BCU_VCU_MSG0::Handler_BCU_VCU_MSG0(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BCU_VCU_MSG0() +";
}

Handler_BCU_VCU_MSG0::~Handler_BCU_VCU_MSG0() {
    //qDebug() << "Handler_BCU_VCU_MSG0() ~";
}

void Handler_BCU_VCU_MSG0::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    unsigned int bcu_lcounter = 0;
    QString s_bcu_lcounter;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    unsigned int f_openfdoor = 0, f_openbdoor = 0, emgdoor_s = 0, fdo_sensor = 0,
	bdo_sensor = 0, edl_fb = 0, do_signal = 0, collision_s1 = 0;
    unsigned int collision_s2 = 0, collision_s3 = 0, collision_s4 = 0,
	collision_s5 = 0, collision_s6 = 0, assist_gob = 0, assist_gfb = 0,
	gfb = 0;
    unsigned int dfs_fb = 0, ramp_rl = 0, hzwl_switch = 0,
	wpi_switch = 0, ltsig_switch = 0, rtsig_switch = 0, pkl_switch = 0;
    unsigned int lb_switch, hb_switch, fogl_switch, hotl_switch;
    unsigned int pking_l = 0, lb_lights = 0, hb_lights = 0, tleft_lights = 0;
    unsigned int tright_lights, bkup_l, brake_l, ts_buzzer, fog_l,
	interior_l, wpi, do_signal_fr = 0;
    unsigned int get_off_bb = 0, emgd_lt = 0, brk2_ecas = 0, dw_buzz_s = 0;

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

	f_openfdoor = (payload[0]&0x01);
	f_openbdoor = ((payload[0]&0x02)>>1);
	emgdoor_s = ((payload[0]&0x04)>>2);
	fdo_sensor = ((payload[0]&0x08)>>3);
	bdo_sensor = ((payload[0]&0x10)>>4);
	edl_fb = ((payload[0]&0x20)>>5);
	do_signal = ((payload[0]&0x40)>>6);
	collision_s1 = ((payload[0]&0x80)>>7);

	collision_s2 = (payload[1]&0x01);
	collision_s3 = ((payload[1]&0x02)>>1);
	collision_s4 = ((payload[1]&0x04)>>2);
	collision_s5 = ((payload[1]&0x08)>>3);
	collision_s6 = ((payload[1]&0x10)>>4);
	assist_gob = ((payload[1]&0x20)>>5);
	assist_gfb = ((payload[1]&0x40)>>6);
	gfb = ((payload[1]&0x80)>>7);

	dfs_fb = (payload[2]&0x01);
	p_racev->m_pInfo->ac_switch = ((payload[2]&0x02)>>1);
	ramp_rl = ((payload[2]&0x04)>>2);
	hzwl_switch = ((payload[2]&0x08)>>3);
	wpi_switch = ((payload[2]&0x10)>>4);
	ltsig_switch = ((payload[2]&0x20)>>5);
	rtsig_switch = ((payload[2]&0x40)>>6);
	pkl_switch = ((payload[2]&0x80)>>7);

	lb_switch = (payload[3]&0x01);
	hb_switch = ((payload[3]&0x02)>>1);
	fogl_switch = ((payload[3]&0x04)>>2);
	hotl_switch = ((payload[3]&0x08)>>3);
	p_racev->m_pInfo->abs_alarm = ((payload[3]&0x10)>>4);
	p_racev->m_pInfo->fl_lining = ((payload[3]&0x20)>>5);
	p_racev->m_pInfo->fr_lining = ((payload[3]&0x40)>>6);
	p_racev->m_pInfo->rl_lining = ((payload[3]&0x80)>>7);

	p_racev->m_pInfo->rr_lining = ((payload[4]&0x01));
	p_racev->m_pInfo->ecas33f = ((payload[4]&0x02)>>1);
	p_racev->m_pInfo->ecas_kneeling = ((payload[4]&0x04)>>2);
	p_racev->m_pInfo->ecas34w = ((payload[4]&0x08)>>3);
	pking_l = ((payload[4]&0x10)>>4);
	lb_lights = ((payload[4]&0x20)>>5);
	hb_lights = ((payload[4]&0x40)>>6);
	tleft_lights = ((payload[4]&0x80)>>7);

	tright_lights = ((payload[5]&0x01));
	bkup_l = ((payload[5]&0x02)>>1);
	brake_l = ((payload[5]&0x04)>>2);
	ts_buzzer = ((payload[5]&0x08)>>3);
	fog_l = ((payload[5]&0x10)>>4);
	interior_l = ((payload[5]&0x20)>>5);
	wpi = ((payload[5]&0x40)>>6);
	do_signal_fr = ((payload[5]&0x80)>>7);

	get_off_bb = ((payload[6]&0x01));
	emgd_lt = ((payload[6]&0x02)>>1);
	brk2_ecas = ((payload[6]&0x04)>>2);
	dw_buzz_s = ((payload[6]&0x08)>>3);

	i = 7; bcu_lcounter = (payload[i]&0xFF);
	s_bcu_lcounter = QString("%1").arg(bcu_lcounter, 2, 16, QChar('0')).toUpper();
	if ( pDstVw == p_racev->m_pWinDiagnose
	    || pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinBcuAnalog
	    || pDstVw == p_racev->m_pWinBcuDigital ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->abs_alarm),
		Q_ARG(QVariant, p_racev->m_pInfo->fl_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->fr_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->rl_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->rr_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas33f),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas_kneeling),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas34w),
		Q_ARG(QVariant, s_bcu_lcounter));
	}

	if ( pDstVw == p_racev->m_pWinBcuAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, f_openfdoor),
		Q_ARG(QVariant, f_openbdoor),
		Q_ARG(QVariant, emgdoor_s),
		Q_ARG(QVariant, fdo_sensor),
		Q_ARG(QVariant, bdo_sensor),
		Q_ARG(QVariant, edl_fb),
		Q_ARG(QVariant, do_signal),
		Q_ARG(QVariant, collision_s1));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, collision_s2),
		Q_ARG(QVariant, collision_s3),
		Q_ARG(QVariant, collision_s4),
		Q_ARG(QVariant, collision_s5),
		Q_ARG(QVariant, collision_s6),
		Q_ARG(QVariant, assist_gob),
		Q_ARG(QVariant, assist_gfb),
		Q_ARG(QVariant, gfb));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte2",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, dfs_fb),
		Q_ARG(QVariant, p_racev->m_pInfo->ac_switch),
		Q_ARG(QVariant, ramp_rl),
		Q_ARG(QVariant, hzwl_switch),
		Q_ARG(QVariant, wpi_switch),
		Q_ARG(QVariant, ltsig_switch),
		Q_ARG(QVariant, rtsig_switch),
		Q_ARG(QVariant, pkl_switch));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte3",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, lb_switch),
		Q_ARG(QVariant, hb_switch),
		Q_ARG(QVariant, fogl_switch),
		Q_ARG(QVariant, hotl_switch),
		Q_ARG(QVariant, p_racev->m_pInfo->abs_alarm),
		Q_ARG(QVariant, p_racev->m_pInfo->fl_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->fr_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->rl_lining));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte4",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->rr_lining),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas33f),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas_kneeling),
		Q_ARG(QVariant, p_racev->m_pInfo->ecas34w),
		Q_ARG(QVariant, pking_l),
		Q_ARG(QVariant, lb_lights),
		Q_ARG(QVariant, hb_lights),
		Q_ARG(QVariant, tleft_lights));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte5",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, tright_lights),
		Q_ARG(QVariant, bkup_l),
		Q_ARG(QVariant, brake_l),
		Q_ARG(QVariant, ts_buzzer),
		Q_ARG(QVariant, fog_l),
		Q_ARG(QVariant, interior_l),
		Q_ARG(QVariant, wpi),
		Q_ARG(QVariant, do_signal_fr));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BCU_VCU_MSG0_Byte6",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, get_off_bb),
		Q_ARG(QVariant, emgd_lt),
		Q_ARG(QVariant, brk2_ecas),
		Q_ARG(QVariant, dw_buzz_s));
	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

