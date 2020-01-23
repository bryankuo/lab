#include <iostream>
#include <stdexcept>
#include <iomanip>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>
#include <QQmlProperty>

#include "../../constants.h"
#include "ALM_MSG00.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG00::ALM_MSG00
///
/// HMI context
///
Handler_ALM_MSG00::Handler_ALM_MSG00(QObject* p_racev = 0)
    :m_pRacev(p_racev) //,
    //m_prevAlarm({0})
{
    //qDebug() << "Handler_ALM_MSG00() +";
}

Handler_ALM_MSG00::~Handler_ALM_MSG00() {
    //qDebug() << "Handler_ALM_MSG00() ~";
}

void Handler_ALM_MSG00::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    // QVariant returnedValue;
    QByteArray prev_payload, payload;
    int is_charging_in_progress;
    QObject* pCurrentWindow = nullptr;

    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    Info* p_info = p_racev->m_pInfo;
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
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	m_Frame = *pframe; // assign to member ASAP
	payload = m_Frame.payload();
	prev_payload = m_prevFrame.payload();

#if 0
	cout << __FILE__ << ":" << __LINE__ << " " << __func__
	    << " payload "
	    << "[" << payload.toHex(' ').toStdString() << "]"
	    << " prev "
	    << "[" << prev_payload.toHex(' ').toStdString() << "]"
	    << endl;
#endif

	// B0[0:7]
	// every element in QByteArray can be directly cast to a uint8_t.
	// ( ref. https://is.gd/zX9OUR )
	// set clear toggle bit ( https://stackoverflow.com/a/47990 )
	// set state (literal) according to alarm bit
	p_info->emergency_stop = (payload[0]&0xFF)&(1U<<0);
	// set alarm bitmap value
	if ( ((payload[0]&0xFF)&(1U<<0)) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U << 0);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U << 0);
	// set if state is changed
	if ( ((prev_payload[0]&0x01)^(payload[0]&0x01)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U << 0);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U << 0);

	p_info->tmotor_overheat = (payload[0]&0x02)>>1;
	if ( ((payload[0]&0xFF)&(1U<<1)) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<1);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<1);
	if ( ((prev_payload[0]&0x02)^(payload[0]&0x02)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U << 1);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U << 1);

	p_info->tmotor_drv_abnormal = (payload[0]&0x04)>>2;
	if ( (payload[0]&0x04) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<2);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<2);
	if ( ((prev_payload[0]&0x04)^(payload[0]&0x04)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<2);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<2);

	p_info->tmotor_temp_xhigh_pullover = (payload[0]&0x08)>>3;
	if ( (payload[0]&0x08) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<3);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<3);
	if ( ((prev_payload[0]&0x08)^(payload[0]&0x08)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<3);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<3);

	p_info->inadequate_air_pressure = (payload[0]&0x10)>>4;
	if ( (payload[0]&0x10) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<4);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<4);
	if ( ((prev_payload[0]&0x10)^(payload[0]&0x10)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<4);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<4);

	p_info->air_compressor_overheat = (payload[0]&0x20)>>5;
	if ( (payload[0]&0x20) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<5);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<5);
	if ( ((prev_payload[0]&0x20)^(payload[0]&0x20)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<5);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<5);

	p_info->air_compressor_mtr_overheat = (payload[0]&0x40)>>6;
	if ( (payload[0]&0x40) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<6);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<6);
	if ( ((prev_payload[0]&0x40)^(payload[0]&0x40)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<6);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<6);

	p_info->air_compressor_mtdrv_abnormal = (payload[0]&0x80)>>7;
	if ( (payload[0]&0x80) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] |= (1U<<7);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+0] &= ~(1U<<7);
	if ( ((prev_payload[0]&0x80)^(payload[0]&0x80)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] |= (1U<<7);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+0] &= ~(1U<<7);

	// B1[0:7]
	p_info->stmotor_overheat = (payload[1]&1U)>>0;
	if ( ((payload[1]&0xFF)&(1U<<0)) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<0);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<0);
	if ( (prev_payload[1]&0x01)^(payload[1]&0x01) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<0);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<0);

	p_info->stmotor_drv_abnormal = (payload[1]&0x02)>>1;
	if ( (payload[1]&0x02) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U << 1);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U << 1);
	if ( (prev_payload[1]&0x02)^(payload[1]&0x02) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<1);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<1);

	p_info->pk_a_impact_flood_protect_on = (payload[1]&0x04)>>2;
	if ( (payload[1]&0x04) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<2);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<2);
	if ( ((prev_payload[1]&0x04)^(payload[1]&0x04)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<2);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<2);

	p_info->pk_bcd_impact_flood_protect_on = (payload[1]&0x08)>>3;
	if ( (payload[1]&0x08) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<3);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<3);
	if ( ((prev_payload[1]&0x08)^(payload[1]&0x08)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<3);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<3);

	p_info->pk_efg_impact_flood_protect_on = (payload[1]&0x10)>>4;
	if ( (payload[1]&0x10) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<4);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<4);
	if ( ((prev_payload[1]&0x10)^(payload[1]&0x10)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<4);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<4);

	p_info->pk_hi_impact_flood_protect_on = (payload[1]&0x20)>>5;
	if ( (payload[1]&0x20) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<5);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<5);
	if ( ((prev_payload[1]&0x20)^(payload[1]&0x20)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<5);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<5);

	p_info->pk_jk_impact_flood_protect_on = (payload[1]&0x40)>>6;
	if ( (payload[1]&0x40) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<6);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<6);
	if ( ((prev_payload[1]&0x40)^(payload[1]&0x40)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<6);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<6);

	p_info->pk_l_impact_flood_protect_on = (payload[1]&0x80)>>7;
	if ( (payload[1]&0x80) )
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] |= (1U<<7);
	else
	    p_info->m_Alarm[0*NUM_BYTE_ALARM+1] &= ~(1U<<7);
	if ( ((prev_payload[1]&0x80)^(payload[1]&0x80)) )
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] |= (1U<<7);
	else
	    p_info->m_AlarmTrigger[0*NUM_BYTE_ALARM+1] &= ~(1U<<7);

	p_info->handleAlarmBits(0, 2, prev_payload, payload,
	    &p_info->fl_lining_abnormal,
	    &p_info->fr_lining_abnormal,
	    &p_info->rl_lining_abnormal,
	    &p_info->rr_lining_abnormal,
	    &p_info->abs_abnormal,
	    &p_info->fdoor_opened,
	    &p_info->rdoor_opened,
	    &p_info->fdoor_open_forced);

	p_info->handleAlarmBits(0, 3, prev_payload, payload,
	    &p_info->fl_lining_abnormal,
	    &p_info->fr_lining_abnormal,
	    &p_info->rl_lining_abnormal,
	    &p_info->rr_lining_abnormal,
	    &p_info->abs_abnormal,
	    &p_info->fdoor_opened,
	    &p_info->rdoor_opened,
	    &p_info->fdoor_open_forced);

	// TODO: merge B3 bits

	p_info->handleAlarmBits(0, 4, prev_payload, payload,
	    &p_info->is_charging_in_progress,
	    &p_info->is_parking_brake_not_released,
	    &p_info->is_pneumatic_lock_released,
	    &p_info->is_doorlock_released,
	    &p_info->is_emergency_doorlock_released,
	    &p_info->is_anti_collision_lock_released,
	    &p_info->is_ECAS_lock_released,
	    &p_info->is_ramps_lock_released);
#if 0
	// if ( 1 == is_charging_in_progress )
	  //  cout << __FILE__ << ":" << __LINE__
	//	<< ": alarm charge in progress." << endl;
	// else
	  //  cout << __FILE__ << ":" << __LINE__
	//	<< ": alarm charge not in progress." << endl;
#endif
	// B5[0:7]
	p_info->handleAlarmBits(0, 5, prev_payload, payload,
	    &p_info->is_charger_not_detached,
	    &p_info->is_24v_control_voltage_too_low,
	    &p_info->is_24v_control_voltage_shortage_warning,
	    &p_info->is_voltage_too_low_pull_over_ASAP,
	    &p_info->is_low_voltage_warning_charing_ASAP,
	    &p_info->is_speeding_warning,
	    &p_info->is_overnight_stop_lock_abnormal,
	    &p_info->is_insulation_resistance_abnormal);

	// B6[0:7] 49 - 56
	p_info->handleAlarmBits(0, 6, prev_payload, payload,
	    &p_info->is_clutch_pedal_abnormal,
	    &p_info->is_not_shift2_neutral,
	    &p_info->is_handbrake_not_engaged,
	    &p_info->is_starting_up,
	    &p_info->is_brake_pedal_abnormal,
	    &p_info->is_accelerator_pedal_abnormal,
	    &p_info->is_cooling_water_pump_abnormal,
	    &p_info->is_radiator_fan_abnormal);

	// B7[0:7] 57 - 64
	p_info->handleAlarmBits(0, 7, prev_payload, payload,
	    &p_info->is_cooling_water_olet_temp_sensor_abnormal,
	    &p_info->is_cooling_water_ilet_temp_sensor_abnormal,
	    &p_info->is_BMS_comm_abnormal,
	    &p_info->is_PCU_comm_abnormal,
	    &p_info->is_BCU_comm_abnormal,
	    NULL, NULL, NULL);

	pCurrentWindow = p_racev->getActiveWindow();
	if (  pCurrentWindow == p_racev->m_pWinMain
	    || pCurrentWindow == p_racev->m_pWinCharging ) {
#if defined ( EN_INVOKE_METHOD_ )
	    QMetaObject::invokeMethod(pCurrentWindow,
		"updateALM_MSG00", // refactored
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, is_charging_in_progress));
#elif defined ( EN_PUSHING_REF2QML_ )
	    emit signalAlmMSG00(is_charging_in_progress);
#endif
	}
	p_racev->m_pInfo->is_charging_in_progress = is_charging_in_progress;
	m_prevFrame = m_Frame; // keep for next compare
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception: " << ex.what() << endl;
    }
ERROR_HANDLER:
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
#endif
    return;
}

