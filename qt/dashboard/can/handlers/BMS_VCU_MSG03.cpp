#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BMS_VCU_MSG03.h"
#include "../../racev.h"

///
/// \brief Handler_BMS_VCU_MSG03::BMS_VCU_MSG03
///
/// HMI context
///
Handler_BMS_VCU_MSG03::Handler_BMS_VCU_MSG03(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_VCU_MSG03() +";
}

Handler_BMS_VCU_MSG03::~Handler_BMS_VCU_MSG03() {
    //qDebug() << "Handler_BMS_VCU_MSG03() ~";
}

void Handler_BMS_VCU_MSG03::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    unsigned int mi_ctr_state = 0; unsigned int frelay_state = 0;
    unsigned int l_counter = 0; // unsigned int charger_cc2 = 0;
    QString s_bms_lcounter;
    uint8_t bms_startup_status; uint8_t bms_state; uint8_t bms_cc2;
    uint8_t charger_conn1; uint8_t charger_conn2; uint8_t bms_pr_state;
    uint8_t mctr_state;
    uint8_t charger_enable; uint8_t charging_state;
    uint32_t minus_contactor;
    unsigned int b0, b1, b2, b3, b4, b5, b6, b7; int i;
#define NUM_BYTE 4
    QObject* pCurrentWindow = nullptr;

    const char* fn_call[NUM_BYTE] = {
	"updateBMS_VCU_MSG03_Byte3",
	"updateBMS_VCU_MSG03_Byte4",
	"updateBMS_VCU_MSG03_Byte5",
	"updateBMS_VCU_MSG03_Byte6"
    };
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout<< __func__ <<":"<< __LINE__ << " + "<<endl;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->max_pt_temp = (payload[0]&0xFF) + OFFSET_TEMP;
#define OFFSET_INDEX 1
	p_racev->m_pInfo->max_pt_idx = (payload[1]&0xFF) + OFFSET_INDEX;

	bms_cc2 = (payload[2]&0x01);
	switch ( bms_cc2 != p_racev->m_pInfo->bms_cc2 ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " cable state disconnect " << endl; break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " cable state connect " << endl; break;
	    default: break;
	}
	p_racev->m_pInfo->bms_cc2 = bms_cc2;


	bms_startup_status = (payload[2]&0x30)>>4;
	switch ( bms_startup_status != p_racev->m_pInfo->bms_startup_status ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " bms not prepared." << endl;
	    break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " bms is prepared." << endl;
	    break;
	    case 2:
		cout << __FILE__ << ":" << __LINE__ << " bms start." << endl;
	    break;
	    case 3:
		cout << __FILE__ << ":" << __LINE__ << " abnormal contactor." << endl;
	    break;
	    default: break;
	}
	p_racev->m_pInfo->bms_startup_status = bms_startup_status;

	charger_conn1 = ((payload[2]&0x02)>>1);
	switch ( charger_conn1 != p_racev->m_pInfo->charger_conn1 ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " bms charger disconnect " << endl; break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " bms charger connect " << endl; break;
	    default: break;
	}
	p_racev->m_pInfo->charger_conn1 = charger_conn1;

	charger_conn2 = ((payload[2]&0x0C)>>2);
	switch ( charger_conn2 != p_racev->m_pInfo->charger_conn2 ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " bms charger comm. yet" << endl; break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " bms charger hand/s yet" << endl; break;
	    case 2:
		cout << __FILE__ << ":" << __LINE__ << " bms charger hand/s done" << endl; break;
	    default: break;
	}
	p_racev->m_pInfo->charger_conn2 = charger_conn2;

	bms_pr_state = ((payload[2]&0x30)>>4);
	switch ( bms_pr_state != p_racev->m_pInfo->bms_pr_state ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " bms is preparing" << endl; break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " bms is prepared" << endl; break;
	    case 2:
		cout << __FILE__ << ":" << __LINE__ << " bms has started" << endl; break;
	    case 3:
		cout << __FILE__ << ":" << __LINE__ << " contactor abnormal" << endl; break;
	    default: break;
	}
	p_racev->m_pInfo->bms_pr_state = bms_pr_state;

	mctr_state = ((payload[2]&0x40)>>6);
	switch ( mctr_state != p_racev->m_pInfo->mctr_state ) {
	    case 0:
		cout << __FILE__ << ":" << __LINE__ << " m.contactor is open" << endl;
	    break;
	    case 1:
		cout << __FILE__ << ":" << __LINE__ << " m.contactor is close" << endl;
	    break;
	    default: break;
	}
	p_racev->m_pInfo->mctr_state = mctr_state;

	minus_contactor = (payload[3]&0xFF) + ((payload[4]&0xFF)<<8);
	if ( p_racev->m_pInfo->minus_contactor != 0x0FFF && minus_contactor == 0x0FFF ) {
	    cout << __FILE__ << ":" << __LINE__ << " minus contactor all closed." << endl;
	}
	if ( p_racev->m_pInfo->minus_contactor != 0x0000 && minus_contactor == 0x0000 ) {
	    cout << __FILE__ << ":" << __LINE__ << " minus contactor all opened." << endl;
	}
	p_racev->m_pInfo->minus_contactor = minus_contactor;

	frelay_state = (payload[5]&0xFF)+((payload[6]&0xFF)<<8); // TODO:
	l_counter = (payload[7]&0xFF);
	s_bms_lcounter = QString("%1").arg(l_counter, 2, 16, QChar('0')).toUpper();

	pCurrentWindow = p_racev->getActiveWindow();
	if ( pCurrentWindow == p_racev->m_pWinCharging
	    || pCurrentWindow == p_racev->m_pWinVcuDigital
	    || pCurrentWindow == p_racev->m_pWinVcuAnalog
	    || pCurrentWindow == p_racev->m_pWinDiagnose
	    || pCurrentWindow == p_racev->m_pWinBmsAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BMS_VCU_Msg03",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, p_racev->m_pInfo->max_pt_temp),
	    Q_ARG(QVariant, p_racev->m_pInfo->max_pt_idx),
	    Q_ARG(QVariant, p_racev->m_pInfo->bms_cc2),
	    Q_ARG(QVariant, p_racev->m_pInfo->charger_conn1),
	    Q_ARG(QVariant, p_racev->m_pInfo->charger_conn2),
	    Q_ARG(QVariant, p_racev->m_pInfo->bms_pr_state),
	    Q_ARG(QVariant, p_racev->m_pInfo->mctr_state),
	    Q_ARG(QVariant, mi_ctr_state),
	    Q_ARG(QVariant, frelay_state),
	    Q_ARG(QVariant, s_bms_lcounter));
	}

	if ( pDstVw ) { // TODO: and is active
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_BMS_VCU_Msg03",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, p_racev->m_pInfo->max_pt_temp),
	    Q_ARG(QVariant, p_racev->m_pInfo->max_pt_idx),
	    Q_ARG(QVariant, p_racev->m_pInfo->bms_cc2),
	    Q_ARG(QVariant, p_racev->m_pInfo->charger_conn1),
	    Q_ARG(QVariant, p_racev->m_pInfo->charger_conn2),
	    Q_ARG(QVariant, p_racev->m_pInfo->bms_pr_state),
	    Q_ARG(QVariant, p_racev->m_pInfo->mctr_state),
	    Q_ARG(QVariant, mi_ctr_state),
	    Q_ARG(QVariant, frelay_state),
	    Q_ARG(QVariant, s_bms_lcounter));
	}

	if ( p_racev->m_pWinBmsAnalog == pDstVw ) {
	    for ( i = 3; i < 7; i++ ) { // B3:7 ref. spec
		b0 = (payload[i]&0x01);
		b1 = ((payload[i]&0x02)>>1);
		b2 = ((payload[i]&0x04)>>2);
		b3 = ((payload[i]&0x08)>>3);
		b4 = ((payload[i]&0x10)>>4);
		b5 = ((payload[i]&0x20)>>5);
		b6 = ((payload[i]&0x40)>>6);
		b7 = ((payload[i]&0x80)>>7);
		QMetaObject::invokeMethod(pDstVw, fn_call[i-3],
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
		    << " " << fn_call[i]
		    << " " << b0
		    << " " << b1
		    << " " << b2
		    << " " << b3
		    << "|" << b4
		    << " " << b5
		    << " " << b6
		    << " " << b7
		    << endl;
#endif
	    }
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}
