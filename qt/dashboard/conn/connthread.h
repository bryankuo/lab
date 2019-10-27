#ifndef CONNTHREAD_H
#define CONNTHREAD_H

#include <QThread>

#include "racev.h"

class ConnThread : public QThread
{
public:
    ConnThread();
    ConnThread(Racev* pRacev);
    ~ConnThread() override;
    Q_OBJECT
signals:
    //void sendTime(QString time);
private:
    void run() override;
    qint64 m_op;
    Racev* m_pRacev;

private slots:
    //void timerHit();

};

#endif // CONNTHREAD_H
