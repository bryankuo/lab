#ifndef SJA1000_API_H
#define SJA1000_API_H

#include <QObject>
#include <QCanBusFrame>
#include <QDebug>

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>

#include "racev.h"
#include "racev.h"
#include "can/sja1000_can.h"
#include "can/tools.h"

#if 1
#define ACR_ID 0x08E80020
#define AMR_ID 0x1417FFD6
#else
#define ACR_ID 0x18FF90F4
#define AMR_ID 0x00000500
#endif

//#define EN_SJA1000_FRAME_LOG_

class SJA1000_Api : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(void stop READ stop)
//    Q_PROPERTY(void receive_message READ receive_message)
//    Q_PROPERTY(int can_run READ can_run)
//    Q_PROPERTY(QString can_data1_value READ can_data1_value)
//    Q_PROPERTY(QString can_data2_value READ can_data2_value)
//    Q_PROPERTY(QString get_can_value READ get_can_value NOTIFY get_can_value)

public:
    SJA1000_Api();
    SJA1000_Api(QObject* pParent);
    ~SJA1000_Api() override;

    //Q_INVOKABLE void start(int fh);
    Q_INVOKABLE void stop();
    Q_INVOKABLE int can_run();
    Q_INVOKABLE int can_run(int* pfh);
    Q_INVOKABLE void receive_message();
    int receive_frame_nonblock(QCanBusFrame &frame);
    Q_INVOKABLE QString get_can_value(QString str);
    //Q_INVOKABLE QString can_data2_value();
//    void stop();
//    void receive_message();
//    int can_run();
//    QString can_data1_value();
//    QString can_data2_value();
    can_msg_t Message;
    int get_error_status(int fh, can_error_t& status);
    int transmit(/*int fh,*/ QCanBusFrame frame);

signals:
//    QString get_can_value(QString str);
//    void receive_message();
//    int can_run();
//    QString can_data1_value();
//    QString can_data2_value();

private:
    int open_driver();
    int can_initial(int fh, int BaudRate);
    void set_bitrate(int fh, int BaudRate);
    void clean_buffer(int fh);
    void can_filtermode(int fh, int mode);
    void set_filter(int fh, int filter_mode, int id_mode);
    void start(int fh);
//    void stop();
//    void receive_message();
//    int can_run();
//    QString can_data1_value();
//    QString can_data2_value();
    //Racev* m_pRacev;
#if defined ( EN_SJA1000_FRAME_LOG_ )
    QString m_filename;
    QFile m_file;
    QTextStream m_stream;
#endif
    int m_fh;

public slots:
//    QString receive_message();
//    void receive_message();
//    int can_run();
    //QString can_value_process(QString str);

protected:
    //SJA1000_Api(Racev* pRacev);
};

#endif // SJA1000_API_H
