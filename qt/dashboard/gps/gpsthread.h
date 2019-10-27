#ifndef GPSTHREAD_H
#define GPSTHREAD_H

#include <QThread>

#include "racev.h"
#include "gpswrapper.h"

class GPSThread : public QThread
{
    Q_OBJECT
public:
    GPSThread();
    GPSThread(Racev* pRacev);
    ~GPSThread() override;

signals:

protected:

private:
    void run() override;
    Racev* m_pRacev;
};

#endif // GPSTHREAD_H
