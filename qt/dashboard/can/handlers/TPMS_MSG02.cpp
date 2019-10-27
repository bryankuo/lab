#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "TPMS_MSG02.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_TPMS_MSG02::TPMS_MSG02
///
/// HMI context
///
Handler_TPMS_MSG02::Handler_TPMS_MSG02(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_TPMS_MSG02() +";
}

Handler_TPMS_MSG02::~Handler_TPMS_MSG02() {
    //qDebug() << "Handler_TPMS_MSG02() ~";
}

void Handler_TPMS_MSG02::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    unsigned int bcu_alarm_lcounter = 0, bms_ierr = 0, vsam_err = 0,
	tsam_err = 0, ccom_err = 0, cer_err = 0, chot = 0, ch_scerr = 0, ch_wcerr = 0;
    QString s_bcu_alarm_lcounter;
    unsigned int ch_shv = 0, ds_shv = 0, ch_whv = 0,
	ds_whv = 0, ds_slv = 0, ds_wlv = 0, ds_hdv = 0, ds_lsoc = 0;
    unsigned int sht_ch, sht_ds, wht_ch, wht_ds, slt_ch, slt_ds, wlt_ch, wlt_ds;
    // shutup compiler warnings ( https://tinyurl.com/y2c95ytv )
    unsigned int oc_ch = 0, oc_ds = 0;
    unsigned int issl_ch, issl_ds, iswl_ch, iswl_ds, hvil_ch, hvil_ds = 0;
    unsigned int c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,chg,bms;

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
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << mx_allowed_chg_current << " " << s_mx_allowed_chg_current;
#endif
	ch_shv = (payload[0]&0x01);
	ds_shv = ((payload[0]&0x02)>>1);
	ch_whv = ((payload[0]&0x04)>>2);
	ds_whv = ((payload[0]&0x08)>>3);
	ds_slv = ((payload[0]&0x10)>>4);
	ds_wlv = ((payload[0]&0x20)>>5);
	ds_hdv = ((payload[0]&0x40)>>6);
	ds_lsoc = ((payload[0]&0x80)>>7);

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

	chot = ((payload[3]&0x20)>>5);
	ch_scerr = ((payload[3]&0x40)>>6);
	ch_wcerr = ((payload[3]&0x80)>>7);

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

	// byte 3
	QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG02",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_bcu_alarm_lcounter),
	    Q_ARG(QVariant, bms_ierr),
	    Q_ARG(QVariant, vsam_err),
	    Q_ARG(QVariant, tsam_err),
	    Q_ARG(QVariant, ccom_err),
	    Q_ARG(QVariant, cer_err),
	    Q_ARG(QVariant, chot),
	    Q_ARG(QVariant, ch_scerr),
	    Q_ARG(QVariant, ch_wcerr));

	if ( pDstVw == p_racev->m_pWinBmsAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG02_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, ch_shv),
		Q_ARG(QVariant, ds_shv),
		Q_ARG(QVariant, ch_whv),
		Q_ARG(QVariant, ds_whv),
		Q_ARG(QVariant, ds_slv),
		Q_ARG(QVariant, ds_wlv),
		Q_ARG(QVariant, ds_hdv),
		Q_ARG(QVariant, ds_lsoc));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG02_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, ch_shv),
		Q_ARG(QVariant, ds_shv),
		Q_ARG(QVariant, ch_whv),
		Q_ARG(QVariant, ds_whv),
		Q_ARG(QVariant, ds_slv),
		Q_ARG(QVariant, ds_wlv),
		Q_ARG(QVariant, ds_hdv),
		Q_ARG(QVariant, ds_lsoc));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG02_Byte2",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, oc_ch),
		Q_ARG(QVariant, oc_ds));

	    QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG02_Byte4",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, issl_ch),
		Q_ARG(QVariant, issl_ds),
		Q_ARG(QVariant, iswl_ch),
		Q_ARG(QVariant, iswl_ds),
		Q_ARG(QVariant, hvil_ch),
		Q_ARG(QVariant, hvil_ds));

	}
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

