#ifndef CANTHREAD_H
#define CANTHREAD_H

// frame source selection
#define SJA1000_IMPL_
//#define SKTCAN_IMPL_
// TODO: there will be 2 independent CANbus threads

#define EN_CANTHREAD_FRAME_LOG_ // log receiving/transmitting canbus frame into file
#define EN_PARSE_ // parse
#define EN_ERR_CHK_ // respond error counter status

#include <QThread>
#include <QCanBusFrame>

#if defined ( SJA1000_IMPL_ )
#include "can/sja1000_api.h"
#elif defined ( SKTCAN_IMPL_ )
// Using SocketCAN Plugin ( https://goo.gl/FSQT5u )
#include <QCanBus>
#include <QCanBusDevice>
#endif

#include "racev.h"

class CanThread : public QThread
{
    Q_OBJECT
public:
    CanThread();
    CanThread(Racev* pRacev);
    ~CanThread() override;
#if defined ( SJA1000_IMPL_ )
    int initialDriver(void);
#elif defined ( SKTCAN_IMPL_ )
    static const QString PLUGIN_NAME;
    static const QString DEVICE_NAME;
typedef QPair<QCanBusDevice::ConfigurationKey, QVariant> ConfigurationItem;
struct Settings {
    QString pluginName;
    QString deviceInterfaceName;
    QList<ConfigurationItem> configurations;
    bool useConfigurationEnabled = false;
};
    qint64 m_numberFramesWritten = 0;
    Settings m_currentSettings;
    QCanBusDevice *m_canDevice = nullptr;
public slots:
    void processReceivedFrames();
    void processErrors(QCanBusDevice::CanBusError) const;
    void processFramesWritten(qint64);
#endif
    int Transmit(QCanBusFrame f);

signals:
    void canSignalFrame(quint32, QCanBusFrame* pframe);
#if defined ( EN_ERR_CHK_ )
    void canSignalErrorFrame(uint direction, uint stat, uint rx_err_cnt, uint tx_err_cnt);
#endif

protected:

private:
    void run() override;
    qint64 m_op; // TODO: obselete
    Racev* m_pRacev;
#if defined ( SJA1000_IMPL_ )
    SJA1000_Api* m_pCANBusDriver;
    int m_FileHandle;
    void updateQAndBufferSize(QCanBusFrame& frame, int Qsize, int Bsize);
    //unsigned int m_numTimesChecked;
#elif defined ( SKTCAN_IMPL_ )
#endif

#if defined ( EN_CANTHREAD_FRAME_LOG_ )
    QString m_filename;
    QFile m_file;
    QTextStream m_stream;
#endif
};

#endif // CANTHREAD_H
