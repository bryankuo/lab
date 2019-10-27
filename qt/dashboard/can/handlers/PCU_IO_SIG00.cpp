#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_IO_SIG00.h"
#include "../../racev.h"

///
/// \brief Handler_PCU_IO_SIG00::PCU_IO_SIG00
///
/// HMI context
///
Handler_PCU_IO_SIG00::Handler_PCU_IO_SIG00(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_IO_SIG00() +";
}

Handler_PCU_IO_SIG00::~Handler_PCU_IO_SIG00() {
    //qDebug() << "Handler_PCU_IO_SIG00() ~";
}

void Handler_PCU_IO_SIG00::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    int pbrake = 0, clutch = 0,
	rgbrake = 0, emgstop = 0, wpump = 0, coolingf = 0;
    int outlet_t = 0, inlet_t = 0;
    unsigned int advr_reset = 0, adrv_alarm = 0, pcu_lc = 0;
    unsigned int hy_run = 0, hy_reset = 0, hy_alarm = 0;

    QString s_pressure ="0";
    float pressure = 0.0f;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

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
	i = 0; p_racev->m_pInfo->pedal = (payload[i]&0x01); p_racev->m_pInfo->brake = ((payload[i]&0x02)>>1);
	pbrake = ((payload[i]&0x04)>>2); clutch = ((payload[i]&0x08)>>3);
	rgbrake = ((payload[i]&0x10)>>4); emgstop = ((payload[i]&0x20)>>5);
	wpump = ((payload[i]&0x40)>>6); coolingf = ((payload[i]&0x80)>>7);

	i = 1;
	hy_run = (payload[i]&0x01);
	hy_reset = ((payload[i]&0x02)>>1);
	hy_alarm = ((payload[i]&0x04)>>2);
	advr_reset = ((payload[i]&0x08)>>3);
	adrv_alarm = ((payload[i]&0x10)>>4);
#if 0
	cout << __func__ << ":" << __LINE__ << " "
	    << std::hex << "0x" << ctrl_mode << " 0x" << mtr_cmd << std::dec
	    << endl;
#endif
	i = 3; outlet_t = (payload[i]&0xFF) + OFFSET_WTEMP;
	if ( ULIMIT_WTEMP < outlet_t ) {
	    outlet_t = ULIMIT_WTEMP;
	}
	if ( outlet_t < LLIMIT_WTEMP ) {
	    outlet_t = LLIMIT_WTEMP;
	}
	i = 4; inlet_t = (payload[i]&0xFF) + OFFSET_WTEMP;
	if ( ULIMIT_WTEMP < inlet_t ) {
	    inlet_t = ULIMIT_WTEMP;
	}
	if ( inlet_t < LLIMIT_WTEMP ) {
	    inlet_t = LLIMIT_WTEMP;
	}
	i = 5; p_racev->m_pInfo->pedal_depth = (payload[i]&0xFF)+((payload[i+1]&0xFF)<<8);
	if ( ULIMIT_PDEPTH < p_racev->m_pInfo->pedal_depth ) {
	    p_racev->m_pInfo->pedal_depth = ULIMIT_PDEPTH;
	}
	if ( p_racev->m_pInfo->pedal_depth < LLIMIT_PDEPTH ) {
	    p_racev->m_pInfo->pedal_depth = LLIMIT_PDEPTH;
	}

	i = 7; pcu_lc = (payload[i]&0xFF);
	pressure = static_cast<float>((payload[2]&0xFF));
	pressure *= static_cast<float>(FACTOR_APRESSURE);
	if ( ULIMIT_APRESSURE < pressure ) {
	    pressure = ULIMIT_APRESSURE;
	}
	if ( pressure < LLIMIT_APRESSURE ) {
	    pressure = LLIMIT_APRESSURE;
	}
	s_pressure = QString::number(
	    static_cast<double>(pressure), 'f', 1);

	if ( pDstVw == p_racev->m_pWinTraction
	    || pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinPcuAnalog
	    || pDstVw == p_racev->m_pWinSteering ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal),
		Q_ARG(QVariant, p_racev->m_pInfo->brake),
		Q_ARG(QVariant, pbrake),
		Q_ARG(QVariant, clutch),
		Q_ARG(QVariant, rgbrake),
		Q_ARG(QVariant, emgstop),
		Q_ARG(QVariant, wpump),
		Q_ARG(QVariant, coolingf));
	}

	if ( pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinSteering
	    || pDstVw == p_racev->m_pWinPcuAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, hy_run),
		Q_ARG(QVariant, hy_reset),
		Q_ARG(QVariant, hy_alarm),
		Q_ARG(QVariant, advr_reset),
		Q_ARG(QVariant, adrv_alarm));
	}

	if ( pDstVw == p_racev->m_pWinTraction
	    || pDstVw == p_racev->m_pWinBrake
	    || pDstVw == p_racev->m_pWinPcuAnalog
	    || pDstVw == p_racev->m_pWinPcuDigital
	    || pDstVw == p_racev->m_pWinDiagnose ) {
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte2To7",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_pressure),
		Q_ARG(QVariant, inlet_t),
		Q_ARG(QVariant, outlet_t),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal_depth),
		Q_ARG(QVariant, pcu_lc));
	}

	/*if ( pDstVw == p_racev->m_pWinTraction ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal),
		Q_ARG(QVariant, p_racev->m_pInfo->brake),
		Q_ARG(QVariant, pbrake),
		Q_ARG(QVariant, clutch),
		Q_ARG(QVariant, rgbrake),
		Q_ARG(QVariant, emgstop),
		Q_ARG(QVariant, wpump),
		Q_ARG(QVariant, coolingf));
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte2To7",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_pressure),
		Q_ARG(QVariant, inlet_t),
		Q_ARG(QVariant, outlet_t),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal_depth));
	}
	else if ( pDstVw == p_racev->m_pWinBrake ||
		pDstVw == p_racev->m_pWinPcuAnalog ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal),
		Q_ARG(QVariant, p_racev->m_pInfo->brake),
		Q_ARG(QVariant, pbrake),
		Q_ARG(QVariant, clutch),
		Q_ARG(QVariant, rgbrake),
		Q_ARG(QVariant, emgstop),
		Q_ARG(QVariant, wpump),
		Q_ARG(QVariant, coolingf));
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, hy_run),
		Q_ARG(QVariant, hy_reset),
		Q_ARG(QVariant, hy_alarm),
		Q_ARG(QVariant, advr_reset),
		Q_ARG(QVariant, adrv_alarm));
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte2To7",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_pressure),
		Q_ARG(QVariant, inlet_t),
		Q_ARG(QVariant, outlet_t),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal_depth));
	}
	else if ( pDstVw == p_racev->m_pWinSteering ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte0",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal),
		Q_ARG(QVariant, p_racev->m_pInfo->brake),
		Q_ARG(QVariant, pbrake),
		Q_ARG(QVariant, clutch),
		Q_ARG(QVariant, rgbrake),
		Q_ARG(QVariant, emgstop),
		Q_ARG(QVariant, wpump),
		Q_ARG(QVariant, coolingf));
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte1",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, hy_run),
		Q_ARG(QVariant, hy_reset),
		Q_ARG(QVariant, hy_alarm),
		Q_ARG(QVariant, advr_reset),
		Q_ARG(QVariant, adrv_alarm));
	}
	else if ( pDstVw == p_racev->m_pWinDiagnose ) {
	    QMetaObject::invokeMethod(pDstVw, "updateMsg_PCUIO_SIG00_Byte2To7",
		Qt::BlockingQueuedConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_pressure),
		Q_ARG(QVariant, inlet_t),
		Q_ARG(QVariant, outlet_t),
		Q_ARG(QVariant, p_racev->m_pInfo->pedal_depth));
	}
	else {
	} */

    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

