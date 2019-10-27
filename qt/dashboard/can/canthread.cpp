#include <iostream>     // std::cout, std::endl
#include <iomanip>      // std::setfill, std::setw

#include <QTimer>
#include <QDateTime>
#include <QDebug>
#include <QMutex>
#include <QWaitCondition>
#include <QFile>
#include <QByteArray>
#include <QCanBusDevice>
#include <QCanBusFrame>
#include <QVector>
#include <QProcess>

#include "can/canthread.h"
#if defined ( SJA1000_IMPL_ )
#include "can/sja1000_api.h"
#endif

#include "racev.h"
#include "worker.h"

//using namespace std::chrono; // ( https://goo.gl/CXUreA ) C++ 11 way

CanThread::CanThread()
{
    //qDebug() << "CanThread+";
}

// FIXME:
// 靜態空間變數/全域變數，是接近 evil 的東西 ( http://tinyurl.com/y2xabqck )
#if defined ( SKTCAN_IMPL_ )
const QString CanThread::PLUGIN_NAME = "socketcan";
const QString CanThread::DEVICE_NAME = "vcan0";
#endif

CanThread::CanThread(Racev* racev):
    m_op(0), m_pRacev(racev)
#if defined ( SJA1000_IMPL_ )
    , m_FileHandle(0)//, m_numTimesChecked(0)
#elif defined ( SKTCAN_IMPL_ )
#endif

#if defined ( EN_CANTHREAD_FRAME_LOG_ )
    // , m_filename("/dev/shm/cthread-cap.txt")
    , m_filename("/home/racev/dashboard.d/logs/cthread-cap.txt")
#endif
{
    cout << "CanThread()+" << endl;
#if defined ( EN_CANTHREAD_FRAME_LOG_ )
    // ( http://tinyw.in/KKoP )
    m_file.setFileName(m_filename);
    if ( false == m_file.open(QIODevice::ReadWrite | QIODevice::Append) ) {
        qDebug() << __FILE__ << ":" << __LINE__ << "file open!";
    }
    m_stream.setDevice(&m_file);
#endif

#if defined ( SJA1000_IMPL_ )
    //m_pCANBusDriver = new SJA1000_Api();
    m_pCANBusDriver = new SJA1000_Api(this);
    //qDebug() << "CanThread() szapi" << sizeof(*m_pCANBusDriver);
#elif defined ( SKTCAN_IMPL_ )
    // ( http://tinyurl.com/y3f437po )
#endif

}

CanThread::~CanThread()
{
    // qDebug() << "CanThread-";
}

#if defined ( SJA1000_IMPL_ )
void CanThread::run() {
    QCanBusFrame* pframe = nullptr;
#define EN_TRANSMIT_
#if defined ( EN_TRANSMIT_ )
    QCanBusFrame frame_tx;
    // roughly 50ms (30+20) times 10
    int counter_tx = 0;
    //int yr_lb, mo, dt, hr, min, sec;
    QString s_yr, s_mo, s_dt, s_hr, s_min, s_sec;
#endif
    //qint64 current_ts = 0;
    int rc = 0;
    can_error_t err_status;

    QObject::connect(
	m_pRacev->m_pFrameParser, SIGNAL(canSignalFrame(quint32, QCanBusFrame*)),
	m_pRacev->pWorkerThread, SLOT(onSignalCANFrame(quint32, QCanBusFrame*)));

#if defined ( EN_ERR_CHK_ )
    // error counter is specially treated.
    QObject::connect(
	m_pRacev->pCANBusReceiverThread, SIGNAL(canSignalErrorFrame(uint, uint, uint, uint)),
	m_pRacev->pWorkerThread, SLOT(onSignalErrorFrame(uint, uint, uint, uint)));
    // can not queue arguments of type can_error_t
#endif
    //current_ts = QDateTime::currentMSecsSinceEpoch();
    // cout << "CANThrd prio " << QThread::currentThread()->priority() << endl;
    //QMutexLocker locker(&m_pRacev->m_mutex);

#define EN_SELF_TEST_PAUSE_
#if defined ( EN_SELF_TEST_PAUSE_ )
    sleep(1);
#endif
    while ( !QThread::currentThread()->isInterruptionRequested()
            /* readRequests.isEmpty() && writeRequests.isEmpty()*/ ) {
	//qDebug() << "CANThrd wait...";
#if defined ( EN_ERR_CHK_ )
	rc = m_pCANBusDriver->get_error_status(m_FileHandle, err_status);
	//m_numTimesChecked++;
	emit canSignalErrorFrame(err_status.Direction, err_status.error_stat,
	    err_status.rx_err_cnt, err_status.tx_err_cnt);
#endif
        //msleep(50); // initial, half of the least small interval, + prio
	//msleep(30); // after VCU test, speed up to catch all BAMs
	//usleep(1000); // trial to capture 48 voltage BAMs
	//usleep(6000); // trial according to spec least interval TP.DT
	usleep(30); // 20191024 dynamic test
	do {
	    pframe = &m_pRacev
		->m_CANBusCircularBuffer[m_pRacev->m_CANBusCircularBufferHead++];
	    if ( NUM_CANCB <= m_pRacev->m_CANBusCircularBufferHead ) {
		m_pRacev->m_CANBusCircularBufferHead = 0;
	    }
	    //msleep(9); // (normal,50,9) playback OK -> (normal,40,9),
	    // usleep(1000); // trial to capture 48 voltage BAMs
	    // usleep(6000); // trial according to spec least interval TP.DT
	    // msleep(20);
	    usleep(30);
#if 0
	    qDebug() << __func__ << ":" << __LINE__ << static_cast<void*>(pframe)
		<< "H" << m_pRacev->m_CANBusCircularBufferHead
		<< "T" << m_pRacev->m_CANBusCircularBufferTail;
#endif
	    rc = m_pCANBusDriver->receive_frame_nonblock(*pframe);
#if 0
	    qDebug() << __func__ << ":" << __LINE__
		<< QString("0x%1")
		.arg(pframe->frameId(), 8, 16, QLatin1Char( '0' )) << " "
		<< "data " << pframe->payload().toHex(' ') << '\n';
#endif

#if defined ( EN_CANTHREAD_FRAME_LOG_ )
	    // TODO: discriminator issue
	    // log to ram (/tmp)
	    // ( https://goo.gl/CXUreA ) C++ 11 way
	    //milliseconds ms = duration_cast< milliseconds >(
	    //    system_clock::now().time_since_epoch()
	    //);
	    m_stream << QDateTime::currentMSecsSinceEpoch() << " frame id "
		<< QString("0x%1")
		.arg(pframe->frameId(), 8, 16, QLatin1Char( '0' )) << " "
		<< "type " << pframe->frameType() << " "
		<< "data " << pframe->payload().toHex(' ') << '\n';
	    // FIXME: crash
	    // m_stream.flush(); // unmark to assert single write sequence

// filter unique output
// cut -d ' ' -f 4 cthread-cap.txt | awk '!seen[$0]++' | uniq | sort
#endif
#if defined ( EN_PARSE_ )
	    m_pRacev->m_pFrameParser->parse(pframe);
#endif
	} while ( 0 < rc );
#if defined ( EN_TRANSMIT_ )
	counter_tx++;
	if ( 10 <= counter_tx ) {
	    counter_tx = 0;
	    frame_tx.setFrameId(HMI_TM_MSG01);
	    frame_tx.setFrameType(QCanBusFrame::DataFrame);
	    QDateTime local(QDateTime::currentDateTime());
	    s_yr = QString("%1").arg(local.toString("yyyy").toInt(), 4, 16, QChar('0'));
	    s_mo = QString("%1").arg(local.toString("MM").toInt(), 2, 16, QChar('0'));
	    s_dt = QString("%1").arg(local.toString("dd").toInt(), 2, 16, QChar('0'));
	    s_hr = QString("%1").arg(local.toString("hh").toInt(), 2, 16, QChar('0'));
	    s_min = QString("%1").arg(local.toString("mm").toInt(), 2, 16, QChar('0'));
	    s_sec = QString("%1").arg(local.toString("ss").toInt(), 2, 16, QChar('0'));
	    // QString s_yr= QString::number( nValue, 16 ) + QString::number( nValue, 16 );
	    // qDebug() << "date" << yr << mo << dt << hr << min << sec;
	    // ref. ( https://is.gd/Q0AKka )
	    // QString str = "0x202D130506E307"+"00"; // TODO: byte 07
	    QString str = /*"0x" + */s_sec + s_min + s_hr
		+ s_dt + s_mo + s_yr.mid(2,2) + s_yr.mid(0,2) + "00";
	    //QString value =  str.mid(2);    // "FFFF"   <- just the hex values!
	    QByteArray array2 = QByteArray::fromHex(str.toLatin1());
	    frame_tx.setPayload(array2);
	    rc = m_pCANBusDriver->transmit(/*m_FileHandle, */frame_tx);
	}
#endif
    }
    m_pCANBusDriver->stop(); // according to manual
#if defined( EN_CANTHREAD_FRAME_LOG_ )
    // m_stream << endl; // ?
    m_file.close();
#endif
    // is-a QObject no need to explicit delete
    // delete m_pCANBusDriver;
    cout << __FILE__ << ":" << __LINE__ << "-" << endl;
}

int CanThread::initialDriver(void) {
    int rc = 0;
    rc = m_pCANBusDriver->can_run(&m_FileHandle);
#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< "fh " << m_FileHandle << "rc " << rc << endl;
#endif
    return rc;
}

void CanThread::updateQAndBufferSize(
    QCanBusFrame& frame, int Qsize, int Bsize) {
    QVariant returnedValue;
    QMetaObject::invokeMethod(m_pRacev->m_pWinMain, "updateQBInfo",
        Qt::BlockingQueuedConnection,
        Q_RETURN_ARG(QVariant, returnedValue),
        Q_ARG(QVariant, frame.payload().toHex(0)),
        Q_ARG(QVariant, Qsize),
    Q_ARG(QVariant, Bsize));
}

int CanThread::Transmit(QCanBusFrame f) {
    // TODO: Assume human intervention, write to logfile.
#if defined ( EN_CANTHREAD_FRAME_LOG_ )
    m_stream << QDateTime::currentMSecsSinceEpoch() << " frame id "
	<< QString("0x%1")
	.arg(f.frameId(), 8, 16, QLatin1Char( '0' )) << " "
	<< "type " << f.frameType() << " "
	<< "data " << f.payload().toHex(' ') << '\n';
    // TODO: logFrame(f);
#endif
    int rc = m_pCANBusDriver->transmit(f); // 0 success, otherwise failed
    if ( rc )
	cout << __FILE__ << ":" << __LINE__ << " " << rc << endl;
#if 0 //defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " - " << endl;
#endif
    return rc;
}

#elif defined ( SKTCAN_IMPL_ )
void CanThread::run() {
    QCanBusFrame frame;
    qint64 current_ts = 0;

    current_ts = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "CANThrd prio" << QThread::currentThread()->priority()
	<< "ts" << current_ts;
    //QMutexLocker locker(&m_pRacev->m_mutex);
    while ( !QThread::currentThread()->isInterruptionRequested()
            /* readRequests.isEmpty() && writeRequests.isEmpty() */) {
	//qDebug() << "CThrd skt pend...";
	msleep(5000);
    // thread priority up
    // QThread::Priority ( https://goo.gl/R5yTV3 )
    //current_ts = QDateTime::currentMSecsSinceEpoch();
    //qDebug() << "CThrd skt post" << current_ts;
    // Q: delete creating object?
    // A: Correct example (no dynamic objects, no leak)
    // ( https://goo.gl/WCg5fo )
    // Q: qt queue max size?
    }
    m_canDevice->disconnectDevice();
#if defined( EN_CANTHREAD_FRAME_LOG_ )
    m_stream << endl;
    m_file.close();
#endif
    cout << __FILE__ << ":" << __LINE__ << " -" << endl;
}

int CanThread::Transmit(QCanBusFrame f) {
    // TODO: Assume human intervention, write to logfile.
    // cout << __FILE__ << ":" << __LINE__ << " + " << endl;
    bool ok = m_canDevice->writeFrame(f); // 0 success, otherwise failed
#if defined ( EN_CANTHREAD_FRAME_LOG_ )
    m_stream << QDateTime::currentMSecsSinceEpoch() << " frame id "
	<< QString("0x%1")
	.arg(f.frameId(), 8, 16, QLatin1Char( '0' )) << " "
	<< "type " << f.frameType() << " "
	<< "data " << f.payload().toHex(' ') << '\n';
    // TODO: logFrame(f);
#endif
#if 0 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << ok << " -" << endl;
#endif
    return static_cast<int>(ok);
}

#if defined ( VERBOSE_OUT_ )
static QString frameFlags(const QCanBusFrame &frame)
{
    QString result = QLatin1String(" --- ");

    if (frame.hasBitrateSwitch())
        result[1] = QLatin1Char('B');
    if (frame.hasErrorStateIndicator())
        result[2] = QLatin1Char('E');
    if (frame.hasLocalEcho())
        result[3] = QLatin1Char('L');

    return result;
}
#endif

void CanThread::processErrors(QCanBusDevice::CanBusError error) const
{
    switch (error) {
    case QCanBusDevice::ReadError:
    case QCanBusDevice::WriteError:
    case QCanBusDevice::ConnectionError:
    case QCanBusDevice::ConfigurationError:
    case QCanBusDevice::UnknownError:
    qDebug() << tr("'%1'").arg(m_canDevice->errorString());
        break;
    default:
        break;
    }
}

void CanThread::processReceivedFrames() {
    QCanBusFrame *pframe = nullptr;
    if (!m_canDevice)
        return;

    while (m_canDevice->framesAvailable()) {
	pframe = &m_pRacev
	    ->m_CANBusCircularBuffer[m_pRacev->m_CANBusCircularBufferHead++];
	if ( NUM_CANCB <= m_pRacev->m_CANBusCircularBufferHead ) {
	    m_pRacev->m_CANBusCircularBufferHead = 0;
	}
        *pframe = m_canDevice->readFrame();
#if 0
	qDebug() << "read frame" << static_cast<void*>(pframe)
	    << "H" << m_pRacev->m_CANBusCircularBufferHead
	    << "T" << m_pRacev->m_CANBusCircularBufferTail;
#endif
#if defined ( EN_CANTHREAD_FRAME_LOG_ )
	    // ( https://goo.gl/CXUreA ) C++ 11 way
	    //milliseconds ms = duration_cast< milliseconds >(
	    //    system_clock::now().time_since_epoch()
	    //);
	    m_stream << QDateTime::currentMSecsSinceEpoch() << " frame id "
	    << QString("0x%1")
	    .arg(pframe->frameId(), 8, 16, QLatin1Char( '0' )) << " "
	    << "type " << pframe->frameType() << " "
	    << "data " << pframe->payload().toHex(' ') << '\n'; // << flush;
	    //stream.flush(); // unmark to see every single write and sequence
// filter unique output
// cut -d ' ' -f 4 cthread-cap.txt | awk '!seen[$0]++' | uniq | sort
#endif

	m_pRacev->m_pFrameParser->parse(pframe);

#if defined ( VERBOSE_OUT_ )
        QString view;
        if (pframe->frameType() == QCanBusFrame::ErrorFrame)
            view = m_canDevice->interpretErrorFrame(pframe);
        else
            view = pframe->toString();

        const QString time = QString::fromLatin1("%1.%2  ")
                .arg(pframe->timeStamp().seconds(), 10, 10, QLatin1Char(' '))
                .arg(pframe->timeStamp().microSeconds()
            / 100, 4, 10, QLatin1Char('0'));
        const QString flags = frameFlags(*pframe);
	qDebug() << time << flags << view;
#endif
    }
}

void CanThread::processFramesWritten(qint64 count) {
    m_numberFramesWritten += count;
    //qDebug << tr("%1 frames written").arg(m_numberFramesWritten);
}
#else
void CanThread::run() {}
#endif
