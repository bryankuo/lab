#ifndef GSENSOR_WRAPPER_H
#define GSENSOR_WRAPPER_H

#define EN_XYZ_LOG_
#if defined ( EN_XYZ_LOG_ )
#include <QFile>
#include <QTextStream>
#include <QDateTime>
#endif

#include "G-sensor.h"

class GSensorWrapper
{
public:
    GSensorWrapper();
    ~GSensorWrapper();
    int Get(double *pfXg, double *pfYg, double *pfZg,
	double *pfSlope/*aka pfPitch*/, double *pfRoll);
    void Calibrate(bool doIt);
    void Zero(bool doIt);
#if defined ( EN_XYZ_LOG_ )
    QString m_filename;
    QFile m_file;
    QTextStream m_stream;
#endif

    // define constant filename
    // QString ap_filename = m_arguments.alarm_parameter_file;
private:
    static const std::string DeviceFileName;
    int m_fhGSensor;
    // LPF implementation
    // @see https://tinyurl.com/y4xw3dxh
    int m_xg;
    int m_yg;
    int m_zg;
};

#endif // GSENSOR_WRAPPER_H
