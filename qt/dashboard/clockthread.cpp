#include <iostream>

#include <QDateTime>
#include <QProcess>
#include <QDebug>
#include <QTimer>

#include "clockthread.h"
#include "cpu_util/CPUSnapshot.h"

using namespace std;

//#define TICK_CPU_ // takes time, don't do this
//#define TICK_MEMORY_
//#define UPDATE_CLOCK_BY_THREAD_

// clock thread is to respond model change every second
ClockThread::ClockThread()
{
    //qDebug() << "ClockThread+";
}

ClockThread::ClockThread(Racev* racev):
    m_pRacev(racev)
{
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " + " << endl;
#endif
    // m_pTimer = new QTimer(this);
}

ClockThread::~ClockThread()
{
    //qDebug() << "ClockThread-";
    // m_pTimer is deleted by 'parent'
}

void ClockThread::timerHit()
{
#if 0
    cout << __FILE__ << ":" << __func__ << ":" << __LINE__ << endl;
#endif
    m_pRacev->m_iTicks2Sec++; m_pRacev->m_iTicks5Sec++;
    m_pRacev->m_iTicks10Sec++; m_pRacev->m_iTicks20Sec++;
    m_pRacev->m_iTicks30Sec++; m_pRacev->m_iTicks60Sec++;

#if defined ( TICK_CPU_ )
    CPUSnapshot previousSnap;
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    CPUSnapshot curSnap;
    const float ACTIVE_TIME = curSnap.GetActiveTimeTotal() - previousSnap.GetActiveTimeTotal();
    const float IDLE_TIME   = curSnap.GetIdleTimeTotal() - previousSnap.GetIdleTimeTotal();
    const float TOTAL_TIME  = ACTIVE_TIME + IDLE_TIME;
    int usage = static_cast<int>(100.f * ACTIVE_TIME / TOTAL_TIME);
#endif

#if defined ( TICK_MEMORY_ )
    // Interpreting /proc/meminfo and free output
    // for Red Hat Enterprise Linux 5, 6 and 7
    // (https://goo.gl/sgdNPX)
    QProcess p;
    // cat /proc/meminfo | grep MemAvailable
    // Interpreting /proc/meminfo and free output for Red Hat Enterprise Linux 5, 6 and 7
    // ( https://goo.gl/sgdNPX )
    // ( https://goo.gl/RckwnX )
    p.start("sh",QStringList() << "-c" << "awk '/MemAvailable/ { print $2/1024 }' /proc/meminfo");
    p.waitForFinished();
    //QString stderr = p.readAllStandardError();
    QString memory = p.readAllStandardOutput(); // ( https://stackoverflow.com/a/40407837 )
    int freemem = static_cast<int>(memory.trimmed().toFloat()); // ( https://goo.gl/2PRBof )
    //qDebug() << "memory: " << freemem << "MB"; // ( https://goo.gl/jVDEdo )
    p.close();
#endif

#if defined ( UPDATE_CLOCK_BY_THREAD_ )
    // moving timer display to QML
    QString newTime= QDateTime::currentDateTime().toString("ddd MMMM d yy, hh:mm:ss");
    //qDebug() << "ClockThread::timerHit+" << newTime;
    if(m_lastTime != newTime ){
        m_lastTime = newTime;
        emit sendTime(newTime, usage, freemem) ;
    }
#endif
    emit notifyUpdate();
    if ( 60 <= m_pRacev->m_iTicks60Sec ) {
	m_pRacev->m_iTicks60Sec = 0;
	emit signalTicksSec(60);
    }
    if ( 30 <= m_pRacev->m_iTicks30Sec ) {
	m_pRacev->m_iTicks30Sec = 0;
	emit signalTicksSec(30);
    }
    if ( 20 <= m_pRacev->m_iTicks20Sec ) {
	m_pRacev->m_iTicks20Sec = 0;
	emit signalTicksSec(20);
    }
    if ( 10 <= m_pRacev->m_iTicks10Sec ) {
	m_pRacev->m_iTicks10Sec = 0;
	emit signalTicksSec(10);
    }
    if ( 5 <= m_pRacev->m_iTicks5Sec ) {
	m_pRacev->m_iTicks5Sec = 0;
	emit signalTicksSec(5);
    }
    if ( 2 <= m_pRacev->m_iTicks2Sec ) {
	m_pRacev->m_iTicks2Sec = 0;
	emit signalTicksSec(2);
    }
    emit signalTicksSec(1);
}

void ClockThread::run() {
    // cout << __FILE__ << ":" << __LINE__
    // << " ClkThrd prio " << QThread::currentThread()->priority() << endl;

    // calling QThread.exec() method is necessary in QThread?
    // @see https://tinyurl.com/y2ml9krw
    exec();

    // call moveToThread(this) within the thread constructor
    // AND place an execution loop within the protected run() method
    // of your QThread derived class.
    // @see https://tinyurl.com/y5rb2yu9
#if 0
    while ( !QThread::currentThread()->isInterruptionRequested() ) {
	// cout << __func__ << ":" << __LINE__ << " gps ticking. " << endl;
	sleep(3);
    }
#endif
}
