#ifndef TOOLS_H
#define TOOLS_H

#include <QObject>
#include <QThread>
#include <QDebug>
#include <QProcess>
#include <stdio.h>
#include <sys/types.h>

class Tools: public QObject
{
    Q_OBJECT
public:
//    Q_INVOKABLE int open_canbus_driver_permission();


public slots:
    void delay_usec(unsigned long usecs);
    void delay_msec(unsigned long msecs);
    void delay_sec(unsigned long secs);
};

#endif // TOOLS_H
