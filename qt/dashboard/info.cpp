#include <ctime>
#include <iostream>
#include <iomanip>

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
    m_speed(0),m_speedMA{0,0,0},m_speedMAIndex(0),
    rpm_unit("rpm"), // gear("5"),
    rpm(0), turnIndicator(0), milage(0), milage_left(0.0f),
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
    is_charging_in_progress(0),charger_enable(0),
    charging_state(0),
    vehicle_state(0), m_fSlope(0.0f), inclination(0.0f),
    longitude(0.0f),dir_longitude(""),
    latitude(0.0f),dir_latitude(""),
    altitude(0.0f),
    gps_mileage(0.0f),
    odo(0.0f),v24(0.0f),dtc(0.0f),
    cell_maxv(0),cell_maxi(0),cell_minv(0),cell_mini(0),
    max_pt_temp(0),max_pt_idx(0),charger_cc2(0),
    cellVoltages({{0},{0}}),
    itank_temp1(0),otank_temp2(0),motor_temp(0),
    cellTemperatures({{0},{0}}),torq(0),gear(0),
    abs_alarm(0),fl_lining(0),fr_lining(0),rl_lining(0),
    rr_lining(0),ecas33f(0),ecas34w(0), // ecas_kneeling(0),
    smoke_detect({0}),vcu_io({0}),pcu_io({0}),brake(0),
    pedal(0),pedal_depth(0),main_dvr_rt(0),main_mt_rt(0),
    penumatic_dvr_rt(0),penumatic_mt_rt(0),
    hyd_rt(0),hym_rt(0),
    key_position(KEY_OFF),
    outdoor_temperature(0.0f),ac_switch(0),
    probe_temperature({0}),cell_voltage({0}),
    // msg1 b0
    left_turn(0),right_turn(0),head_light(0),side_light(0),hazard_light(0),
    door_open(0),rear_defogger_light(0),access_light(0),
    // msg1 b1
    ecas_kneeling(0),rear_fog_light(0),alarm_getoff(0),
    motor_overrun(0),regen_brake(0),parking(0),motor_op(0),
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
    m_pGSensor(nullptr),
    m_pIOWrapper(nullptr)
{
#if defined ( QT_DEBUG )
    cout << __func__ <<":"<< __LINE__ << "+" << endl;
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
    cout << __func__ << ":" << __LINE__ << " + " << endl;
#endif
    std::time_t time_sec_now = std::time(nullptr);
    tstruct = *localtime(&time_sec_now);
    strftime(fpath, sizeof(fpath),
	"/home/racev/dashboard.d/vir/%Y-%m-%d-%H-00-00.csv", &tstruct);
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
    return;
}

