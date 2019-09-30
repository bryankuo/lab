#ifndef INFO_H
#define INFO_H

#include <cstdint>
#include <string>
#include <fstream>

#include <QObject>
#include <QCanBusFrame>
#include <QHash>
#include <QDebug>

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
#define HMI_Time_Msg // 0x18FF6811
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
#define BMS_OBC_Msg01 0x18FF98F4

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

#define ALM_MSG_00 0x18FF0422
#define ALM_MSG_01 0x18FF0522
#define ALM_MSG_02 0x18FF0622
#define ALM_MSG_03 0x18FF0722

// #define ALM_MSG_04 0x18FF5051 // DCDC_MSG00
// #define ALM_MSG_05 0x18FF93F4 // BCU_ER_MSG01
// #define ALM_MSG_06 0x18FF94F4 // BMS_CMUERR_MSG01
// #define ALM_MSG_07 0x14FF4326 // PCU_ST_SYS_3
// #define ALM_MSG_08 0x14FF4426 // PCU_ST_SYS_4

using namespace std;

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

    uint32_t bms_code;
    uint32_t vehicle_state; // off, idle, discharge, charge

    double m_fSlope; // slope of vehicle
    double inclination;
    float longitude;
    float latitude;
    float altitude;
    float gps_mileage;
    float odo;
    float v24;
    float dtc;
    float cell_maxv;
    int cell_maxi;
    float cell_minv;
    int cell_mini;
    int max_pt_temp;
    int max_pt_idx;
    double cellVoltages[NUM_PACKS][NUM_CELLS];
    int itank_temp1;
    int otank_temp2;
    int motor_temp;
    int cellTemperatures[NUM_PACKS][NUM_TPROBE];
    int torq;
    int gear;
    unsigned int abs_alarm,fl_lining,fr_lining,rl_lining,
	rr_lining,ecas33f,ecas_kneeling,ecas34w;
    unsigned int smoke_detect[8];

    unsigned int vcu_io[8]; // TODO:
    unsigned int pcu_io[8]; // TODO:
    int brake, pedal, pedal_depth;
    unsigned int main_dvr_rt,main_mt_rt;
    unsigned int penumatic_dvr_rt,penumatic_mt_rt;
    unsigned int hyd_rt,hym_rt;
    unsigned int prev_key_position;
    float outdoor_temperature;
    unsigned ac_switch;
    // msg1 b0
    int left_turn,right_turn,head_light,side_light,hazard_light,evacuation_light;
    int rear_defogger_light,access_light;
    // msg1 b1
    int ecas_kneeling,rear_fog_light,alarm_getoff;
    int motor_overrun,regen_brake,parking;
    int motor_op;
    // msg1 b2
    int abs,ecas_warn,lining,emergency_exit;
    // msg1 b3
    int motor_alarm,air_alarm,psteering_alarm,mpower_alarm;
    // msg1 b4
    int v24_alarm,lv_alarm,charge_abort,brake,wiper,lb_light;
    // msg1 b5
    // msg1 b[6:7]
    int reading, speed;
    // tutorial
    // QHash provides faster lookups ( https://goo.gl/NqRQ2B )
    // except voltage, T1-T4...
    QHash<quint32, QCanBusFrame> cached_frame;
    // QHash keep BAM (index, frame) instead of (frame id, frame)
    QHash<quint32, QCanBusFrame> cached_cell_voltage;
    QHash<quint32, QCanBusFrame> cached_probe_temperature;
    int addSpeedMAFilter(uint32_t speed);

#if defined ( EN_DEVELOP_DATA_ )
    void setupDataVolt();
    void setupDataTemperature();
#endif
// TODO: using protected:
    QCanBusFrame FrameVCU_HMI_MSG01;
    QCanBusFrame FrameVCU_HMI_MSG02;
    QCanBusFrame FrameVCU_HMI_MSG3;
    QCanBusFrame FrameVCU_HMI_MSG4;
    QCanBusFrame FrameBMS_VCU_MSG01;
    QCanBusFrame FrameBMS_VCU_MSG02;
    QCanBusFrame FrameBMS_VCU_MSG03;
    QCanBusFrame FrameBMS_VCU_MSG04;
    QCanBusFrame FrameBMS_OBC_Msg01;
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

    GSensorWrapper* m_pGSensor;
    IOWrapper* m_pIOWrapper;
public slots:
    void onLogVehicleInfo(void);
private:
    ofstream m_file;
};

#endif // INFO_H
