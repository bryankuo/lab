#include <ctime>
#include <iostream>
#include <iomanip>

#include <QDir>
#include <QtMath>
#include <QtGlobal>
#include <QHash>
#include <QCanBusFrame>

#include "info.h"
#include "constants.h"

//
//static const quint32 ADDR_VCU_HMI_MSG1 = VCU_HMI_Msg_1;
// 靜態空間變數/全域變數，是接近 evil 的東西 ( http://tinyurl.com/y2xabqck )
//

Info::Info():
    // TODO: obselete, where bins is not used any more
    m_addrVCU_HMI_MSG1(VCU_HMI_Msg_1),
    m_addrVCU_HMI_MSG2(VCU_HMI_Msg_2),
    m_addrVCU_HMI_MSG3(VCU_HMI_Msg_3),
    m_addrVCU_HMI_MSG4(VCU_HMI_Msg_4),
    m_addrBMS_VCU_MSG1(BMS_VCU_Msg01),
    m_addrBMS_VCU_MSG2(BMS_VCU_Msg02),
    m_addrBMS_VCU_MSG03(BMS_VCU_Msg03),
    m_addrBMS_VCU_MSG04(BMS_VCU_Msg04),
    m_addrBMS_OBC_MSG01(BMS_OBC_MSG01),
    m_addrBMS_VOLT_MSG01(BMS_Volt_Msg01),
    m_addrBMS_TEMP_MSG01(BMS_Temp_Msg01),
    m_addrJ1939_BAM_HEAD(J1939_BAM_HEAD),
    m_addrJ1939_BAM_BODY(J1939_BAM_BODY),
    m_addrPCU_IO_SIG00(PCU_IO_SIG00),
    m_addrBCU_VCU_MSG0(BCU_VCU_MSG0),
    m_addrBCU_ER_MSG01(BCU_ER_MSG01),
    m_addrBMS_CMUERR_MSG01(BMS_CMUERR_MSG01),
    m_addrTPMS_MSG01(TPMS_MSG01),
    m_addrTPMS_MSG02(TPMS_MSG02),
    // TODO: obselete

    m_speed(0),m_speedMA{0,0,0},m_speedMAIndex(0),
    rpm_unit("rpm"), // gear("5"),
    rpm(0), turnIndicator(0), milage(0), milage_left(double{0.0}),
    air_pressure(0.0f),
    m_dbop(0), cpu_usage(0), freemem(0),
    pi(0), total_voltage(0), total_current(0),
    soc(0), current_state(""), max_voltage(0),
    max_packnum(0), min_voltage(0), min_packnum(0),
    diff_voltage(0), diff_packnum(0),
    bms_code(0),bms_startup_status(0),bms_state(0),bms_cc2(0),
    charger_conn1(0),charger_conn2(0),bms_pr_state(0),
    mctr_state(0),
    charge_control(0),minus_contactor(0),

    // ALM00
    // B0[0:7]
    emergency_stop(0),
    tmotor_overheat(0),
    tmotor_drv_abnormal(0),
    tmotor_temp_xhigh_pullover(0),
    inadequate_air_pressure(0),
    air_compressor_overheat(0),
    air_compressor_mtr_overheat(0),
    air_compressor_mtdrv_abnormal(0),
    // B1[0:7]
    stmotor_overheat(0),
    stmotor_drv_abnormal(0),
    pk_a_impact_flood_protect_on(0),
    pk_bcd_impact_flood_protect_on(0),
    pk_efg_impact_flood_protect_on(0),
    pk_hi_impact_flood_protect_on(0),
    pk_jk_impact_flood_protect_on(0),
    pk_l_impact_flood_protect_on(0),

    // B2[0:7]
    fl_lining_abnormal(0),
    fr_lining_abnormal(0),
    rl_lining_abnormal(0),
    rr_lining_abnormal(0),
    abs_abnormal(0),
    fdoor_opened(0),
    rdoor_opened(0),
    fdoor_open_forced(0),

    // B3[0:7]
    rdoor_open_forced(0),
    emergency_door_opened(0),
    ecas_warning(0),
    ecas_abnormal(0),
    ecas_is_kneeling(0),
    ramp_not_stowed(0),
    boarding_assistance(0),
    getoff_assistance(0),

    // B4
    is_charging_in_progress(0),
    is_parking_brake_not_released(0),
    is_pneumatic_lock_released(0),
    is_doorlock_released(0),
    is_emergency_doorlock_released(0),
    is_anti_collision_lock_released(0),
    is_ECAS_lock_released(0),
    is_ramps_lock_released(0),

    // B5[0:7] 41 - 48
    is_charger_not_detached(0),
    is_24v_control_voltage_too_low(0),
    is_24v_control_voltage_shortage_warning(0),
    is_voltage_too_low_pull_over_ASAP(0),
    is_low_voltage_warning_charing_ASAP(0),
    is_speeding_warning(0),
    is_overnight_stop_lock_abnormal(0),
    is_insulation_resistance_abnormal(0),

    // B6[0:7] 49 - 56
    is_clutch_pedal_abnormal(0),
    is_not_shift2_neutral(0),
    is_handbrake_not_engaged(0),
    is_starting_up(0),
    is_brake_pedal_abnormal(0),
    is_accelerator_pedal_abnormal(0),
    is_cooling_water_pump_abnormal(0),
    is_radiator_fan_abnormal(0),

    // B7[0:7] 57 - 64
    is_cooling_water_olet_temp_sensor_abnormal(0),
    is_cooling_water_ilet_temp_sensor_abnormal(0),
    is_BMS_comm_abnormal(0),
    is_PCU_comm_abnormal(0),
    is_BCU_comm_abnormal(0),
    //
    //
    //

    // TODO: to be defined
    // ALM_MSG_01
    // B0[0:7]  65 - 72
    // B1[0:7]  73 - 80
    // B2[0:7]  81 - 88
    // B3[0:7]  89 - 96
    // B4[0:7]  97 - 104
    // B5[0:7] 105 - 112
    // B6[0:7] 113 - 120
    // B7[0:7] 121 - 128

    // TODO: to be defined
    // ALM_MSG_02
    // B0[0:7] 129 - 136
    // B1[0:7] 137 - 144
    // B2[0:7] 145 - 152
    // B3[0:7] 153 - 160
    // B4[0:7] 161 - 168
    // B5[0:7] 169 - 176
    // B6[0:7] 177 - 184
    // B7[0:7] 185 - 192

    // TODO: to be defined
    // ALM_MSG_03
    // B0[0:7] 193 - 200
    // B1[0:7] 201 - 208
    // B2[0:7] 209 - 216
    // B3[0:7] 217 - 224
    // B4[0:7] 225 - 232
    // B5[0:7] 233 - 240
    // B6[0:7] 241 - 248
    // B7[0:7] 249 - 256

    // ALM_MSG_04 / DCDC_MSG00
    // B0[0:7] 257 - 264
    is_DCDC_under_o_voltage(0),
    is_DCDC_over_o_voltage(0),
    is_DCDC_under_i_voltage(0),
    is_DCDC_over_i_voltage(0),
    is_DCDC_hwfault(0),
    // B0[5] 262 TBD
    is_DCDC_derating(0),
    is_DCDC_over_i_current(0),

    // B1[0:7] 265 - 272
    is_DCDC_over_temperature(0),
    is_DCDC_over_o_current(0),
    // B1[2:7] TBD

    // B2[0:7] 273 - 280
    // B3[0:7] 281 - 288
    // B4[0:7] 289 - 296
    // B5[0:7] 297 - 299
    // B6[0:7] TBD
    // B7[0:7] TBD

    // ALM_MSG_05 / BCU_ER_MSG01
    // PACK 1
    // B5[0] & B0[0:5] 300 - 305
    // B0[6:7] TBD
    // B5[0] & B1[0:7] 306 - 313

    // PACK 2
    // B5[1] & B0[0:5] 314 - 319
    // B0[6:7] TBD
    // B5[1] & B1[0:7] 320 - 327

    // PACK 3
    // B5[2] & B0[0:5] 328 - 333
    // B0[6:7] TBD
    // B5[2] & B1[0:7] 334 - 341

    // PACK 4
    // B5[3] & B0[0:5] 342 - 347
    // B0[6:7] TBD
    // B5[3] & B1[0:7] 348 - 355

    // PACK 5
    // B5[4] & B0[0:5] 356 - 361
    // B5[6:7] TBD
    // B5[4] & B1[0:7] 362 - 369

    // PACK 6
    // B5[5] & B0[0:5] 370 - 375
    // B5[6:7] TBD
    // B5[5] & B1[0:7] 376 - 383

    // and so on ...

    // PACK 12
    // B6[3] & B0[0:5] 454 - 459
    // B6[3] & B0[6:7] TBD
    // B6[3] & B1[0:7] 460 - 467
    packs(),

    // TODO: to be defined 468 - 499

    // ALM_MSG_05 / BCU_ER_MSG01
    // B0[6:7] 500 - 501
    is_warning_high_voltage_diff_in_driving_stop_lvl1(0),
    is_warning_low_SOC_in_driving_stop_lvl1(0),
    // B2[0:1] 502 - 503
    is_warning_discharge_over_current_lvl1(0),
    is_severe_charge_over_current_lvl2(0),
    // B3[0:7] 504 - 511
    is_severe_CMU_comm_interrupt_in_BMS_lvl2(0),
    is_severe_charge_ECU_comm_interrupt_in_BMS_lvl2(0),
    is_warning_BMS_internal_error_lvl1(0),
    is_severe_voltage_acquisition_error_in_BMS_lvl2(0),
    is_severe_temp_acquisition_error_in_BMS_lvl2(0),
    is_severe_charging_time_too_long_lvl2(0),
    is_severe_charge_comm_error_lvl2(0),
    is_warning_charge_comm_error_lvl1(0),
    // B4[0:5] 512 - 517
    is_severe_low_insulation_resistance_charging_lvl2(0),
    is_severe_low_insulation_resistance_driving_stop_lvl2(0),
    is_warning_low_insulation_resistance_charging_lvl2(0),
    is_warning_low_insulation_resistance_driving_stop_lvl2(0),
    is_severe_high_voltage_interlock_loop_charging_lvl2(0),
    is_severe_high_voltage_interlock_loop_driving_stop_lvl2(0),
    // B6[4:7] 518 - 521
    is_warning_code_518(0),
    is_warning_code_519(0),
    is_warning_charger_ECU_error(0),
    is_warning_BMS_error(0),

    // ALM_MSG_07 / PCU_ST_SYS_3
    // B0[0:7] 600 - 607
    fault_1_generic_hardware_trip(0),
    fault_2_hardware_overcurrent_phase_U(0),
    fault_3_hardware_overcurrent_phase_V(0),
    fault_4_hardware_overcurrent_phase_W(0),
    fault_5_DC_link_overvoltage_hardware_trip(0),
    fault_6(0),
    fault_7(0),
    fault_8(0),
    // B1[0:7] 608 - 615
    fault_9_shoot_through(0),
    fault_10_short_circuit_phse_U_top_switch(0),
    fault_11_short_circuit_phse_U_bottom_switch(0),
    fault_12_short_circuit_phse_V_top_switch(0),
    fault_13_short_circuit_phse_V_bottom_switch(0),
    fault_14_short_circuit_phse_W_top_switch(0),
    fault_15_short_circuit_phse_W_bottom_switch(0),
    fault_16_isolated_power_supply_alarm(0),
    // B2[0:7] 616 - 623
    fault_17_gate_driver_power_supply_fault_phse_U_top_switch(0),
    fault_18_gate_driver_power_supply_fault_phse_U_bottom_switch(0),
    fault_19_gate_driver_power_supply_fault_phse_V_top_switch(0),
    fault_20_gate_driver_power_supply_fault_phse_V_bottom_switch(0),
    fault_21_gate_driver_power_supply_fault_phse_W_top_switch(0),
    fault_22_gate_driver_power_supply_fault_phse_W_bottom_switch(0),
    fault_23_gate_driver_power_supply_fault_short_circuit_top_switches(0),
    fault_24_gate_driver_power_supply_fault_short_circuit_bottom_switches(0),
    // B3[0:7] 624 - 631
    fault_25_stop_signal_1_alarm(0),
    fault_26_stop_signal_2_alarm(0),
    fault_27_overcurrent_software_trip(0),
    fault_28_overvoltage_software_trip(0),
    fault_29_undervoltage_software_trip(0),
    fault_30_overspeed(0),
    fault_31_PMSM_DC_link_voltage_safe_speed_exceeded(0),
    fault_32(0),
    // B4[0:7] 632 - 639
    fault_33(0),
    fault_34_inverter_power_stage_overheat_measurement(0),
    fault_35(0),
    fault_36_application_fault(0),
    fault_37_watchdog_timeout(0),
    fault_38_parameter_system_failure(0),
    fault_39_internal_software_faults_and_warnings(0),
    fault_40(0),
    // B5[0:7] 640 - 647
    fault_41(0),
    fault_42(0),
    fault_43(0),
    fault_44(0),
    fault_45(0),
    fault_46_background_starved(0),
    fault_47(0),
    fault_48(0),
    // B6[0:7] 648 - 655
    fault_49(0),
    fault_50(0),
    fault_51_power_supply_undervoltage(0),
    fault_52(0),
    fault_53(0),
    fault_54(0),
    fault_55(0),
    fault_56(0),
    // B7[0:7] 656 - 663
    fault_57_external_temperature_measurement_fault(0),
    fault_58_inverter_power_stage_overheat(0),
    fault_59_event(0),
    fault_60_enclosure_voltage_trip(0),
    fault_61_overfrequency(0),
    fault_62_earth_fault(0),
    fault_63_phase_U_loss(0),
    fault_64_phase_V_loss(0),

    // ALM_MSG_08 / PCU_ST_SYS_4
    // B0[0:7] 664 - 671
    fault_65_phase_W_loss(0),
    fault_66(0),
    fault_67(0),
    fault_68(0),
    fault_69(0),
    fault_70(0),
    fault_71(0),
    fault_72(0),
    // B1[0:7] 672 - 679
    fault_73(0),
    fault_74(0),
    fault_75(0),
    fault_76(0),
    fault_77(0),
    fault_78(0),
    fault_79(0),
    fault_80(0),
    // B2[0:7] 680 - 687
    fault_81(0),
    fault_82(0),
    fault_83(0),
    fault_84(0),
    fault_85(0),
    fault_86_parallel_communication_faul_PowerMASTER_parallel(0),
    fault_87_parallel_slave_faul_PowerMASTER_parallel(0),
    fault_88(0),
    // B3[0:7] 688 - 695
    fault_89_resolver_error(0),
    fault_90(0),
    fault_91(0),
    fault_92(0),
    fault_93(0),
    fault_94(0),
    fault_95(0),
    fault_96(0),

    // TODO:

    charger_enable(0),
    charging_state(0),
    vehicle_state(0), m_fSlope(double{0.0}), inclination(double{0.0}),
    longitude(0.0f),dir_longitude(""),
    latitude(0.0f),dir_latitude(""),
    altitude(0.0f),
    gps_mileage(0.0f),
    odo(0.0f),v24(0.0f),dtc(0.0f),
    cell_maxv(0),cell_maxi(0),cell_minv(0),cell_mini(0),
    max_pt_temp(0),max_pt_idx(0),charger_cc2(0),
    cellVoltages(),
    itank_temp1(0),otank_temp2(0),motor_temp(0),
    cellTemperatures(),torq(0),gear(0),
    abs_alarm(0),fl_lining(0),fr_lining(0),rl_lining(0),
    rr_lining(0),ecas33f(0),ecas34w(0), // ecas_kneeling(0),
    smoke_detect(),vcu_io(),pcu_io(),brake(0),
    pedal(0),pedal_depth(0),main_dvr_rt(0),main_mt_rt(0),
    penumatic_dvr_rt(0),penumatic_mt_rt(0),
    hyd_rt(0),hym_rt(0),
    key_position(KEY_OFF),
    outdoor_temperature(0.0f),ac_switch(0),
    // msg1 b0
    left_turn(0),right_turn(0),head_light(0),side_light(0),hazard_light(0),
    door_open(0),rear_defogger_light(0),access_light(0),
    // msg1 b1
    ecas_kneeling(0),rear_fog_light(0),alarm_getoff(0),
    motor_overrun(0),regen_brake(0),parking(1),motor_op(0),
    // msg1 b2
    abs(0),ecas_warn(0),lining(0),emergency_exit(0),
    // msg1 b3
    motor_alarm(0),air_alarm(0),psteering_alarm(0),mpower_alarm(0),
    // msg1 b4
    v24_alarm(0),lv_alarm(0),charge_abort(0),wiper(0),lb_light(0), // brake(0),
    // msg b[6:7]
    reading(0),speed(0),
    total(0),trip(0),
    mx_allowed_chg_voltage(0.0f),mx_allowed_chg_current(0.0f),
    chg_time_left_mins(0),num_chg_times(0),
    probe_temperature(),cell_voltage(),
    m_pGSensor(nullptr),
    m_pIOWrapper(nullptr),
    m_AlarmTrigger(),
    m_Alarm(),
    m_AlarmParameters(),
    m_unlockBits(0)
{
#if defined ( QT_DEBUG )
    cout << __func__ <<":"<< __LINE__ << " +" << endl;
#endif
    unit = "km/h";
    rpm_unit = "rpm";
    m_pGSensor = new GSensorWrapper();
    m_pIOWrapper = new IOWrapper();
    m_pIOWrapper->GPS_Power_Switch(0);
    m_pIOWrapper->GPS_Power_Switch(1);
}

Info::~Info() {
    // When you create a QObject with another object as parent,
    // the object will automatically add itself to the parent's children() list.
    // The parent takes ownership of the object;
    // i.e., it will automatically delete its children in its destructor.
    // See Object Trees & Ownership for more information.
    // @see https://t.ly/7982
    m_pIOWrapper->GPS_Power_Switch(0);
    delete m_pIOWrapper;
    delete m_pGSensor;
}

// 0:good; otherwise outlier
int Info::addSpeedMAFilter(uint32_t speed) {
    int rc = 0; int i = 0;
    uint32_t total = 0;

    //if ( qAbs(speed-m_speed) > m_speed/FACTOR_SPEED ) {
    //	rc = 1;
    //}
    //else {
	m_speedMA[m_speedMAIndex%LEN_SPEED_MA_FILTER] = speed;
	for ( i = 0 ; i < LEN_SPEED_MA_FILTER; i++ ) {
	    total += m_speedMA[i];
	}
	m_speed = total/LEN_SPEED_MA_FILTER;
	m_speedMAIndex++;
	if ( UINT32_MAX-1 <= m_speedMAIndex ) m_speedMAIndex++;
    //}
    return rc;
}

#if defined ( EN_DEVELOP_DATA_ )
void Info::setupDataVolt() {
    uint32_t i = 0;
#define NUM_VOLT_REC 48
    QCanBusFrame frames[NUM_VOLT_REC] = {
	QCanBusFrame(static_cast<quint32>(1),
	QByteArray("\x01\x7F\x13\x74\x13\x75\x13\x76",8)),
	QCanBusFrame(static_cast<quint32>(2),
	QByteArray("\x02\x13\x77\x13\x79\x13\x80\x13",8)),
	QCanBusFrame(static_cast<quint32>(3),
	QByteArray("\x03\x81\x13\x82\x13\x83\x13\x84",8)),
	QCanBusFrame(static_cast<quint32>(4),
	QByteArray("\x04\x13\x85\x13\x86\x13\x87\x13",8)),
	QCanBusFrame(static_cast<quint32>(5),
	QByteArray("\x05\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(6),
	QByteArray("\x06\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(7),
	QByteArray("\x07\x00\x00\x00\x00\x00\x00\xFF",8)),
	QCanBusFrame(static_cast<quint32>(8),
	QByteArray("\x08\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(9),
	QByteArray("\x09\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(10),
	QByteArray("\x0a\x00\x00\x00\x00\x00\x00\xFF",8)),

	QCanBusFrame(static_cast<quint32>(11),
	QByteArray("\x0b\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(12),
	QByteArray("\x0c\x33\x33\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(13),
	QByteArray("\x0d\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(14),
	QByteArray("\x0e\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(15),
	QByteArray("\x0f\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(16),
	QByteArray("\x10\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(17),
	QByteArray("\x11\x00\x00\x00\x00\x00\x00\xFF",8)),
	QCanBusFrame(static_cast<quint32>(18),
	QByteArray("\x12\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(19),
	QByteArray("\x13\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(20),
	QByteArray("\x14\x00\x00\x00\x00\x00\x00\xFF",8)),

	QCanBusFrame(static_cast<quint32>(21),
	QByteArray("\x15\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(22),
	QByteArray("\x16\x33\x33\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(23),
	QByteArray("\x17\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(24),
	QByteArray("\x18\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(25),
	QByteArray("\x19\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(26),
	QByteArray("\x1a\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(27),
	QByteArray("\x1b\x00\x00\x00\x00\x00\x00\xFF",8)),
	QCanBusFrame(static_cast<quint32>(28),
	QByteArray("\x1c\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(29),
	QByteArray("\x1d\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(30),
	QByteArray("\x1e\x00\x00\x00\x00\x00\x00\xFF",8)),

	QCanBusFrame(static_cast<quint32>(31),
	QByteArray("\x1f\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(32),
	QByteArray("\x20\x33\x33\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(33),
	QByteArray("\x21\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(34),
	QByteArray("\x22\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(35),
	QByteArray("\x23\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(36),
	QByteArray("\x24\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(37),
	QByteArray("\x25\x00\x00\x00\x00\x00\x00\xFF",8)),
	QCanBusFrame(static_cast<quint32>(38),
	QByteArray("\x26\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(39),
	QByteArray("\x27\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(40),
	QByteArray("\x28\x00\x00\x00\x95\x12\x87\x13",8)),

	QCanBusFrame(static_cast<quint32>(41),
	QByteArray("\x29\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(42),
	QByteArray("\x2a\x33\x33\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(43),
	QByteArray("\x2b\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(44),
	QByteArray("\x2c\x00\x00\x00\x00\x00\x00\x00",8)),

	/* L */
	QCanBusFrame(static_cast<quint32>(45),
	QByteArray("\x2d\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(46),
	QByteArray("\x2e\x00\x00\x00\x00\x00\x00\x00",8)),
	QCanBusFrame(static_cast<quint32>(47),
	QByteArray("\x2f\x00\x00\x00\x00\x00\x00\xFF",8)),
	QCanBusFrame(static_cast<quint32>(48),
	QByteArray("\x30\x00\x00\x00\x00\x00\x87\x13",8))
    };
    for ( i = 0; i < NUM_VOLT_REC; i++ ) {
	cached_cell_voltage.insert(i+1, frames[i]);
    }
}

void Info::setupDataTemperature() {
    unsigned int i = 0;
#define NUM_TEMP_REC 7
    QCanBusFrame frames[NUM_TEMP_REC] = {
	QCanBusFrame(static_cast<quint32>(1),
	QByteArray("\x01\x3d\x3d\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(2),
	QByteArray("\x02\x33\x33\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(3),
	QByteArray("\x03\x3d\x3d\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(4),
	QByteArray("\x04\x3d\x3d\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(5),
	QByteArray("\x05\x3d\x3d\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(6),
	QByteArray("\x06\x3d\x3d\x3d\x3d\x32\x32\x32",8)),
	QCanBusFrame(static_cast<quint32>(7),
	QByteArray("\x07\x3d\x3d\x3d\x3d\x32\x32\xFF",8))
    };
    for ( i = 0; i < NUM_TEMP_REC; i++ ) {
	cached_probe_temperature.insert(i+1, frames[i]);
    }
}
#endif

void Info::onLogVehicleInfo(void) {
    char fpath[128] = {0}; // file name length
    char ltime[24] = {0};
    struct tm tstruct; int i,j;
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif
    std::time_t time_sec_now = std::time(nullptr);
    tstruct = *localtime(&time_sec_now);
    QDir wdir;
    strftime(fpath, sizeof(fpath),
#if 0
	"/home/racev/dashboard.d/vir/%Y-%m-%d-%H-00-00.csv", &tstruct);
#endif
#if 1
    wdir.toNativeSeparators(wdir.absoluteFilePath("%Y-%m-%d-%H-00-00.csv")).toStdString().c_str(),&tstruct);
#endif
    strftime(ltime, sizeof(ltime), "%Y-%m-%d %H:%M:%S", &tstruct);
    // TODO: configurable
    // @see https://tinyurl.com/q4y5np
    // @see https://tinyurl.com/y3nxb2r3
    m_file.open(fpath, std::ios_base::app);
    // "/home/racev/dashboard.d/vir/2019-09-19.csv",
    m_file
	<< time_sec_now << "," // @see https://tinyurl.com/yxhkomb7
	<< ltime << ","
	<< longitude << ","
	<< latitude << ","
	<< altitude << ","
	<< gps_mileage << ","

	// << std::dec << setw(5) << setprecision (1) << fixed
	<< total_voltage << ","

	// << std::dec << setw(5) << setprecision (2) << fixed
	<< total_current << ","

	<< rpm << ","

	<< setw(3)
	<< m_speed << ","

	<< odo << ","
	<< soc << ","
	<< milage_left << ","
	<< air_pressure << ","
	<< bms_code << ","

	<< dtc << ","
	<< m_fSlope << ","
	<< inclination << ","
	<< v24 << ","
	<< cell_mini << ","
	<< cell_minv << ","
	<< cell_maxi << ","
	<< cell_maxv << ","
	<< max_pt_idx << ","
	<< max_pt_temp << ",";

    for ( i = 0; i < NUM_PACKS; i++ )
	for ( j = 0; j < NUM_CELLS; j++ )
	    m_file << cellVoltages[i][j] << ","; // (i*NUM_PACKS+j)+1

    m_file << itank_temp1 << ",";
    m_file << otank_temp2 << ",";

    for ( i = 0; i < NUM_PACKS; i++ )
	for ( j = 0; j < NUM_TPROBE; j++ )
	    m_file << cellTemperatures[i][j] << ",";
    m_file << torq << ",";
    m_file << gear << ",";

    m_file << abs_alarm << ",";
    m_file << fl_lining << ",";
    m_file << fr_lining << ",";
    m_file << rl_lining << ",";
    m_file << rr_lining << ",";
    m_file << ecas33f << ",";
    m_file << ecas_kneeling << ",";
    m_file << ecas34w << ",";

    for ( i = 0; i < NUM_SMOKE; i++ )
	m_file << smoke_detect[i] << ",";
    for ( i = 0; i < NUM_VCUIO; i++ )
	m_file << vcu_io[i] << ",";
    for ( i = 0; i < NUM_PCUIO; i++ )
	m_file << pcu_io[i] << ",";
    m_file << brake << ",";
    m_file << pedal << ",";
    m_file << pedal_depth << ",";
    m_file << main_dvr_rt << ",";
    m_file << main_mt_rt << ",";
    m_file << penumatic_dvr_rt << ",";
    m_file << penumatic_mt_rt << ",";
    m_file << hyd_rt << ",";
    m_file << hym_rt << ",";
    m_file << outdoor_temperature << ",";
    m_file << ac_switch << ",";

    m_file << /*"\n" <<*/ endl;
    m_file.close();
    // TODO: improve performance

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " -" << endl;
#endif
    return;
}

void Info::handleAlarmBits(
    int alarmIndex, int byteIndex,
    QByteArray prevPayload, QByteArray currentPayload,
    int* pBit0, int* pBit1, int* pBit2, int* pBit3,
    int* pBit4, int* pBit5, int* pBit6, int* pBit7 ) {

    // B(byteIndex)[0:7]
    // Is comparing to zero faster than comparing to any other number?
    // generally yes
    // ref. ( https://stackoverflow.com/a/22466316 )
    if ( pBit0 ) {
        *pBit0 = (currentPayload[byteIndex]&1U)>>0;
        if ( (currentPayload[byteIndex]&0x01) )
            m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<0);
        else
            m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<0);
        if ( (prevPayload[byteIndex]&0x01)^(currentPayload[byteIndex]&0x01) )
            m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<0);
        else
            m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<0);
    }
#if 0
    cout << __FILE__ << ":" << __LINE__ << " " << __func__
	<< " prev " << hex
	<< setfill('0') << setw(2) << (prevPayload[byteIndex]&0xFF) << " "
	<< " curr "
	<< setfill('0') << setw(2) << (currentPayload[byteIndex]&0xFF) << " "
	<< " trigger "
	<< setfill('0') << setw(2)
	<< ((prevPayload[0]&0x01)^(currentPayload[byteIndex]&0x01)) << " "
	<< dec
	<< endl;
#endif

    if ( pBit1 ) {
	*pBit1 = (currentPayload[byteIndex]&0x02)>>1;
	if ( (currentPayload[byteIndex]&0x02) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<1);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<1);
	if ( (prevPayload[byteIndex]&0x02)^(currentPayload[byteIndex]&0x02) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<1);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<1);
    }

    if ( pBit2 ) {
	*pBit2 = (currentPayload[byteIndex]&0x04)>>2;
	if ( (currentPayload[byteIndex]&0x04) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<2);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<2);
	if ( ((prevPayload[byteIndex]&0x04)^(currentPayload[byteIndex]&0x04)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<2);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<2);
    }

    if ( pBit3 ) {
	*pBit3 = (currentPayload[byteIndex]&0x08)>>3;
	if ( (currentPayload[byteIndex]&0x08) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<3);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<3);
	if ( ((prevPayload[byteIndex]&0x08)^(currentPayload[byteIndex]&0x08)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<3);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<3);
    }

    if ( pBit4 ) {
	*pBit4 = (currentPayload[byteIndex]&0x10)>>4;
	if ( (currentPayload[byteIndex]&0x10) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<4);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<4);
	if ( ((prevPayload[byteIndex]&0x10)^(currentPayload[byteIndex]&0x10)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] ^= (1U<<4);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<4);
    }

    if ( pBit5 ) {
	*pBit5 = (currentPayload[byteIndex]&0x20)>>5;
	if ( (currentPayload[byteIndex]&0x20) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<5);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<5);
	if ( ((prevPayload[byteIndex]&0x20)^(currentPayload[byteIndex]&0x20)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] ^= (1U<<5);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<5);
    }

    if ( pBit6 ) {
    *pBit6 = (currentPayload[byteIndex]&0x40)>>6;
	if ( (currentPayload[byteIndex]&0x40) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<6);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<6);
	if ( ((prevPayload[byteIndex]&0x40)^(currentPayload[byteIndex]&0x40)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<6);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<6);
    }

    if ( pBit7 ) {
	*pBit7 = (currentPayload[byteIndex]&0x80)>>7;
	if ( (currentPayload[byteIndex]&0x80) )
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<7);
	else
	    m_Alarm[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<7);
	if ( ((prevPayload[byteIndex]&0x80)^(currentPayload[byteIndex]&0x80)) )
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] |= (1U<<7);
	else
	    m_AlarmTrigger[alarmIndex*NUM_BYTE_ALARM+byteIndex] &= ~(1U<<7);
    }
}

// is replaced by Info::handleAlarmPackBits()
#if 0
void Info::handleAlarmBitsWithFlag(
    int alarmIndex, int byteIndex,
    int flagByte, int flagBit,
    QByteArray prevPayload, QByteArray currentPayload,
    int* pBit0, int* pBit1, int* pBit2, int* pBit3,
    int* pBit4, int* pBit5, int* pBit6, int* pBit7 ) {
    int pack = 0; int entry = 0;

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " +"
	<< " alarmIndex " << alarmIndex
	<< " byteIndex " << byteIndex
	<< " flagByte " << flagByte
	<< " flagBit " << flagBit
	<< endl;
#endif

#if defined ( _ENHANCED_CHECK_ )
    if ( flagByte != 5 && flagByte != 6 ) {
	cout << __FILE__ << ":" << __LINE__ << " flagByte "
	    << flagByte << endl;
	return;
    }

    if ( flagByte == 5 && ( flagBit < 0 || 7 < flagBit ) ) {
	cout << __FILE__ << ":" << __LINE__ << " flagByte "
	    << flagByte << " flagBit " << flagBit << endl;
	return;
    }

    if ( flagByte == 6 && ( flagBit < 0 || 3 < flagBit ) ) {
	cout << __FILE__ << ":" << __LINE__ << " flagByte "
	    << flagByte << " flagBit " << flagBit << endl;
	return;
    }
#endif

    pack = (flagByte - 5 ) * NUM_BYTE_ALARM + flagBit;
    // locate the entry for the pack in alarm bitmaps
    entry = ( alarmIndex*NUM_BYTE_ALARM )
	+ ( pack * ALARM_BYTE_PER_PACK ) + byteIndex ;

    if ( pBit0 ) {
	*pBit0 = (currentPayload[byteIndex]&1U)>>0;
	if ( (currentPayload[byteIndex]&0x01) )
	    m_Alarm[entry] |= (1U<<0);
	else
	    m_Alarm[entry] &= ~(1U<<0);
	if ( (prevPayload[byteIndex]&0x01)^(currentPayload[byteIndex]&0x01) )
	    m_AlarmTrigger[entry] |= (1U<<0);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<0);
    }
#if 0
    cout << __FILE__ << ":" << __LINE__ << " " << __func__
	<< " prev " << hex
	<< setfill('0') << setw(2) << (prevPayload[byteIndex]&0xFF) << " "
	<< " curr "
	<< setfill('0') << setw(2) << (currentPayload[byteIndex]&0xFF) << " "
	<< " trigger "
	<< setfill('0') << setw(2)
	<< ((prevPayload[0]&0x01)^(currentPayload[byteIndex]&0x01)) << " "
	<< dec
	<< endl;
#endif

    if ( pBit1 ) {
	*pBit1 = (currentPayload[byteIndex]&0x02)>>1;
	if ( (currentPayload[byteIndex]&0x02) )
	    m_Alarm[entry] |= (1U<<1);
	else
	    m_Alarm[entry] &= ~(1U<<1);
	if ( (prevPayload[byteIndex]&0x02)^(currentPayload[byteIndex]&0x02) )
	    m_AlarmTrigger[entry] |= (1U<<1);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<1);
    }

    if ( pBit2 ) {
	*pBit2 = (currentPayload[byteIndex]&0x04)>>2;
	if ( (currentPayload[byteIndex]&0x04) )
	    m_Alarm[entry] |= (1U<<2);
	else
	    m_Alarm[entry] &= ~(1U<<2);
	if ( ((prevPayload[byteIndex]&0x04)^(currentPayload[byteIndex]&0x04)) )
	    m_AlarmTrigger[entry] |= (1U<<2);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<2);
    }

    if ( pBit3 ) {
	*pBit3 = (currentPayload[byteIndex]&0x08)>>3;
	if ( (currentPayload[byteIndex]&0x08) )
	    m_Alarm[entry] |= (1U<<3);
	else
	    m_Alarm[entry] &= ~(1U<<3);
	if ( ((prevPayload[byteIndex]&0x08)^(currentPayload[byteIndex]&0x08)) )
	    m_AlarmTrigger[entry] |= (1U<<3);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<3);
    }

    if ( pBit4 ) {
	*pBit4 = (currentPayload[byteIndex]&0x10)>>4;
	if ( (currentPayload[byteIndex]&0x10) )
	    m_Alarm[entry] |= (1U<<4);
	else
	    m_Alarm[entry] &= ~(1U<<4);
	if ( ((prevPayload[byteIndex]&0x10)^(currentPayload[byteIndex]&0x10)) )
	    m_AlarmTrigger[entry] ^= (1U<<4);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<4);
    }

    if ( pBit5 ) {
	*pBit5 = (currentPayload[byteIndex]&0x20)>>5;
	if ( (currentPayload[byteIndex]&0x20) )
	    m_Alarm[entry] |= (1U<<5);
	else
	    m_Alarm[entry] &= ~(1U<<5);
	if ( ((prevPayload[byteIndex]&0x20)^(currentPayload[byteIndex]&0x20)) )
	    m_AlarmTrigger[entry] ^= (1U<<5);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<5);
    }

    if ( pBit6 ) {
    *pBit6 = (currentPayload[byteIndex]&0x40)>>6;
	if ( (currentPayload[byteIndex]&0x40) )
	    m_Alarm[entry] |= (1U<<6);
	else
	    m_Alarm[entry] &= ~(1U<<6);
	if ( ((prevPayload[byteIndex]&0x40)^(currentPayload[byteIndex]&0x40)) )
	    m_AlarmTrigger[entry] |= (1U<<6);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<6);
    }

    if ( pBit7 ) {
	*pBit7 = (currentPayload[byteIndex]&0x80)>>7;
	if ( (currentPayload[byteIndex]&0x80) )
	    m_Alarm[entry] |= (1U<<7);
	else
	    m_Alarm[entry] &= ~(1U<<7);
	if ( ((prevPayload[byteIndex]&0x80)^(currentPayload[byteIndex]&0x80)) )
	    m_AlarmTrigger[entry] |= (1U<<7);
	else
	    m_AlarmTrigger[entry] &= ~(1U<<7);
    }
}
#endif

// for each set there is 14 bits, that occupies 2 bytes
#define ALARM_BYTE_PER_PACK 2
// 2 bits version, bit and flag bit
// assume there is only one bit flag for the whole bits
// and within the same byte
// design for alarm id, from 300 to 467
// flag bit is from B5[0] to B6[3], 12 bits (sets)


// revised for battery pack bits exclusively
void Info::handleAlarmPackBits(int index,
    QByteArray prevPayload, QByteArray currentPayload) {
    int entry = 0;
    // locate the entry for the pack in alarm bitmaps
    // alarmIndex
    entry = ( 5*NUM_BYTE_ALARM )+( index * ALARM_BYTE_PER_PACK );

    // B5[0] & B0[0:5]
    packs[index].is_severe_high_voltage_in_charging
	= (currentPayload[5]&1U)>>0;
    if ( (currentPayload[5]&0x01) )
	m_Alarm[entry] |= (1U<<0);
    else
	m_Alarm[entry] &= ~(1U<<0);
    if ( (prevPayload[5]&0x01)^(currentPayload[5]&0x01) )
	m_AlarmTrigger[entry] |= (1U<<0);
    else
	m_AlarmTrigger[entry] &= ~(1U<<0);

    packs[index].is_severe_high_voltage_in_driving_stop
	= (currentPayload[0]&0x02)>>1;
    if ( (currentPayload[0]&0x02) )
	m_Alarm[entry] |= (1U<<1);
    else
	m_Alarm[entry] &= ~(1U<<1);
    if ( (prevPayload[0]&0x02)^(currentPayload[0]&0x02) )
	m_AlarmTrigger[entry] |= (1U<<1);
    else
	m_AlarmTrigger[entry] &= ~(1U<<1);


    packs[index].is_warning_high_voltage_in_charging
	= (currentPayload[0]&0x04)>>2;
    if ( (currentPayload[0]&0x04) )
	m_Alarm[entry] |= (1U<<2);
    else
	m_Alarm[entry] &= ~(1U<<2);
    if ( ((prevPayload[0]&0x04)^(currentPayload[0]&0x04)) )
	m_AlarmTrigger[entry] |= (1U<<2);
    else
	m_AlarmTrigger[entry] &= ~(1U<<2);

    packs[index].is_warning_high_voltage_in_driving_stop
	= (currentPayload[0]&0x08)>>3;
    if ( (currentPayload[0]&0x08) )
	m_Alarm[entry] |= (1U<<3);
    else
	m_Alarm[entry] &= ~(1U<<3);
    if ( ((prevPayload[0]&0x08)^(currentPayload[0]&0x08)) )
	m_AlarmTrigger[entry] |= (1U<<3);
    else
	m_AlarmTrigger[entry] &= ~(1U<<3);

    packs[index].is_severe_low_voltage_in_charging
	= (currentPayload[0]&0x10)>>4;
    if ( (currentPayload[0]&0x10) )
	m_Alarm[entry] |= (1U<<4);
    else
	m_Alarm[entry] &= ~(1U<<4);
    if ( ((prevPayload[0]&0x10)^(currentPayload[0]&0x10)) )
	m_AlarmTrigger[entry] ^= (1U<<4);
    else
	m_AlarmTrigger[entry] &= ~(1U<<4);

    packs[index].is_warning_low_voltage_in_driving_stop
	= (currentPayload[0]&0x20)>>5;
    if ( (currentPayload[0]&0x20) )
	m_Alarm[entry] |= (1U<<5);
    else
	m_Alarm[entry] &= ~(1U<<5);
    if ( ((prevPayload[0]&0x20)^(currentPayload[0]&0x20)) )
	m_AlarmTrigger[entry] ^= (1U<<5);
    else
	m_AlarmTrigger[entry] &= ~(1U<<5);
    // B5[0] & B5[6:7] TBD

    // B5[0] & B1[0:7]
    packs[index].is_severe_high_temperature_in_charging
	= (currentPayload[1]&1U)>>0;
    if ( (currentPayload[1]&0x01) )
	m_Alarm[entry] |= (1U<<0);
    else
	m_Alarm[entry] &= ~(1U<<0);
    if ( (prevPayload[1]&0x01)^(currentPayload[1]&0x01) )
	m_AlarmTrigger[entry] |= (1U<<0);
    else
	m_AlarmTrigger[entry] &= ~(1U<<0);

    packs[index].is_severe_high_temperature_in_driving_stop
	= (currentPayload[1]&0x02)>>1;
    if ( (currentPayload[1]&0x02) )
	m_Alarm[entry] |= (1U<<1);
    else
	m_Alarm[entry] &= ~(1U<<1);
    if ( (prevPayload[1]&0x02)^(currentPayload[1]&0x02) )
	m_AlarmTrigger[entry] |= (1U<<1);
    else
	m_AlarmTrigger[entry] &= ~(1U<<1);

    packs[index].is_warning_high_temperature_in_charging
	= (currentPayload[1]&0x04)>>2;
    if ( (currentPayload[1]&0x04) )
	m_Alarm[entry] |= (1U<<2);
    else
	m_Alarm[entry] &= ~(1U<<2);
    if ( ((prevPayload[1]&0x04)^(currentPayload[1]&0x04)) )
	m_AlarmTrigger[entry] |= (1U<<2);
    else
	m_AlarmTrigger[entry] &= ~(1U<<2);

    packs[index].is_warning_high_temperature_in_driving_stop
	= (currentPayload[1]&0x08)>>3;
    if ( (currentPayload[1]&0x08) )
	m_Alarm[entry] |= (1U<<3);
    else
	m_Alarm[entry] &= ~(1U<<3);
    if ( ((prevPayload[1]&0x08)^(currentPayload[1]&0x08)) )
	m_AlarmTrigger[entry] |= (1U<<3);
    else
	m_AlarmTrigger[entry] &= ~(1U<<3);

    packs[index].is_severe_low_temperature_in_charging
	= (currentPayload[1]&0x10)>>4;
    if ( (currentPayload[1]&0x10) )
	m_Alarm[entry] |= (1U<<4);
    else
	m_Alarm[entry] &= ~(1U<<4);
    if ( ((prevPayload[1]&0x10)^(currentPayload[1]&0x10)) )
	m_AlarmTrigger[entry] ^= (1U<<4);
    else
	m_AlarmTrigger[entry] &= ~(1U<<4);

    packs[index].is_severe_low_temperature_in_driving_stop
	= (currentPayload[1]&0x20)>>5;
    if ( (currentPayload[1]&0x20) )
	m_Alarm[entry] |= (1U<<5);
    else
	m_Alarm[entry] &= ~(1U<<5);
    if ( ((prevPayload[1]&0x20)^(currentPayload[1]&0x20)) )
	m_AlarmTrigger[entry] ^= (1U<<5);
    else
	m_AlarmTrigger[entry] &= ~(1U<<5);

    packs[index].is_warning_low_temperature_in_charging
	= (currentPayload[1]&0x40)>>6;
    if ( (currentPayload[1]&0x40) )
	m_Alarm[entry] |= (1U<<6);
    else
	m_Alarm[entry] &= ~(1U<<6);
    if ( ((prevPayload[1]&0x40)^(currentPayload[1]&0x40)) )
	m_AlarmTrigger[entry] |= (1U<<6);
    else
	m_AlarmTrigger[entry] &= ~(1U<<6);

    packs[index].is_warning_low_temperature_in_driving_stop
	= (currentPayload[1]&0x80)>>7;
    if ( (currentPayload[1]&0x80) )
	m_Alarm[entry] |= (1U<<7);
    else
	m_Alarm[entry] &= ~(1U<<7);
    if ( ((prevPayload[1]&0x80)^(currentPayload[1]&0x80)) )
	m_AlarmTrigger[entry] |= (1U<<7);
    else
	m_AlarmTrigger[entry] &= ~(1U<<7);
}

// TODO: evaluate drag, pinch, zoom, swipe*(left,right)
/*
    scroll to "NEXT, 1 id"
              "PREV, 2 id"
    tap is simple and easy to use
 */
void Info::onClickAlarmRectangle(QString cmd, int number) {
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " +"
	<< " cmd " << cmd.toStdString()
	<< " number " << number
	<< endl;
#endif
}

void Info::displayAlarmBits(void) {
    // cout << __FILE__ << ":" << __LINE__ << " " << __func__ << endl;
    cout << "trigger/alarm " << endl;
    for ( int i = 0; i < NUM_ALARM_ID; i++ ) {
	cout << setfill('0') << setw(2) << i << ": " << endl;
	for ( int i1 = 0; i1 < NUM_BYTE_ALARM; i1++ ) {
	    cout << hex
	    << setfill('0') << setw(2)
	    << (m_AlarmTrigger[i*NUM_BYTE_ALARM+i1]&0xFF) << " ";
	}
	cout << "    ";
	for ( int i2 = 0; i2 < NUM_BYTE_ALARM; i2++ ) {
	    cout << hex
	    << setfill('0') << setw(2)
	    << (m_Alarm[i*NUM_BYTE_ALARM+i2]&0xFF) << " ";
	}
	cout << " " << endl;
    }
    cout << dec << endl;
}

/*
 * retrieve text
 */
QString Info::getAlarmText(QString locale, int alarmIndex, int byteIndex, int bitIndex) {
    QString message = "L, 0, 0, 0";
    // TODO: id, locale
    // Alarm value , alarm trigger, m_AlarmParameters display setting
    return message;
}
