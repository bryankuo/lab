#include <iostream>
#include <unistd.h>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QDateTime>

#include "../../constants.h"
#include "VCU_PWR_STATUS.h"
#include "../../racev.h"
#include "../../can/canthread.h"

///
/// \brief Handler_VCU_PWR_STATUS::VCU_PWR_STATUS
///
/// HMI context
///
Handler_VCU_PWR_STATUS::Handler_VCU_PWR_STATUS(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_VCU_PWR_STATUS() +";
}

Handler_VCU_PWR_STATUS::~Handler_VCU_PWR_STATUS() {
    //qDebug() << "Handler_VCU_PWR_STATUS() ~";
}

/*
 * return 0 for nothing, 1 for wakeup (show login), 2 for sleep (log out)
 */
int Handler_VCU_PWR_STATUS::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    uint8_t charge_control;
    int rc; uint8_t hmi_wakeup;
    uint8_t key_position = 0;
    QString s_VCU_PWR_STATUS;
    // QString s_yr, s_mo, s_dt, s_hr, s_min, s_sec;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    // CanThread *pCanThread = reinterpret_cast<CanThread *>(p_racev->pCANBusReceiverThread);
    try {
	if ( nullptr == pframe ) {
	    cout << __FILE__ << ":" << __LINE__ << "!" << endl;
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	s_VCU_PWR_STATUS = pframe->payload().toHex(' ');
	if ( pDstVw == p_racev->m_pWinMain ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_VCU_PWR_STATUS",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_VCU_PWR_STATUS));
	}

	key_position = (payload[0]&0x03);
	if ( key_position != p_racev->m_pInfo->key_position ) {
	    switch ( key_position ) {
		case KEY_OFF:
		    cout << __FILE__ << ":" << __LINE__ << ": key off." << endl;
		break;
		case KEY_ACC:
		    cout << __FILE__ << ":" << __LINE__ << ": key acc." << endl;
		break;
		case KEY_ON:
		    cout << __FILE__ << ":" << __LINE__ << ": key on." << endl;
		break;
		default:
		break;
	    }
	}

	charge_control = (payload[0]&0x04)>>2;
	if ( charge_control != p_racev->m_pInfo->charge_control ) {
	    switch ( charge_control ) {
		case 0:
		    cout << __FILE__ << ":"  << __LINE__ << ": charging is allowed." << endl; break;
		case 1:
		    cout << __FILE__ << ":"  << __LINE__ << ": charging is prohibited." << endl; break;
		default: break;
	    }
	}

	hmi_wakeup = (payload[6]&0xFF);
	// 'level triggered' implementation
#if 1
	if ( hmi_wakeup == WKEUP_TOKEN ) {
	    rc = 1;
	}
	else if ( hmi_wakeup == SLEEP_TOKEN ) {
	    rc = 2;
	}
	else { }; // don't care
#endif
	p_racev->m_HmiWakeUp = hmi_wakeup;

	// 'edge  triggered' implementation
#if 0
	if ( ( p_racev->m_HmiWakeUp == 0x55 && hmi_wakeup == 0xAA) // either sleep -> wakeup
	    || ( p_racev->m_pInfo->key_position == KEY_OFF	   // or     OFF     -> ACC
		&& key_position == KEY_ACC  )
	    || ( p_racev->m_pInfo->key_position == 0          // or     initial -> ACC (charging)
		&& key_position == KEY_ACC  ) ) {
	    rc = 1;
	}
	else if ( p_racev->m_HmiWakeUp == 0xAA && hmi_wakeup == 0x55 ) { // wakeup -> sleep
	    rc = 2;
	}
	else {
	    rc = 0;
	}
#endif

// #define RESPOND_VCU_PINOK
#if defined ( RESPOND_VCU_PINOK )
	if ( ( p_racev->m_pInfo->key_position == KEY_OFF
		&& key_position == KEY_ACC /* OFF -> ACC */ )
	    || ( p_racev->m_pInfo->key_position == KEY_ACC
		&& key_position == KEY_ON /* ACC -> ON */ ) ) {
	    frame_tx.setFrameId(HMI_TM_MSG01);
	    frame_tx.setFrameType(QCanBusFrame::DataFrame);
	    for ( i = 0; i < 3; i++ ) {
		QDateTime local(QDateTime::currentDateTime());
		s_yr = QString("%1").arg(local.toString("yyyy").toInt(), 4, 16, QChar('0'));
		s_mo = QString("%1").arg(local.toString("MM").toInt(), 2, 16, QChar('0'));
		s_dt = QString("%1").arg(local.toString("dd").toInt(), 2, 16, QChar('0'));
		s_hr = QString("%1").arg(local.toString("hh").toInt(), 2, 16, QChar('0'));
		s_min = QString("%1").arg(local.toString("mm").toInt(), 2, 16, QChar('0'));
		s_sec = QString("%1").arg(local.toString("ss").toInt(), 2, 16, QChar('0'));
		// send 80 "intentionally", 3 times, interval 500 ms,
		QString str = s_sec + s_min + s_hr
		    + s_dt + s_mo + s_yr.mid(2,2) + s_yr.mid(0,2) + "80";
		QByteArray array2 = QByteArray::fromHex(str.toLatin1());
		frame_tx.setPayload(array2);
		pCanThread->Transmit(frame_tx);
		usleep(500*1000); // 500 milliseconds
	    }
	}
#endif
	p_racev->m_pInfo->key_position = key_position;
	p_racev->m_pInfo->charge_control = charge_control;
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    // cout << typeid(*this).name() << "::" << __func__ <<":"<< __LINE__ << " - "<< endl;
    return rc;
}

