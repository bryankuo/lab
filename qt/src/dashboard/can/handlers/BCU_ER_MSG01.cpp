#include <iostream>
#include <bitset>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BCU_ER_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BCU_ER_MSG01::BCU_ER_MSG01
///
/// HMI context
///
Handler_BCU_ER_MSG01::Handler_BCU_ER_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BCU_ER_MSG01() +";
}

Handler_BCU_ER_MSG01::~Handler_BCU_ER_MSG01() {
    //qDebug() << "Handler_BCU_ER_MSG01() ~";
}

/*
 * Assume for each pack, there is only one flag bit set
 */
void Handler_BCU_ER_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue;
    QByteArray prev_payload, payload;
    int bcu_alarm_lcounter = 0, bms_ierr = 0, vsam_err = 0,
	tsam_err = 0, ccom_err = 0, cer_err = 0, chot = 0, ch_scerr = 0, ch_wcerr = 0;
    QString s_bcu_alarm_lcounter;
    // ch: charge, ds: drive/stop
    int ch_shv = 0, ds_shv = 0, ch_whv = 0,
	ds_whv = 0, ds_slv = 0, ds_wlv = 0, ds_hdv = 0, ds_lsoc = 0;
    int sht_ch, sht_ds, wht_ch, wht_ds, slt_ch, slt_ds, wlt_ch, wlt_ds;
    // shutup compiler warnings ( https://tinyurl.com/y2c95ytv )
    int oc_ch = 0, oc_ds = 0;
    int issl_ch, issl_ds, iswl_ch, iswl_ds, hvil_ch, hvil_ds = 0;
    int c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,chg,bms;
    int pack = 0;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    Info* p_info = p_racev->m_pInfo;
    QObject* pCurrentWindow = nullptr;
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	m_Frame = *pframe; // assign to member ASAP
	payload = m_Frame.payload();

	ch_shv = (payload[0]&0x01);
	ds_shv = ((payload[0]&0x02)>>1);
	ch_whv = ((payload[0]&0x04)>>2);
	ds_whv = ((payload[0]&0x08)>>3);
	ds_slv = ((payload[0]&0x10)>>4);
	ds_wlv = ((payload[0]&0x20)>>5);
	ds_hdv = ((payload[0]&0x40)>>6);
	ds_lsoc = ((payload[0]&0x80)>>7);

	// TODO: combine bit handling as one
	// B0[6:7] 500 - 501
	p_info->handleAlarmBits(5, 0, prev_payload, payload,
	    nullptr, // TODO: use nullptr
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    &p_info->is_warning_high_voltage_diff_in_driving_stop,
	    &p_info->is_warning_low_SOC_in_driving_stop);

	sht_ch = (payload[1]&0x01);
	sht_ds = ((payload[1]&0x02)>>1);
	wht_ch = ((payload[1]&0x04)>>2);
	wht_ds = ((payload[1]&0x08)>>3);
	slt_ch = ((payload[1]&0x10)>>4);
	slt_ds = ((payload[1]&0x20)>>5);
	wlt_ch = ((payload[1]&0x40)>>6);
	wlt_ds = ((payload[1]&0x80)>>7);

	oc_ch = (payload[2]&0x01);
	oc_ds = ((payload[2]&0x02)>>1);
	// B2[0:1] 502 - 503
	p_info->handleAlarmBits(5, 0, prev_payload, payload,
	    nullptr,
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    &p_info->is_warning_discharge_over_current,
	    &p_info->is_warning_charge_over_current);

	ccom_err = ((payload[3]&0x01));
	cer_err = ((payload[3]&0x02)>>1); // 3.1
	bms_ierr = ((payload[3]&0x04)>>2); // 3.2, 506
	vsam_err = ((payload[3]&0x08)>>3);
	tsam_err = ((payload[3]&0x10)>>4);
	chot = ((payload[3]&0x20)>>5); // 509
	ch_scerr = ((payload[3]&0x40)>>6);
	ch_wcerr = ((payload[3]&0x80)>>7); // 3.7, 511

	issl_ch = (payload[4]&0x01);
	issl_ds = ((payload[4]&0x02)>>1);
	iswl_ch = ((payload[4]&0x04)>>2);
	iswl_ds = ((payload[4]&0x08)>>3);
	hvil_ch = ((payload[4]&0x10)>>4);
	hvil_ds = ((payload[4]&0x20)>>5);

	c1 = (payload[5]&0x01);
	c2 = ((payload[5]&0x02)>>1);
	c3 = ((payload[5]&0x04)>>2);
	c4 = ((payload[5]&0x08)>>3);
	c5 = ((payload[5]&0x10)>>4);
	c6 = ((payload[5]&0x20)>>5);
	c7 = ((payload[5]&0x40)>>6);
	c8 = ((payload[5]&0x80)>>7);

	c9 = (payload[6]&0x01);
	c10 = ((payload[6]&0x02)>>1);
	c11 = ((payload[6]&0x04)>>2);
	c12 = ((payload[6]&0x08)>>3);
	c13 = ((payload[6]&0x10)>>4);
	c14 = ((payload[6]&0x20)>>5);
	chg = ((payload[6]&0x40)>>6);
	bms = ((payload[6]&0x80)>>7);

	bcu_alarm_lcounter = (payload[7]&0xFF);
	s_bcu_alarm_lcounter = QString("%1").arg(bcu_alarm_lcounter, 2, 16, QChar('0')).toUpper();

	// ALM_MSG_05 / BCU_ER_MSG01
	// assume there is only one pack info being carried.
	if ( (payload[5]&0xFF) || (payload[6]&0x0F) ) {
	    // if any flagBit set
	    bitset<NUM_PACKS>
		battery_pak(payload[5]+((payload[6]&0xFF)<<8));
#if 1
	    cout << __FILE__ << ":" << __LINE__ << " bitmap "
		<< battery_pak << endl;
#endif
	    for ( int i = 0; i<battery_pak.size(); i++ ) { // or NUM_PACKS
		if ( battery_pak.test(i) ) {
		    // assume only one pack info being carried
		    pack = i; break;
		}
	    }
#if 1
	    cout << __FILE__ << ":" << __LINE__ << " pk is "
		<< pack << endl;
#endif
	    p_info->handleAlarmPackBits( pack, prev_payload, payload );
	    // and so on ...
	    // assume for each frame, there is only one pack info
	    // being carried
	}

	pCurrentWindow = p_racev->getActiveWindow();
	if ( pCurrentWindow == p_racev->m_pWinBmsAnalog
	    || pCurrentWindow == p_racev->m_pWinBmsDigital
	    || pCurrentWindow == p_racev->m_pWinDiagnose ) {
#if defined ( EN_INVOKE_METHOD_ )
	    // byte 3 and B7
	    QMetaObject::invokeMethod(pCurrentWindow, "updateMsg_BCU_ER_MSG01", // refactored
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_bcu_alarm_lcounter),
		Q_ARG(QVariant, bms_ierr), // 504
		Q_ARG(QVariant, vsam_err),
		Q_ARG(QVariant, tsam_err),
		Q_ARG(QVariant, ccom_err),
		Q_ARG(QVariant, cer_err),
		Q_ARG(QVariant, chot),	    // 509
		Q_ARG(QVariant, ch_scerr),
		Q_ARG(QVariant, ch_wcerr));
#elif defined ( EN_PUSHING_REF2QML_ )
	    emit signalBmsErMSG01B3ANDB7(
		s_bcu_alarm_lcounter,
		bms_ierr,
		vsam_err,
		tsam_err,
		ccom_err,
		cer_err,
		chot,
		ch_scerr,
		ch_wcerr);
#endif
	}

	if ( pCurrentWindow == p_racev->m_pWinBmsAnalog ) {
#if defined ( EN_INVOKE_METHOD_ )
	    QMetaObject::invokeMethod(pCurrentWindow, // refactored
		"updateMsg_BCU_ER_MSG01_Byte0",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, ch_shv),
		Q_ARG(QVariant, ds_shv),
		Q_ARG(QVariant, ch_whv),
		Q_ARG(QVariant, ds_whv),
		Q_ARG(QVariant, ds_slv),
		Q_ARG(QVariant, ds_wlv),
		Q_ARG(QVariant, ds_hdv),
		Q_ARG(QVariant, ds_lsoc));

	    QMetaObject::invokeMethod(pCurrentWindow,  // refactored
		"updateMsg_BCU_ER_MSG01_Byte1",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, sht_ch),
		Q_ARG(QVariant, sht_ds),
		Q_ARG(QVariant, wht_ch),
		Q_ARG(QVariant, wht_ds),
		Q_ARG(QVariant, slt_ch),
		Q_ARG(QVariant, slt_ds),
		Q_ARG(QVariant, wlt_ch),
		Q_ARG(QVariant, wlt_ds));

	    QMetaObject::invokeMethod(pCurrentWindow,  // refactored
		"updateMsg_BCU_ER_MSG01_Byte2",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, oc_ch),
		Q_ARG(QVariant, oc_ds));

	    QMetaObject::invokeMethod(pCurrentWindow,// refactored
		"updateMsg_BCU_ER_MSG01_Byte4",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, issl_ch),
		Q_ARG(QVariant, issl_ds),
		Q_ARG(QVariant, iswl_ch),
		Q_ARG(QVariant, iswl_ds),
		Q_ARG(QVariant, hvil_ch),
		Q_ARG(QVariant, hvil_ds));

	    QMetaObject::invokeMethod(pCurrentWindow,// refactored
		"updateMsg_BCU_ER_MSG01_Byte5",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, c1),
		Q_ARG(QVariant, c2),
		Q_ARG(QVariant, c3),
		Q_ARG(QVariant, c4),
		Q_ARG(QVariant, c5),
		Q_ARG(QVariant, c6),
		Q_ARG(QVariant, c7),
		Q_ARG(QVariant, c8));

	    QMetaObject::invokeMethod(pCurrentWindow,// refactored
		"updateMsg_BCU_ER_MSG01_Byte6",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, c9),
		Q_ARG(QVariant, c10),
		Q_ARG(QVariant, c11),
		Q_ARG(QVariant, c12),
		Q_ARG(QVariant, c13),
		Q_ARG(QVariant, c14),
		Q_ARG(QVariant, chg),
		Q_ARG(QVariant, bms));
#elif defined ( EN_PUSHING_REF2QML_ )
	    emit signalBmsErMSG01B0(
		ch_shv,
		ds_shv,
		ch_whv,
		ds_whv,
		ds_slv,
		ds_wlv,
		ds_hdv,
		ds_lsoc);

	    emit signalBmsErMSG01B1(
		sht_ch,
		sht_ds,
		wht_ch,
		wht_ds,
		slt_ch,
		slt_ds,
		wlt_ch,
		wlt_ds);

	    emit signalBmsErMSG01B2(
		oc_ch,
		oc_ds);

	    emit signalBmsErMSG01B4(
		issl_ch,
		issl_ds,
		iswl_ch,
		iswl_ds,
		hvil_ch,
		hvil_ds);

	    emit signalBmsErMSG01B5(
		c1,
		c2,
		c3,
		c4,
		c5,
		c6,
		c7,
		c8);

	    emit signalBmsErMSG01B6(
		c9,
		c10,
		c11,
		c12,
		c13,
		c14,
		chg,
		bms);
#endif
	}
	m_prevFrame = m_Frame; // keep for next compare
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

