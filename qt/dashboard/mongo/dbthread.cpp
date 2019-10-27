#include <QTimer>
#include <QDateTime>
#include <QDebug>
#include <QMutex>
#include <QWaitCondition>

#include "dbthread.h"
#include "racev.h"

#if defined ( MONGO_THREAD_ )

DbThread::DbThread()
{
    //qDebug() << "DbThread+";
    //m_tick = 0;
}

DbThread::DbThread(Racev* racev)
{
    qDebug() << "DbThread+";
    m_dbop = 0;
    m_pRacev = racev;
}

DbThread::~DbThread()
{
    qDebug() << "DbThread-";
}

void DbThread::run()
{
    int64_t rc;
    //QDateTime current_dt;
    //qint64 ts = current_dt.currentSecsSinceEpoch();

    QMutexLocker locker(&m_pRacev->m_mutex);
    //qDebug() << "DbThread::run +" << thread()->currentThreadId();
    //while ( !this->isInterruptionRequested() ) {
    while ( !QThread::currentThread()->isInterruptionRequested()
            /* readRequests.isEmpty() && writeRequests.isEmpty() && !startVerification */) {
        //qDebug() << "DbThread wait...";
        // Go to sleep if there's nothing to do.
        //m_cond.wait(&m_mutex, 1000);
        m_pRacev->m_cond.wait(&m_pRacev->m_mutex);
        //rc = m_pRacev->m_pMongo->create(m_pRacev->m_pInfo);
        std::string to_col = "car_0001"; //FIXME:
        rc = m_pRacev->m_pMongo->createDoc(m_pRacev->m_pInfo, to_col);
        if ( 0 != rc ) {}
        //ts = current_dt.currentSecsSinceEpoch();
        qDebug() << "DbThread::run op" << m_pRacev->m_pInfo->m_dbop++;
#if 0
        if ( 20 < m_tick ) {
            requestInterruption();
        }
#endif
    }
    qDebug() << "DbThread::run -";
}
#endif
