#ifndef CLOCKTHREAD_H
#define CLOCKTHREAD_H

#include <QThread>
#include <QTimer>

#include "racev.h"
#include "cpu_util/CPUSnapshot.h"

class ClockThread : public QThread
{
    Q_OBJECT
public:
    ClockThread();
    ClockThread(Racev* pRacev);
    ~ClockThread();
signals:
    void sendTime(QString time, int cpu_usage, int freemem);
    void notifyUpdate(void);
    void signalTicksSec(unsigned int n_seconds);

private slots:
    void timerHit();
private:
    void run();
    QString m_lastTime;
    Racev* m_pRacev;
    // QTimer* m_pTimer;
};

#endif // CLOCKTHREAD_H
