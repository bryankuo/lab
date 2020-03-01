#ifndef INFO_H
#define INFO_H

#include <cstdint>
#include <string>
#include <fstream>
#include <climits>

#include <QObject>
#include <QCanBusFrame>
#include <QHash>
#include <QDebug>
#include <QMutex>

#include "constants.h"
#include "accelerometer/gsensor_wrapper.h"
#include "vtc6210bk/io/iowrapper.h"
//
// vehicle context
//

// vehicle specific address (ref. doc)
// main page ( hex //int[bits] )
#define VCU_HMI_Msg_1 0x0CFF0022 //218038306[01100111111110000000000100010]
#define VCU_HMI_Msg_2 0x18FF0122 //419365154[11000111111110000000100100010]
#define VCU_HMI_Msg_3 0x18FF0222 //419365410[11000111111110000001000100010]
#define VCU_HMI_Msg_4 0x18FF0322 //419365666[11000111111110000001100100010]

#define BMS_VCU_Msg01 0x18FF90F4 //419401972[11000111111111001000011110100]

#if 0 // TODO: fill up
#define ADAS_Read_Msg // 0x0CFF0C22
ADAS_ACC1_Msg // 0x10FE6FE8
ADAS_FLI1_Msg // 0x10F007E8
ADAS_FLI2_Msg // 0x18FE5BE8
ADAS_DMI_Msg // 0x18FECAE8
#endif

// battery page
#define BMS_VCU_Msg02 0x18FF95F4 //419403252[11000111111111001010111110100]

// charging page
#define BMS_VCU_Msg03 0x18FF96F4
#define BMS_VCU_Msg04 0x18FF97F4
#define BMS_OBC_MSG01 0x18FF98F4

// 0 received, obselete, yet NEXCOM VOIB-CAN06 works
#define BMS_Volt_Msg01 0x1CFF91F4 //486511092[11100111111111001000111110100]
#define BMS_Temp_Msg01 0x1CFF92F4 //486511348[11100111111111001001011110100]

#define J1939_BAM_HEAD 0x1CECFFF4 //485294068[11100111011001111111111110100]
#define J1939_BAM_BODY 0x1CEBFFF4 //485228532[11100111010111111111111110100]
// grep --color="auto" -e "0x1cecfff4" -e "0x1cebfff4" cthread-cap.txt | cut -d' ' -f1-15 > bam.csv

#define J1939_BAM_VLTG 0x91
#define J1939_BAM_TEMP 0x92
//#define EN_DEVELOP_DATA_

#define BCU_VCU_MSG0  0x0CFF2022 // BCU_VCU_IO_Signal_Msg
#define BCU_VCU_SMD   0x18FF2122 // BCU_VCU_Smoke_Detect_Msg

#define BCU_ER_MSG01 0x18FF93F4 // BMS_Error_Msg01
#define BMS_CMUERR_MSG01 0x18FF94F4

#define HMI_TM_MSG01   0x18FF6811
#define VCU_FN_DISABLE 0x18FF6911 // VCU_Function_Disable_Msg
#define VCU_PWR_STATUS 0x18FF0822

// TODO: tx parameter pgn 59904
#define SEND_NONCE_
#if defined ( SEND_NONCE_ )
#define NONCE_1_MSG    0x1CEA2211
#define NONCE_2_MSG    0x18EA3311
#define NONCE_3_MSG    0x0CEA2211
#endif

#define TPMS_MSG01 0x18FEF433
#define TPMS_MSG02 0x18FEF403 // TODO: calibration purpose?

#define VCU_IOSIG_MSG 0x0CFF0922 // VCU_IO_Signal_Msg
#define PCU_IO_SIG00  0x0CFF4026 // PCU_IO_Signal_Msg
#define PCU_ST_SYS_1  0x0CFF4126 // PCU_ST_SYS_1
#define PCU_ST_SYS_2  0x0CFF4226 // PCU_ST_SYS_2
#define PCU_ST_SYS_3  0x14FF4326 // PCU_ST_SYS_3
#define PCU_ST_SYS_4  0x14FF4426 // PCU_ST_SYS_4

#define PCU_ST_MOT_1  0x0CFF4526 // PCU_ST_MOT_1
#define PCU_ST_MOT_2  0x14FF4626 // PCU_ST_MOT_2
#define PCU_ST_MOT_3  0x0CFF4B26 // PCU_ST_MOT_3
#define PCU_CMD_SYS_1 0x0CFF4726 // PCU_CMD_SYS_1
#define PCU_CMD_MOT_1 0x0CFF4826 // PCU_CMD_MOT_1
#define PCU_CMD_MOT_2 0x14FF4926 // PCU_CMD_MOT_2
#define PCU_CMD_MOT_3 0x14FF4A26 // PCU_CMD_MOT_3
#define VCU_DIAG01    0x18FF1322 // VCU_Diagnostic_Msg_1
#define VCU_DIAG02    0x18FF1422 // VCU_Diagnostic_Msg_2
#define VCU_DMRT_CLR  0x18FF6A11 // VCU_驅動器馬達運轉時間清除
#define DCDC_MSG00    0x18FF5051 // DCDC_Status_Msg

// Alarm Record ( in sequence )
#define ALM_MSG_00 0x18FF0422	    // alarm index 0
#define ALM_MSG_01 0x18FF0522	    // alarm index 1
#define ALM_MSG_02 0x18FF0622	    // alarm index 2
#define ALM_MSG_03 0x18FF0722	    // alarm index 3
#define ALM_MSG_04 DCDC_MSG00	    // alarm index 4
#define ALM_MSG_05 BCU_ER_MSG01	    // alarm index 5
#define ALM_MSG_06 BMS_CMUERR_MSG01 // alarm index 6
#define ALM_MSG_07 PCU_ST_SYS_3	    // alarm index 7
#define ALM_MSG_08 PCU_ST_SYS_4	    // alarm index 8

using namespace std;

typedef struct alarm_parameter {
    int idx;
    int display;
    int record;
    int beeps;
    int voice;
    std::string content;
} ALARM_PARAMETER;

typedef struct battery_pack_bits {
    // B5[1] & B0[0:5] 314 - 319
    int is_severe_high_voltage_in_charging;
    int is_severe_high_voltage_in_driving_stop;
    int is_warning_high_voltage_in_charging;
    int is_warning_high_voltage_in_driving_stop;
    int is_severe_low_voltage_in_charging;
    int is_warning_low_voltage_in_driving_stop;
    // B5[6:7] TBD
    // B5[1] & B1[0:7] 320 - 327
    int is_severe_high_temperature_in_charging;
    int is_severe_high_temperature_in_driving_stop;
    int is_warning_high_temperature_in_charging;
    int is_warning_high_temperature_in_driving_stop;
    int is_severe_low_temperature_in_charging;
    int is_severe_low_temperature_in_driving_stop;
    int is_warning_low_temperature_in_charging;
    int is_warning_low_temperature_in_driving_stop;

    // B0[0:7] & B1[0:3]
    int is_warning_minus_contactor_error_not_closed;
    // B2[0:7] & B3[0:3]
    int is_warning_minus_contactor_error_adhesion;
    // B4[0:7] & B5[0:3]
    int is_warning_fan_relay_error_not_closed;
    // B6[0:7] & B7[0:3]
    int is_warning_fan_relay_error_adhesion;
} BATTERY_PACK_BITS;

// Q: how to signal main application slot? using GObject?
class Info : public QObject {
    Q_OBJECT
public:
    Info();
    ~Info();

    // 靜態空間變數/全域變數，是接近 evil 的東西 ( http://tinyurl.com/y2xabqck )
    //static const quint32 ADDR_VCU_HMI_MSG1;
    quint32 m_addrVCU_HMI_MSG1;
    quint32 m_addrVCU_HMI_MSG2;
    quint32 m_addrVCU_HMI_MSG3;
    quint32 m_addrVCU_HMI_MSG4;
    quint32 m_addrBMS_VCU_MSG1;
    quint32 m_addrBMS_VCU_MSG2;
    quint32 m_addrBMS_VCU_MSG03;
    quint32 m_addrBMS_VCU_MSG04;
    quint32 m_addrBMS_OBC_MSG01;
    quint32 m_addrBMS_VOLT_MSG01;
    quint32 m_addrBMS_TEMP_MSG01;
    quint32 m_addrJ1939_BAM_HEAD;
    quint32 m_addrJ1939_BAM_BODY;
    quint32 m_addrPCU_IO_SIG00;
    quint32 m_addrBCU_VCU_MSG0;
    quint32 m_addrBCU_ER_MSG01;
    quint32 m_addrBMS_CMUERR_MSG01;
    quint32 m_addrTPMS_MSG01;
    quint32 m_addrTPMS_MSG02;
#define LEN_SPEED_MA_FILTER 3
    uint32_t m_speed; // MA value
    uint32_t m_speedMA[LEN_SPEED_MA_FILTER]; // MA filter
    uint32_t m_speedMAIndex;

    //std::string unit{"km/h"};
    std::string unit;
    std::string rpm_unit;
    // std::string gear; // "N", "P", "R", "1"...
    uint rpm;
    int turnIndicator; //0:off, 1:left, 2:right, 3:both
    uint64_t milage; // from VCU
    double milage_left;
    float air_pressure;
    uint32_t m_dbop;
    int cpu_usage;
    int freemem;

    double pi; // to be obsolete
    double total_voltage;
    double total_current;
    uint32_t soc;
    std::string current_state;

    // TODO: verify if obselete
    double max_voltage;
    uint32_t max_packnum;
    double min_voltage;
    uint32_t min_packnum;
    double diff_voltage;
    uint32_t diff_packnum;

    // TODO: bms/charger block
    uint32_t bms_code;
    uint8_t bms_startup_status;  // B2.[45]
    int bms_state;	    // BVM01,B5[01]***
    uint8_t bms_cc2;
    uint8_t charger_conn1;
    uint8_t charger_conn2;
    uint8_t bms_pr_state;
    uint8_t mctr_state;
    uint8_t charge_control; // B0.[2]
    uint32_t minus_contactor; // B[34]

    // ALM_MSG_00
    // B0[0:7]
    // 0 : false, 1 : true
    int emergency_stop;
    int tmotor_overheat;
    int tmotor_drv_abnormal;
    int tmotor_temp_xhigh_pullover;
    int inadequate_air_pressure;
    int air_compressor_overheat;
    int air_compressor_mtr_overheat;
    int air_compressor_mtdrv_abnormal;

    // B1[0:7]
    int stmotor_overheat;
    int stmotor_drv_abnormal;
    int pk_a_impact_flood_protect_on;
    int pk_bcd_impact_flood_protect_on;
    int pk_efg_impact_flood_protect_on;
    int pk_hi_impact_flood_protect_on;
    int pk_jk_impact_flood_protect_on;
    int pk_l_impact_flood_protect_on;

    // B2[0:7]
    int fl_lining_abnormal;
    int fr_lining_abnormal;
    int rl_lining_abnormal;
    int rr_lining_abnormal;
    int abs_abnormal;
    int fdoor_opened;
    int rdoor_opened;
    int fdoor_open_forced;

    // note: keep the same wording as doc, as close as possible
    // note: if there is inconsistency between xl and alarm,
    //       follow alarm file first priority

    // B3[0:7]
    int rdoor_open_forced;
    int emergency_door_opened;
    int ecas_warning;
    int ecas_abnormal;
    int ecas_is_kneeling;
    int ramp_not_stowed;
    int boarding_assistance;
    int getoff_assistance;

    // B4[0:7]
    int is_charging_in_progress; // ALM00,B4[0]***
    int is_parking_brake_not_released;
    int is_pneumatic_lock_released;
    int is_doorlock_released;
    int is_emergency_doorlock_released;
    int is_anti_collision_lock_released;
    int is_ECAS_lock_released;
    int is_ramps_lock_released;

    // B5[0:7] 41 - 48
    int is_charger_not_detached;
    int is_24v_control_voltage_too_low;
    int is_24v_control_voltage_shortage_warning;
    int is_voltage_too_low_pull_over_ASAP;
    int is_low_voltage_warning_charing_ASAP;
    int is_speeding_warning;
    int is_overnight_stop_lock_abnormal;
    int is_insulation_resistance_abnormal;

    // B6[0:7] 49 - 56
    int is_clutch_pedal_abnormal;
    int is_not_shift2_neutral;
    int is_handbrake_not_engaged;
    int is_starting_up;
    int is_brake_pedal_abnormal;
    int is_accelerator_pedal_abnormal;
    int is_cooling_water_pump_abnormal;
    int is_radiator_fan_abnormal;

    // B7[0:7] 57 - 64
    int is_cooling_water_olet_temp_sensor_abnormal;
    int is_cooling_water_ilet_temp_sensor_abnormal;
    int is_BMS_comm_abnormal;
    int is_PCU_comm_abnormal;
    int is_BCU_comm_abnormal;
    //
    //
    //

    // ALM_MSG_01
    // B0[0:7]  65 - 72
    // B1[0:7]  73 - 80
    // B2[0:7]  81 - 88
    // B3[0:7]  89 - 96
    // B4[0:7]  97 - 104
    // B5[0:7] 105 - 112
    // B6[0:7] 113 - 120
    // B7[0:7] 121 - 128

    // ALM_MSG_02
    // B0[0:7] 129 - 136
    // B1[0:7] 137 - 144
    // B2[0:7] 145 - 152
    // B3[0:7] 153 - 160
    // B4[0:7] 161 - 168
    // B5[0:7] 169 - 176
    // B6[0:7] 177 - 184
    // B7[0:7] 185 - 192

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
    int is_DCDC_under_o_voltage;
    int is_DCDC_over_o_voltage;
    int is_DCDC_under_i_voltage;
    int is_DCDC_over_i_voltage;
    int is_DCDC_hwfault;
    // B0[5] 262 TBD
    int is_DCDC_derating;
    int is_DCDC_over_i_current;

    // B1[0:7] 265 - 272
    int is_DCDC_over_temperature;
    int is_DCDC_over_o_current;

    // B2[0:7] 273 - 280
    // B3[0:7] 281 - 288
    // B4[0:7] 289 - 296
    // B5[0:7] 297 - 299
    // B6[0:7] TBD
    // B7[0:7] TBD

    // ALM_MSG_05 / BCU_ER_MSG01
    BATTERY_PACK_BITS packs[NUM_PACKS];
    int is_warning_high_voltage_diff_in_driving_stop_lvl1;
    int is_warning_low_SOC_in_driving_stop_lvl1;
    // B2[0:1] 502 - 503
    int is_warning_discharge_over_current_lvl1;
    int is_severe_charge_over_current_lvl2;
    // B3[0:7] 504 - 511
    int is_severe_CMU_comm_interrupt_in_BMS_lvl2;
    int is_severe_charge_ECU_comm_interrupt_in_BMS_lvl2;
    int is_warning_BMS_internal_error_lvl1;
    int is_severe_voltage_acquisition_error_in_BMS_lvl2;
    int is_severe_temp_acquisition_error_in_BMS_lvl2;
    int is_severe_charging_time_too_long_lvl2;
    int is_severe_charge_comm_error_lvl2;
    int is_warning_charge_comm_error_lvl1;
    // B4[0:5] 512 - 517
    int is_severe_low_insulation_resistance_charging_lvl2;
    int is_severe_low_insulation_resistance_driving_stop_lvl2;
    int is_warning_low_insulation_resistance_charging_lvl2;         //wrong level?
    int is_warning_low_insulation_resistance_driving_stop_lvl2;     //wrong level?
    // NOTE: there will be a impact on legacy model, to be confirmed
    int is_severe_high_voltage_interlock_loop_charging_lvl2;
    int is_severe_high_voltage_interlock_loop_driving_stop_lvl2;
    // B6[4:7] 518 - 521
    int is_warning_code_518;
    int is_warning_code_519;
    int is_warning_charger_ECU_error;
    int is_warning_BMS_error;

    // ALM_MSG_07 / PCU_ST_SYS_3
    // B0[0:7] 600 - 607
    int fault_1_generic_hardware_trip;
    int fault_2_hardware_overcurrent_phase_U;
    int fault_3_hardware_overcurrent_phase_V;
    int fault_4_hardware_overcurrent_phase_W;
    int fault_5_DC_link_overvoltage_hardware_trip;
    int fault_6;
    int fault_7;
    int fault_8;
    // B1[0:7] 608 - 615
    int fault_9_shoot_through;
    int fault_10_short_circuit_phse_U_top_switch;
    int fault_11_short_circuit_phse_U_bottom_switch;
    int fault_12_short_circuit_phse_V_top_switch;
    int fault_13_short_circuit_phse_V_bottom_switch;
    int fault_14_short_circuit_phse_W_top_switch;
    int fault_15_short_circuit_phse_W_bottom_switch;
    int fault_16_isolated_power_supply_alarm;
    // B2[0:7] 616 - 623
    int fault_17_gate_driver_power_supply_fault_phse_U_top_switch;
    int fault_18_gate_driver_power_supply_fault_phse_U_bottom_switch;
    int fault_19_gate_driver_power_supply_fault_phse_V_top_switch;
    int fault_20_gate_driver_power_supply_fault_phse_V_bottom_switch;
    int fault_21_gate_driver_power_supply_fault_phse_W_top_switch;
    int fault_22_gate_driver_power_supply_fault_phse_W_bottom_switch;
    int fault_23_gate_driver_power_supply_fault_short_circuit_top_switches;
    int fault_24_gate_driver_power_supply_fault_short_circuit_bottom_switches;
    // B3[0:7] 624 - 631
    int fault_25_stop_signal_1_alarm;
    int fault_26_stop_signal_2_alarm;
    int fault_27_overcurrent_software_trip;
    int fault_28_overvoltage_software_trip;
    int fault_29_undervoltage_software_trip;
    int fault_30_overspeed;
    int fault_31_PMSM_DC_link_voltage_safe_speed_exceeded;
    int fault_32;
    // B4[0:7] 632 - 639
    int fault_33;
    int fault_34_inverter_power_stage_overheat_measurement;
    int fault_35;
    int fault_36_application_fault;
    int fault_37_watchdog_timeout;
    int fault_38_parameter_system_failure;
    int fault_39_internal_software_faults_and_warnings;
    int fault_40;
    // B5[0:7] 640 - 647
    int fault_41;
    int fault_42;
    int fault_43;
    int fault_44;
    int fault_45;
    int fault_46_background_starved;
    int fault_47;
    int fault_48;
    // B6[0:7] 648 - 655
    int fault_49;
    int fault_50;
    int fault_51_power_supply_undervoltage;
    int fault_52;
    int fault_53;
    int fault_54;
    int fault_55;
    int fault_56;
    // B7[0:7] 656 - 663
    int fault_57_external_temperature_measurement_fault;
    int fault_58_inverter_power_stage_overheat;
    int fault_59_event;
    int fault_60_enclosure_voltage_trip;
    int fault_61_overfrequency;
    int fault_62_earth_fault;
    int fault_63_phase_U_loss;
    int fault_64_phase_V_loss;

    // ALM_MSG_08 / PCU_ST_SYS_4
    // B0[0:7] 664 - 671
    int fault_65_phase_W_loss;
    int fault_66;
    int fault_67;
    int fault_68;
    int fault_69;
    int fault_70;
    int fault_71;
    int fault_72;
    // B1[0:7] 672 - 679
    int fault_73;
    int fault_74;
    int fault_75;
    int fault_76;
    int fault_77;
    int fault_78;
    int fault_79;
    int fault_80;
    // B2[0:7] 680 - 687
    int fault_81;
    int fault_82;
    int fault_83;
    int fault_84;
    int fault_85;
    int fault_86_parallel_communication_faul_PowerMASTER_parallel;
    int fault_87_parallel_slave_faul_PowerMASTER_parallel;
    int fault_88;
    // B3[0:7] 688 - 695
    int fault_89_resolver_error;
    int fault_90;
    int fault_91;
    int fault_92;
    int fault_93;
    int fault_94;
    int fault_95;
    int fault_96;

    // TODO: align to 1113 file

    uint8_t charger_enable; // B7.[67]
    uint8_t charging_state; // BVM04,B0[0-7]***

    uint32_t vehicle_state; // off, idle, discharge, charge


    double m_fSlope; // slope of vehicle
    double inclination;
    float longitude;
    std::string dir_longitude;
    float latitude;
    std::string dir_latitude;
    float altitude;
    float gps_mileage;
    float odo;
    float v24;
    float dtc;

    // BMS_VCU_MSG02
    float cell_maxv;
    int cell_maxi;
    float cell_minv;
    int cell_mini;

    int max_pt_temp;
    int max_pt_idx;
    unsigned int charger_cc2; // TODO: check if all merged to bms_cc2
    double cellVoltages[NUM_PACKS][NUM_CELLS];

    int itank_temp1;
    int otank_temp2;
    int motor_temp;
    int cellTemperatures[NUM_PACKS][NUM_TPROBE];

    int torq;
    int gear;
    int abs_alarm,fl_lining,fr_lining,rl_lining,
	rr_lining,ecas33f,ecas34w;
    int smoke_detect[8];

    unsigned int vcu_io[8]; // TODO:
    unsigned int pcu_io[8]; // TODO:
    int brake, pedal, pedal_depth;
    int main_dvr_rt,main_mt_rt;
    int penumatic_dvr_rt,penumatic_mt_rt;
    int hyd_rt,hym_rt;
    uint8_t key_position;
    float outdoor_temperature;
    int ac_switch;
    // msg1 b0
    int left_turn,right_turn,head_light,side_light,hazard_light,door_open;
    int rear_defogger_light,access_light;
    // msg1 b1
    int ecas_kneeling,rear_fog_light,alarm_getoff;
    int motor_overrun,regen_brake,parking,motor_op;
    // msg1 b2
    int abs,ecas_warn,lining,emergency_exit;
    // msg1 b3
    int motor_alarm,air_alarm,psteering_alarm,mpower_alarm;
    // msg1 b4
    int v24_alarm,lv_alarm,charge_abort,wiper,lb_light; //brake,
    // msg1 b5
    // msg1 b[6:7]
    int reading, speed;
    int total,trip;
    float mx_allowed_chg_voltage,mx_allowed_chg_current;
    unsigned int chg_time_left_mins,num_chg_times; // charger_ctrl_cmds is 'charger_enable'

    // last frame of each address
    // Collection Classes ( https://goo.gl/dJR3sG )
    // tutorial
    // QHash provides faster lookups ( https://goo.gl/NqRQ2B )
    // except voltage, T1-T4...
    QHash<quint32, QCanBusFrame> cached_frame;
    // QHash keep BAM (index, frame) instead of (frame id, frame)
    // QHash<quint32, QCanBusFrame> cached_cell_voltage;
    // QHash<quint32, QCanBusFrame> cached_probe_temperature; // TODO: to be obselete
    uint8_t probe_temperature[NUM_PRB_T]; // num bytes ( linear )
    // guard temperature
    QMutex m_TemperatureMutex; // testing

    // QMutex m_CellVoltageMutex;
    // TODO:
    uint8_t cell_voltage[NUM_PACKS*NUM_CELLS*BYTES_VOLT]; // linear, from frame
    int addSpeedMAFilter(uint32_t speed);

#if defined ( EN_DEVELOP_DATA_ )
    void setupDataVolt();
    void setupDataTemperature();
#endif

// protected: is not feasible
#if 1
    // should be match with QCanBusFrame handler
    // why not set at frame parser such that
    // handler got zero length?
    // FIXME:
    QCanBusFrame FrameVCU_HMI_MSG01;
    QCanBusFrame FrameVCU_HMI_MSG02;
    QCanBusFrame FrameVCU_HMI_MSG03;
    QCanBusFrame FrameVCU_HMI_MSG04;
    QCanBusFrame FrameBMS_VCU_MSG01;
    QCanBusFrame FrameBMS_VCU_MSG02;
    QCanBusFrame FrameBMS_VCU_MSG03;
    QCanBusFrame FrameBMS_VCU_MSG04;
    QCanBusFrame FrameBMS_OBC_MSG01;
    QCanBusFrame FramePCU_IO_SIG00;
    QCanBusFrame FrameBCU_VCU_MSG0;
    QCanBusFrame FrameBCU_VCU_SMD;
    QCanBusFrame FrameBCU_ER_MSG01;
    QCanBusFrame FrameBMS_CMUERR_MSG01;
    QCanBusFrame FrameTPMS_MSG01;
    QCanBusFrame FrameTPMS_MSG02;
    QCanBusFrame FrameVCU_IOSIG_MSG;
    QCanBusFrame FrameVCU_PWR_STATUS;
    QCanBusFrame FramePCU_ST_SYS_1;
    QCanBusFrame FramePCU_ST_SYS_2;
    QCanBusFrame FramePCU_ST_SYS_3;
    QCanBusFrame FramePCU_ST_SYS_4;
    QCanBusFrame FramePCU_ST_MOT_1;
    QCanBusFrame FramePCU_ST_MOT_2;
    QCanBusFrame FramePCU_ST_MOT_3;
    QCanBusFrame FramePCU_CMD_SYS_1;
    QCanBusFrame FramePCU_CMD_MOT_1;
    QCanBusFrame FramePCU_CMD_MOT_2;
    QCanBusFrame FramePCU_CMD_MOT_3;
    QCanBusFrame FramePCU_CMD_SYS_3;
    QCanBusFrame FrameVCU_DIAG01;
    QCanBusFrame FrameVCU_DIAG02;
    QCanBusFrame FrameVCU_DMRT_CLR;  // HMI -> VCU
    QCanBusFrame FrameVCU_FN_DISABLE;// HMI -> VCU
    QCanBusFrame FrameDCDC_MSG00;

    QCanBusFrame FrameALM_MSG_00;
    QCanBusFrame FrameALM_MSG_01;
    QCanBusFrame FrameALM_MSG_02;
    QCanBusFrame FrameALM_MSG_03;
#endif

public:
    GSensorWrapper* m_pGSensor;
    IOWrapper* m_pIOWrapper;

    // Alarm subsystem related implementation
    uint8_t m_AlarmTrigger[NUM_BYTE_ALARM*NUM_ALARM_ID];
    uint8_t m_Alarm[NUM_BYTE_ALARM*NUM_ALARM_ID];
    // The C++ language gives you a way to find out
    // how many bits are in a byte in your particular implementation
    // ref: ( https://isocpp.org/wiki/faq/intrinsic-types )
    // ALARM_PARAMETER* m_AlarmParameters[NUM_BYTE_ALARM*NUM_ALARM_ID*CHAR_BIT];
    // TODO: required to change dynamically according to
    // locale change
    // treat whole alarm parameters as a single object
    // use AlarmParameters

    // TODO: marquee display option in parameter HMI
    // assume there is one bit to one alarm
    void handleAlarmBits(
	int alarmIndex, int byteIndex,
	QByteArray prevPayload, QByteArray currentPayload,
	int* pBit0, int* pBit1, int* pBit2, int* pBit3,
	int* pBit4, int* pBit5, int* pBit6, int* pBit7 );

    // 2 bits version, bit and flag bit
    // assume there is only one bit flag for the whole bits
    // and within the same byte
#if 0
    void handleAlarmBitsWithFlag(
	int alarmIndex, int byteIndex,
	int flagByte, int flagBit,
	QByteArray prevPayload, QByteArray currentPayload,
	int* pBit0, int* pBit1, int* pBit2, int* pBit3,
	int* pBit4, int* pBit5, int* pBit6, int* pBit7 );
#endif
    // TODO: obselete the above

    // revised for battery pack bits exclusively
    void handleAlarmPackBits(int index,
	QByteArray prevPayload, QByteArray currentPayload);
    void displayAlarmBits(void);
    uint m_unlockBits;
    getAlarmText(QString locale, int alarmIndex, int byteIndex, int bitIndex);

public slots:
    void onLogVehicleInfo(void);
    void onClickAlarmRectangle(QString cmd, int number);

private:
    ofstream m_file;
};

#endif // INFO_H
