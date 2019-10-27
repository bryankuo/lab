#ifndef DBTHREAD_H
#define DBTHREAD_H

#include <QThread>

#include "racev.h"

class DbThread : public QThread
{
public:
    DbThread();
    DbThread(Racev* pRacev);
    ~DbThread() override;
    Q_OBJECT
signals:
    //void sendTime(QString time);
private:
    void run() override;
    qint64 m_dbop;
    Racev* m_pRacev;

private slots:
    //void timerHit();

};

#endif // DBTHREAD_H
