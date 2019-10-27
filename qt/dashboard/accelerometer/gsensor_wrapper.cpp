#include <iostream>
#include <iomanip>
#include <math.h> // atan2 @see https://tinyurl.com/pfgh6ed
#include <unistd.h>

// #include <QProcessEnvironment>
#include <QSettings>

#include "constants.h"
#include "gsensor_wrapper.h"

// Calling C Code from C++ With ‘extern “C”‘
// @see https://tinyurl.com/y5laphtq

using namespace std;

const std::string GSensorWrapper::DeviceFileName("/dev/NEXCOM_SMBus");

#define X_OFFSET_REG (0x1E)
#define Y_OFFSET_REG (0x1F)
#define Z_OFFSET_REG (0x20)
#define PWR_CTRL_REG (0x2D)
#define INT_ENAB_REG (0x2E)
#define DATA_FMT_REG (0x31)

#define DATAX0   0x32
#define DATAX1   0x33
#define DATAY0   0x34
#define DATAY1   0x35
#define DATAZ0   0x36
#define DATAZ1   0x37

GSensorWrapper::GSensorWrapper():m_fhGSensor(0),m_xg(0),m_yg(0),m_zg(0)
#if defined ( EN_XYZ_LOG_ )
    , m_filename("/home/racev/dashboard.d/logs/gsensor-cap.txt")
#endif
{
#if 0 // defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " +"
	<< endl;
#endif

#if defined ( EN_XYZ_LOG_ )
    m_file.setFileName(m_filename);
    if ( false == m_file.open(QIODevice::ReadWrite | QIODevice::Append) ) {
        cout << __FILE__ << ":" << __LINE__
	    << " make sure gsensor device is ready!" << endl;
    }
    m_stream.setDevice(&m_file);
#endif

    // @see https://tinyurl.com/y59dx7el
    m_fhGSensor = open(GSensorWrapper::DeviceFileName.c_str(), O_RDWR);
    if ( m_fhGSensor <= 0 ) {
	std::cout << __LINE__ << ": " <<
	    "NEXCOM_SMBus driver cannot be opened!" << std::endl;
    }
    InitAccelerometer(m_fhGSensor);
    //int rc = G_Sensor_Write(X_OFFSET_REG , 0xFF, m_fhGSensor);
    //rc = G_Sensor_Write(Y_OFFSET_REG , 0xFB, m_fhGSensor);
    //rc = G_Sensor_Write(Z_OFFSET_REG , 0xFF, m_fhGSensor);
    // 13 bit full resolution, +/-16g
    G_Sensor_Write(DATA_FMT_REG, 0x0B, m_fhGSensor);
}

GSensorWrapper::~GSensorWrapper()
{
#if defined( EN_CANTHREAD_FRAME_LOG_ )
    m_file.close();
#endif
    close(m_fhGSensor);
}

/*
 * output pitch/roll/yaw in percentage
 * output unit: m/s^2
 */
int GSensorWrapper::Get(double *pfXg, double *pfYg, double *pfZg,
	double *pfSlope/*aka pfPitch*/, double *pfRoll) {
    int rc = 0;
// #define PRINT_XYX_
#if defined( PRINT_XYX )
    int px, py, pz;
#endif
    // double fSlope1, fSlope2;
    double fSlope3;
#define EN_2BYTE_DATA_
#if defined ( EN_2BYTE_DATA_ )
    uint16_t ux, uy, uz;
    int x, x0, x1; double gx;
    int y, y0, y1; double gy;
    int z, z0, z1; double gz;
#endif

#if 0 // defined ( QT_DEBUG )
    cout <<
	__FILE__ << ":"<< __LINE__ << " + " << endl;
#endif

    // rc = G_Sensor_3_Axis(&px, &py, &pz, m_fhGSensor);
#if defined ( EN_2BYTE_DATA_ )
    // rc = G_Sensor_X_AxisEx(&x0, &x1, m_fhGSensor);
    rc = G_Sensor_Read(DATAX0, &x0, m_fhGSensor);
    rc = G_Sensor_Read(DATAX1, &x1, m_fhGSensor);
    rc = G_Sensor_Read(DATAY0, &y0, m_fhGSensor);
    rc = G_Sensor_Read(DATAY1, &y1, m_fhGSensor);
    rc = G_Sensor_Read(DATAZ0, &z0, m_fhGSensor);
    rc = G_Sensor_Read(DATAZ1, &z1, m_fhGSensor);

    // @see AN-1077 page 4
    // @see https://tinyurl.com/y3gqs58f
    ux  = ((x1 << 8) + x0); x = static_cast<int16_t>(ux);
    gx = static_cast<double>(x)
	* static_cast<double>(FACTOR_ACCELEROMETER_RESOLUTION);
    uy  = ((y1 << 8) + y0); y = static_cast<int16_t>(uy);
    gy = static_cast<double>(y)
	* static_cast<double>(FACTOR_ACCELEROMETER_RESOLUTION);
    uz  = ((z1 << 8) + z0); z = static_cast<int16_t>(uz);
    gz = static_cast<double>(z)
	* static_cast<double>(FACTOR_ACCELEROMETER_RESOLUTION);
#endif

    // a simple low pass filter (LPF)
#if defined ( EN_LPF_ )
    // @see Accelerometers https://tinyurl.com/y4xw3dxh
    // Scale = (16*2)/2^13 @see https://tinyurl.com/yycr7dp4
    *pfXg = (*pfXg) * ALPHA + (m_xg * (1.0-ALPHA));
    m_xg = *pfXg;
    *pfYg = (*pfYg) * ALPHA + (m_yg * (1.0-ALPHA));
    m_yg = *pfYg;
    *pfZg = (*pfZg) * ALPHA + (m_zg * (1.0-ALPHA));
    m_zg = *pfZg;
#endif

    // mG/LSB to m/s^2
    *pfXg = (gx) * GRAVITY_CONSTANT ;
    *pfYg = (gy) * GRAVITY_CONSTANT ;
    *pfZg = (gz) * GRAVITY_CONSTANT ;


#if defined ( PRINT_XYX_ )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " x: " << setfill('0') << setw(3) << px
	    << " " << setprecision (2) << fixed << *pfXg
	<< " y: " << setfill('0') << setw(3) << py
	    << " " << setprecision (2) << fixed << *pfYg
	<< " z: " << setfill('0') << setw(3) << pz
	    << " " << setprecision (2) << fixed << *pfZg
	<< endl;
#endif

#if 0 // print EN_2BYTE_DATA_
    cout << __func__ <<":"<< __LINE__
	<< "x: "
	    << std::hex << "0x" << setfill('0') << setw(2) << x1 << setfill('0') << setw(2) << x0
	    << " " << std::dec << setw(6) << setprecision (3) << fixed << *pfXg << " "
	<< "y: "
	    << std::hex << "0x" << setfill('0') << setw(2) << y1 << setfill('0') << setw(2) << y0
	    << " " << std::dec << setw(6) << setprecision (3) << fixed << *pfYg << " "
	<< "z: "
	    << std::hex << "0x" << setfill('0') << setw(2) << z1 << setfill('0') << setw(2) << z0
	    << " " << std::dec << setw(6) << setprecision (3) << fixed << *pfZg << endl;
#endif

    // guarding condition, moving to top?
#if 1
    if ( gx < -1 ) gx = -1;
    if ( 1 < gx )  gx =  1;
    if ( gy < -1 ) gy = -1;
    if ( 1 < gy )  gy =  1;
    if ( gz < -1 ) gz = -1;
    if ( 1 < gz )  gz =  1;
#endif

    // @see https://tinyurl.com/yxnrzaj4
    // 1-Axis in degree
    // @see https://tinyurl.com/y29jo2ve
    // fSlope1 = asin(gx) * (180.0/PI);

    // 2-Axis in degree
    // fSlope2 = atan(gx/gz) * (180.0/PI);

    // 3-Axis in %
    // fSlope3 =
    //	atan2(gx, sqrt(gy*gy+gz*gz)) * (180.0/PI);
    // % slope= tangent (angle in radians)*100
    // @see https://tinyurl.com/y3qsvxqj
    fSlope3 =
	tan( atan2(gx, sqrt(gy*gy+gz*gz)) ) * 100;
    if ( fSlope3 < LLIMIT_SLOPE_PERCENT ) {
	fSlope3 = LLIMIT_SLOPE_PERCENT;
    }
    if ( ULIMIT_SLOPE_PERCENT < fSlope3 ) {
	fSlope3 = ULIMIT_SLOPE_PERCENT;
    }
    // to verify: calculate to slope
    // @see https://tinyurl.com/llga76u
#if defined ( COMPARE_3_TYPES )
    // @see std::setw(7) https://tinyurl.com/y2cgp9ne
    cout << __func__ <<":"<< __LINE__ << " slope(%): "
	<< "1: " << std::setw(5) << setprecision(1) << fixed << fSlope1 << " "
	<< "2: " << std::setw(5) << setprecision(1) << fixed << fSlope2 << " "
	<< "3: " << std::setw(5) << setprecision(1) << fixed << fSlope3
	<< endl;
#endif
    *pfSlope = fSlope3;

#if defined ( EN_XYZ_LOG_ )
    m_stream << QDateTime::currentMSecsSinceEpoch() << ","
	<< QString::number(fSlope3, 'f', 3) << ","
	<< QString::number(*pfXg, 'f', 3) << ","
	<< QString::number(*pfYg, 'f', 3) << ","
	<< QString::number(*pfZg, 'f', 3) << '\n';
    m_stream.flush();
#endif

    // TODO: calibrate to zero, zero position, raw, yaw
    // *pfRoll = ( ( *pfRoll ) / 360 ) * 100;
    return rc;
}

/*
 * @see https://tinyurl.com/y4xw3dxh
 */
void GSensorWrapper::Calibrate(bool doIt) {
#define NUM_SAMPLES 100
    int samples[3][NUM_SAMPLES] = {{0},{0},{0}}; // x,y,z
    int sub_total[3] = {0}, avg[3] = {0}, cali[3] = {0};
    int i, rc;

#if defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " + " << doIt
	<< endl;
#endif
    // @see AN-1077
    if ( true == doIt ) {
	usleep(1);
	// initialize command sequence
	rc = G_Sensor_Write(DATA_FMT_REG , 0x0B, m_fhGSensor);
	rc = G_Sensor_Write(PWR_CTRL_REG , 0x08, m_fhGSensor);
	rc = G_Sensor_Write(INT_ENAB_REG , 0x80, m_fhGSensor);
	usleep(12);
	for ( i = 0; i < NUM_SAMPLES; i++ ) {
	    rc = G_Sensor_3_Axis(
		&samples[0][i], &samples[1][i], &samples[2][i],
		m_fhGSensor);
#if 0
	    cout <<
		typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
		<< " sample " << setfill('0') << setw(3) << i
		<< " " << setfill('0') << setw(4) << samples[0][i]
		<< " " << setfill('0') << setw(4) << samples[1][i]
		<< " " << setfill('0') << setw(4) << samples[2][i]
		<< endl;
#endif
	    sub_total[0] += samples[0][i];
	    sub_total[1] += samples[1][i];
	    sub_total[2] += samples[2][i];
	}
	avg[0] = sub_total[0]/NUM_SAMPLES;
	avg[1] = sub_total[1]/NUM_SAMPLES;
	avg[2] = sub_total[2]/NUM_SAMPLES;
#if 0 // defined ( QT_DEBUG )
	cout <<
	    typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	    << " avg:"
	    << " " << setfill('0') << setw(4) << avg[0]
	    << " " << setfill('0') << setw(4) << avg[1]
	    << " " << setfill('0') << setw(4) << avg[2]
	    << endl;
#endif
	cali[0] = 0 - (avg[0]/4);
	cali[1] = 0 - (avg[1]/4);
	cali[2] = 0 - (avg[2]/4); // why minus 256?
#if 0 // defined ( QT_DEBUG )
	cout <<
	    typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	    << " calib:"
	    << std::hex << " 0x" << setfill('0') << setw(2) << cali[0]
	    << std::hex << " 0x" << setfill('0') << setw(2) << cali[1]
	    << std::hex << " 0x" << setfill('0') << setw(2) << cali[2]
	    << std::dec
	    << endl;
#endif
	// FIXME:
// #define WRITE_BACK_
#if defined ( WRITE_BACK_ )
	rc = G_Sensor_Write(X_OFFSET_REG , cali[0], m_fhGSensor);
	rc = G_Sensor_Write(Y_OFFSET_REG , cali[1], m_fhGSensor);
	rc = G_Sensor_Write(Z_OFFSET_REG , cali[2], m_fhGSensor);
	// TODO: serialize to 'ENVIRONMENT variable' or 'configuration file'?
#if 0	// FIXME:
	// qgetenv() @see https://tinyurl.com/y2xel64m
	// you can use QProcessEnvironment, for Qt versions of at least 4.6.
	// @see https://tinyurl.com/yxds25z3
	env = QProcessEnvironment::systemEnvironment();
	env.insert("X_CLIB", QString::number(cali[0]&0xFF));
	env.insert("Y_CLIB", QString::number(cali[1]&0xFF));
	env.insert("Z_CLIB", QString::number(cali[2]&0xFF));
	process.setProcessEnvironment(env);
	// or QSettings?
	// QSettings settings(m_sSettingsFile, QSettings::NativeFormat);
	// QString sText = settings.value("text", "").toString();
#endif
	// @see https://tinyurl.com/y3hgq6hg
	// @see https://tinyurl.com/y6kaqtph
	// TODO: passing racev.m_arguments.args[2] as member
	QSettings mySettings(
	    QString("/home/racev/dashboard.d/dashboard.cfg"),
	    /*QSettings::IniFormat*/QSettings::NativeFormat);
	mySettings.setValue("X_CLIB", QString::number(cali[0]&0xFF));
	mySettings.setValue("Y_CLIB", QString::number(cali[1]&0xFF, 16 ));
	mySettings.setValue("Z_CLIB",
	    "0x" + QString::number(cali[2]&0xFF,16).toUpper());
#if 0
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " - " << doIt
	<< endl;
#endif
#endif
    }
}

void GSensorWrapper::Zero(bool doIt) {
}
