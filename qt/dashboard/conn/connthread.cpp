#include <QTimer>
#include <QDateTime>
#include <QDebug>
#include <QMutex>
#include <QWaitCondition>

#include "connthread.h"
#include "racev.h"

ConnThread::ConnThread()
{
    //qDebug() << "ConnThread+";
    //m_tick = 0;
}

ConnThread::ConnThread(Racev* racev): m_op(0), m_pRacev(racev)
{
    qDebug() << "ConnThread+";
    //m_op = 0;
    //m_pRacev = racev;
}

ConnThread::~ConnThread()
{
    qDebug() << "ConnThread-";
}

void ConnThread::run()
{
    //int rc = 0;
    //QDateTime current_dt;
    //qint64 ts = current_dt.currentSecsSinceEpoch();

    QMutexLocker locker(&m_pRacev->m_mutex);
    //qDebug() << "ConnThread::run +" << thread()->currentThreadId();
    //while ( !this->isInterruptionRequested() ) {
    while ( !QThread::currentThread()->isInterruptionRequested()
            /* readRequests.isEmpty() && writeRequests.isEmpty() && !startVerification */) {
        //qDebug() << "ConnThread wait...";
        // Go to sleep if there's nothing to do.
        //m_cond.wait(&m_mutex, 1000);
        m_pRacev->m_cond.wait(&m_pRacev->m_mutex);
        // Check 4G conn. If not start then trying,
        qDebug() << "check 4G conn" << m_op++;
        //rc = 0;
#if 0
        if ( 20 < m_tick ) {
            requestInterruption();
        }
#endif
    }
    qDebug() << "ConnThread::run -";
}
