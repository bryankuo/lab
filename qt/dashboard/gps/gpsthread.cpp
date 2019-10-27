#include <iostream>     // std::cout, std::endl
#include <iomanip>      // std::setfill, std::setw

#include <QTimer>
#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QByteArray>
#include <QSerialPort>
#include <QProcess>
#include <QStringList>

#include "racev.h"
#include "worker.h"
#include "gpsthread.h"

GPSThread::GPSThread()
{
    cout << __func__ << ":" << __LINE__ << " + " << endl;
}

GPSThread::GPSThread(Racev* racev):
    m_pRacev(racev)
{
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " + " << endl;
#endif

}

GPSThread::~GPSThread()
{
   cout << "~GPSThread" << endl;
}

// ref: ( https://is.gd/jnVFc3 )
void GPSThread::run() {
#if  0 //defined ( QT_DEBUG )
    cout << typeid(*this).name() << "::"
	<< __func__ << ":" << __LINE__ << " + "
	<< m_pUART3->portName().toStdString() << endl;
#endif
    while ( !QThread::currentThread()->isInterruptionRequested() ) {
	// cout << __func__ << ":" << __LINE__ << " gps ticking. " << endl;
	sleep(5);
    }
    // reset module whenever program close ( provide port opened )
    msleep(200);
//ERROR_HANDLER:
    cout << __func__ << ":" << __LINE__ << " -" << endl;
}
