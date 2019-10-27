/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include <iostream>

#include <QApplication>
//#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtGui/QFont>
#include <QtGui/QFontDatabase>
#include <QQuickItem>
#include <QQuickView>
#include <QQmlProperty>
#include <QQmlContext>
#include <QDebug>
#include <QCanBusDevice>
#include <QCanBusFrame>
#include <QDateTime>

#include "racev.h"
#include "worker.h"
#include "clockthread.h"
#if defined ( MONGO_THREAD_ )
#include "mongo/mongo.h"
#include "mongo/dbthread.h"
#endif
#include "conn/connthread.h"
#include "can/canthread.h"
#include "log/log.h"
#include "parameters/contactmodel.h"
#include "myobject.h"

//#define CONN_THREAD_
#define CAN_THREAD_

//
// references:
// Best Practices in Qt Quick/QML ( https://goo.gl/hHSSMB )
// QML 踩雷筆記 ( https://goo.gl/uYHvUE )
// top -H -p $(pidof dashboard)

#if defined ( EN_CONFIG_ )
const char *argp_program_version =
  "argp-ex3 1.0";
const char *argp_program_bug_address =
  "<bug-gnu-utils@gnu.org>";

/* Program documentation. */
static char doc[] =
  "Argp example #3 -- a program with options and arguments using argp";

/* A description of the arguments we accept. */
static char args_doc[] = "ARG1 ARG2 ARG3";

/* The options we understand. */
static struct argp_option options[] = {
  {"verbose",  'v', 0,      0,  "Produce verbose output", 0 },
  {"quiet",    'q', 0,      0,  "Don't produce any output", 0 },
  {"silent",   's', 0,      OPTION_ALIAS },
  {"output",   'o', "FILE", 0,
   "Output to FILE instead of standard output", 0 },
  { 0 }
};

/* Parse a single option. */
static error_t
parse_opt (int key, char *arg, struct argp_state *state)
{
  /* Get the input argument from argp_parse, which we
     know is a pointer to our arguments structure. */
  struct arguments *arguments = static_cast<struct arguments *>(state->input);

  switch (key)
    {
    case 'q': case 's':
      arguments->silent = 1;
      break;
    case 'v':
      arguments->verbose = 1;
      break;
    case 'o':
      arguments->output_file = arg;
      break;

    case ARGP_KEY_ARG:
      if (state->arg_num >= NUM_CMDLINE)
        /* Too many arguments. */
        argp_usage (state);

      arguments->args[state->arg_num] = arg;

      break;

    case ARGP_KEY_END:
      if (state->arg_num < NUM_CMDLINE)
        /* Not enough arguments. */
        argp_usage (state);
      break;

    default:
      return ARGP_ERR_UNKNOWN;
    }
  return 0;
}
static struct argp argp = { options, parse_opt, args_doc, doc };
#endif

#if defined ( CAN_THREAD_ )
int initial_CANBus_Thread(Racev& racev) {
    int rc = 0;
    CanThread *pCANBusReceiverThread = nullptr;
    QString errorString;
#if defined ( SKTCAN_IMPL_ )
    CanThread::Settings p;
    QCanBusDevice *pDevice = nullptr;
#endif

    // racev.initializeCANBusFrameBins(); // TODO: deprecated
    racev.pCANBusReceiverThread // book keeping
	= pCANBusReceiverThread = new CanThread(&racev);
#if defined ( SJA1000_IMPL_ )
    qDebug() << "SJA1000_IMPL_";
    rc = pCANBusReceiverThread->initialDriver();
    if ( rc ) {
	cout << __FILE__ << ":" << __LINE__
	    << " init driver NG, make sure device is ready!" << endl;
	goto ERROR_HANDLER;
    }
#elif defined ( SKTCAN_IMPL_ )
    // TODO: createQCanBusDevice();
    // Creating CAN Bus Devices ( https://goo.gl/FSQT5u )
    qDebug() << "SKTCAN_IMPL_";
    p = pCANBusReceiverThread->m_currentSettings;
    p.pluginName = CanThread::PLUGIN_NAME;
    p.deviceInterfaceName = CanThread::DEVICE_NAME;// make sure I/F is up
    pDevice = QCanBus::instance()->createDevice(
        p.pluginName, p.deviceInterfaceName, &errorString);
    if ( !QCanBus::instance()->plugins().contains(p.pluginName) ) {
	qDebug() << "plugin not available!";
	qWarning() << __FILE__ << __LINE__;
    }
    if ( !pDevice ) {
	qDebug() << QObject::tr("Error creating device '%1', reason: '%2'")
	    .arg(p.pluginName).arg(errorString);
	qWarning() << __FILE__ << __LINE__;
    }
    reinterpret_cast<CanThread *>(racev.pCANBusReceiverThread)->m_canDevice
	= pDevice;
    pCANBusReceiverThread->m_canDevice = pDevice;
    QObject::connect(pDevice, &QCanBusDevice::errorOccurred,
    pCANBusReceiverThread, &CanThread::processErrors);
    QObject::connect(pDevice, &QCanBusDevice::framesReceived,
    pCANBusReceiverThread, &CanThread::processReceivedFrames);
    QObject::connect(pDevice, &QCanBusDevice::framesWritten,
    pCANBusReceiverThread, &CanThread::processFramesWritten);
    if ( !pDevice->connectDevice() ) {
	qDebug() << QObject::tr("Connection error: %1")
	    .arg(pDevice->errorString());
	qWarning() << __FILE__ << __LINE__;
        delete pDevice;
        pDevice = nullptr;
	rc = -1;
	goto ERROR_HANDLER;
	// Goto can't skip over initializations of variables c++11 3.8.1
	// ( http://tinyurl.com/y6rmqtgj )
	//
	// ( http://tinyurl.com/y3ubqgqy )
	// QCoreApplication::exit(EXIT_FAILURE);
    } else {
        const QVariant bitRate =
        pDevice->configurationParameter(QCanBusDevice::BitRateKey);
        if (bitRate.isValid()) {
            const bool isCanFd = pDevice->configurationParameter(QCanBusDevice::CanFdKey).toBool();
            const QVariant dataBitRate = pDevice->configurationParameter(QCanBusDevice::DataBitRateKey);
            if (isCanFd && dataBitRate.isValid()) {
        qDebug() <<
            QObject::tr("Plugin: %1, connected to %2 at %3 / %4 kBit/s")
        .arg(p.pluginName).arg(p.deviceInterfaceName)
        .arg(bitRate.toInt() / 1000)
            .arg(dataBitRate.toInt() / 1000);
            } else {
        qDebug() << QObject::tr("Plugin: %1, connected to %2 at %3 kBit/s")
            .arg(p.pluginName).arg(p.deviceInterfaceName)
            .arg(bitRate.toInt() / 1000);
            }
        } else {
        qDebug() << QObject::tr("Plugin: %1, connected to %2")
        .arg(p.pluginName).arg(p.deviceInterfaceName);
        }
    }
#endif
    // TODO:
    // rc = pCANBusReceiverThread->initialDriver();
    //pCANBusReceiverThread->start(); // inherit priority
    pCANBusReceiverThread->start(racev.m_CANBusReceiverThreadPriority);
ERROR_HANDLER:
    return rc;
}
#endif

int main(int argc, char *argv[]) {
    Racev racev;
    racev.m_iStartUpTimeStamp = QDateTime::currentMSecsSinceEpoch();
#if defined ( CLOCK_THREAD_ )
    QTimer* m_pTimer = new QTimer(nullptr);
#endif
#if 1
    openlog(argv[0], LOG_NDELAY, LOG_DAEMON);
    syslog(LOG_DEBUG, "%s", "start");
    // The use of closelog() is optional.
    // ( https://linux.die.net/man/3/syslog )
    // worked. debian9 is at /var/log/syslog or /var/log/debug
#endif

#if defined ( EN_CONFIG_ )
    /* Parse our arguments; every option seen by parse_opt will
     be reflected in arguments. */
    argp_parse (&argp, argc, argv, 0, 0, &racev.m_arguments);
    fprintf (stdout, "ARG1 = %s\nARG2 = %s\nARG3 = %s\n"
	    "OUTPUT_FILE = %s\nIMEI_FILE = %s\nALARM_FILE = %s\n"
	  "VERBOSE = %s\nSILENT = %s\n",
	  racev.m_arguments.args[0], racev.m_arguments.args[1],
	  racev.m_arguments.args[2], // TODO: configuration file
	  racev.m_arguments.output_file,
	  racev.m_arguments.imei_file,
	  racev.m_arguments.alarm_parameter_file,
	  racev.m_arguments.verbose ? "yes" : "no",
	  racev.m_arguments.silent ? "yes" : "no");
#endif

#if 0
    // testing and worked. debian9 is at /var/log/syslog or /var/log/debug
    // Redirect C++ std::clog to syslog on Unix
    // ( https://tinyurl.com/y3xahcpm )
    std::clog.rdbuf(new Log("foo", LOG_LOCAL0));
    //std::clog << kLogNotice << "test log message" << std::endl;
    std::clog << "start the default is debug level" << std::endl;
#endif
    //QGuiApplication app(argc, argv);

    // Qt Charts utilizes Qt Graphics View Framework for drawing,
    // QApplication must be used. ( http://tinyw.in/2bBe )
    QApplication app(argc, argv);
    //check: Qt Charts ( https://goo.gl/3RisGS )
    // QtQuick2 QML ChartView example ( http://tinyw.in/qZt5 )
    // simple example ( http://tinyw.in/9HlV )
    int rc = 0;
#if defined ( CLOCK_THREAD_ )
    Worker* worker = nullptr;
    ClockThread *clockThread = nullptr;
#endif

    //qDebug() << "GUI thread +" << app.thread()->currentThreadId();
    //qDebug() << "sizeof(QCanBusFrame)" << sizeof(QCanBusFrame)
    //	<< "sizeof(SJA1000_Api)" << sizeof(QCanBusFrame);

    // Set priority to GUI thread ( https://goo.gl/UrgME5 )
    QThread::currentThread()->setPriority(QThread::NormalPriority);
#if defined ( QT_DEBUG )
    qDebug() << "GUI thrd prio " << app.thread()->currentThread()->priority();
#endif
    //QCoreApplication::exit();
    app.setApplicationName("RACEVHMI");
    app.setApplicationVersion(VERSION_STRING);
    //qDebug() << "name:" << app.applicationName() << "version:" << app.applicationVersion();

//#define QML_CALL_
#if defined( QML_CALL_ )
    qmlRegisterType<MyObject>("com.myself", 1, 0, "MyObject");
#endif
    // (namespace, version, version, name) ( https://tinyurl.com/yygvw849 )
    qmlRegisterType<ContactModel>("Backend", 1, 0, "ContactModel");
    QFontDatabase::addApplicationFont(":/fonts/DejaVuSans.ttf");
    app.setFont(QFont("DejaVu Sans"));

#if 0
    // currently stable
    QQmlApplicationEngine engine(QUrl("qrc:/qml/dashboard.qml"));
    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
    qDebug() << "error loading!";
        return -1;
    }
    //engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
#endif

#if 1
    // FIXME: stable but can not access children window/elements
    // Create separate QML window from C++ code
    // ( https://goo.gl/yikv6a )
    // Include another QML file from a QML file
    // ( https://goo.gl/7dBfTc )
    QQmlApplicationEngine engine(QUrl("qrc:/qml/dashwindow.qml"));
    if ( engine.rootObjects().isEmpty() ) {
        cout << " error loading!" << endl;
        return -1;
    }
#endif

#if 0
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &QGuiApplication::quit);
#endif

#if 0
    // FIXME:
    QQmlApplicationEngine engine;
    //QQmlComponent component(&engine);
    QQmlComponent component(&engine, QUrl(QStringLiteral("qrc:/qml/dashwindow.qml")));
    QObject *object = component.create();
    // delete required
#endif

    // Accessing Loaded QML Objects by Object Name
    // ( https://goo.gl/ErCsxD )
    QObject *txtVersion = engine.rootObjects().first()->findChild<QObject*>("txtVersion");
    if (txtVersion)
        txtVersion->setProperty("text", VERSION_STRING);

#if 0
     QQmlApplicationEngine engine;
    // Using QQuickView
    QQuickView view;
    view.setSource(QUrl("qrc:/qml/dashwindow.qml"));
    view.show();
    QObject *object = view.rootObject();
    qDebug() << object;
#endif

#if 0
    cout << __func__ << ":" << __LINE__ << "+" << endl;
    QQmlComponent component(&engine, QUrl("qrc:/qml/chartview.qml"));
    QObject *object = component.create();
    cout << __func__ << ":" << __LINE__ << "-" << endl;
#endif

#if 0
    engine.addImportPath("/home/racev/src/dashboard/qml/jbQuick/Charts");
#endif

    //rc = racev.initialize();
    rc = racev.initialize(engine);
    if ( 0 != rc ) {
        qDebug() << "fail to initialize!";
        return -2;
    }
    // cout << __func__ << ":" << __LINE__ << " pre clock" << endl;

#if defined ( CONN_THREAD_ )
    ConnThread *connThread = new ConnThread(&racev); // TODO: move to racev
    connThread->start();
#endif

#if defined ( MONGO_THREAD_ )
    DbThread *dbThread = new DbThread(&racev); // TODO: move to racev
    //mongo->moveToThread(dbThread);
    dbThread->start();
#endif

#if defined ( CLOCK_THREAD_ )
    // racev.pClockThread = clockThread = new ClockThread();
    racev.pClockThread = clockThread = new ClockThread(&racev);
    racev.pWorkerThread = worker = new Worker(&engine, &racev);
    // @see https://tinyurl.com/y2r9l4u8
    worker->moveToThread(clockThread);
    // worker->moveToThread(racev.pClockThread); // FIXME: https://goo.gl/pSpejt
    //clockThread->start();
    clockThread->start(racev.m_ClockThreadPriority);
    // test ticking something here
    QObject::connect(
	clockThread, SIGNAL(notifyUpdate(void)),
	worker, SLOT(updateModel(void)), Qt::QueuedConnection);
    // old syntax vs new syntax ( https://goo.gl/MHEpkQ )
    //QObject::connect(clockThread, SIGNAL (error(QString)), worker, SLOT (errorString(QString)));
    // ticking source
    QObject::connect(
	clockThread, SIGNAL(signalTicksSec(unsigned int)),
	worker, SLOT(onSignalTicksSec(unsigned int)), Qt::QueuedConnection);
    // ticking G-sensor input
    QObject::connect(
	worker, SIGNAL(signalAccelerometer(void)),
	worker, SLOT(onSignalAccelerometer(void)), Qt::QueuedConnection);
    // ticking slope via 6911x
    QObject::connect(
	worker, SIGNAL(signalTickSlope(void)),
	worker, SLOT(onTickSlope(void)), Qt::QueuedConnection);
    // ticking info writing
    QObject::connect(
	worker, SIGNAL(signalLogVehicleInfo(void)),
	racev.m_pInfo, SLOT(onLogVehicleInfo(void)), Qt::QueuedConnection);

#endif
    // place here to make sure later than pWorker initialization
    // before found any new placement
    racev.setActiveWindow(racev.m_pWinLogOn);

#if defined ( GPS_THREAD_ )
    QObject::connect(
	worker, SIGNAL(signalSyncGpsTimeToHw(void)),
	worker, SLOT(onSyncGpsTimeToHw(void)), Qt::QueuedConnection);
#endif

    racev.connectOnLoadSlots();
    racev.connectOnActiveSlots();
    // cout << __func__ << ":" << __LINE__ << "post connect" << endl;
    // startup sequence: 'drain', then 'source'
#if defined ( CAN_THREAD_ )
    rc = initial_CANBus_Thread(racev);
    if ( rc ) {
	cout << __func__ << ":" << __LINE__ << "! rc " << rc << endl;
	QCoreApplication::exit(EXIT_FAILURE);
    }
#endif

    // cout << __func__ << ":" << __LINE__ << "*5" << endl;
#if defined ( NEXCOM_CAN06_THREAD_ )
    rc = racev.createCan06Thread();
    if ( rc ) {
	cout << __func__ << ":" << __LINE__ << "! rc " << rc << endl;
	QCoreApplication::exit(EXIT_FAILURE);
    }
#endif

#if defined ( GPS_THREAD_ )
    rc = racev.createGPSThread();
    if ( rc ) {
	cout << __func__ << ":" << __LINE__ << "! rc " << rc << endl;
	QCoreApplication::exit(EXIT_FAILURE);
    }
#endif

#if 0 // thread will quit!
    clockThread->quit();
    clockThread->wait();
#endif
#if defined ( CLOCK_THREAD_ )
    QObject::connect( m_pTimer, SIGNAL(timeout()),
	clockThread, SLOT(timerHit()), Qt::DirectConnection);
    m_pTimer->setInterval(1000*1);
    m_pTimer->start();
#endif
    cout << __func__ << ":" << __LINE__ << " -" << endl;
    return app.exec();
}
