#include "tools.h"


void Tools::delay_usec(unsigned long usecs)
{
    //qDebug() << "delay " << usecs << " usecs";
    QThread::usleep(usecs);
}

void Tools::delay_msec(unsigned long msecs)
{
    //qDebug() << "delay " << msecs << " msecs";
    QThread::msleep(msecs);
}

void Tools::delay_sec(unsigned long secs)
{
    //qDebug() << "delay " << secs << " secs";
    QThread::sleep(secs);
}

//int Tools::open_canbus_driver_permission()
//{
    //QProcess *myprocess = new QProcess(this);

//    qDebug() << "open canbus driver permission";
    //QString program = "./run/sudo";
    //QString arguments =

    //myprocess->execute("sudo chmod 777 /dev/NEXCOM_CAN1");
//    system("sudo chmod 777 /dev/NEXCOM_CAN1");
    //if(!process.waitForStarted())
    //    return 0;
    
    //qDebug() << "finished:" << process.waitForFinished();;
    //qDebug() << "wait ready:" << process->waitForReadyRead();
    //qDebug() << "wait finished:" << process->waitForFinished();
    //qDebug() << "error:" << QProcess::readAllStandardError();
    //qDebug() << "output:" << QProcess::readAllStandardOutput();
//    return 1;
//}
