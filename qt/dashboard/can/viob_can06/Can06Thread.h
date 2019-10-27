#ifndef CAN06THREAD_H
#define CAN06THREAD_H

#include <QThread>
#include <QCanBusFrame>
#include <QSerialPort>
#include <QSerialPortInfo>

#include "racev.h"
#define MAX_NUM_COMMANDS 52

#if defined ( NEXCOM_CAN06_THREAD_ )

class Can06Thread : public QThread
{
    Q_OBJECT
public:
    Can06Thread();
    Can06Thread(Racev* pRacev);
    ~Can06Thread() override;
    void writeCommand(const QByteArray &atcmd);
    QCanBusFrame m_cachedFrame;

signals:
    void issue(const QByteArray &atcmd);
protected:

private:
    void run() override;
    Racev* m_pRacev;
    int launchScript(void);
    QByteArray m_buffer;
    // void processLine(const QByteArray & line);
    int initialize(void);
    bool m_bPolling;
    int m_iPollingTurn;
};
#endif

#endif // CAN06THREAD_H
