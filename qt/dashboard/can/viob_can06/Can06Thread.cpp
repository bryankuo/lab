#include <iostream>     // std::cout, std::endl
#include <iomanip>      // std::setfill, std::setw

#include <QTimer>
#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QByteArray>
#include <QSerialPort>
#include <QCanBusFrame>
#include <QProcess>
#include <QStringList>

#include "can/viob_can06/Can06Thread.h"

#include "racev.h"
#include "worker.h"

#if defined ( NEXCOM_CAN06_THREAD_ )

const QByteArray cmd_ate0 = "ATE0\r";
const QByteArray cmd_atl1 = "ATL1\r";
const QByteArray cmd_ath1 = "ATH1\r";
const QByteArray cmd_atz = "ATZ\r";

#if 0
const QByteArray cmd_at_mp_ff00 = "AT MP 00FF90\r"; // wait 200 works, 100 NG, 150 works
const QByteArray cmd_at_mp_ff91 = "AT MP 00FF91\r";
const QByteArray cmd_at_mp_ff92 = "AT MP 00FF92\r";
#endif

#define ATMP_00FF90 0
#define ATMP_00FF91 1
#define ATMP_00FF92 2
#define ATMP_00FF00 3
#define ATMP_00FF01 4

#define ATMP_00FF02 5
#define ATMP_00FF03 6
#define ATMP_00FF68 7
#define ATMP_00FF0C 8
#define ATMP_00FE6F 9

#define ATMP_00F007 10
#define ATMP_00FE5B 11
#define ATMP_00FECA 12
#define ATMP_00FF95 13
#define ATMP_00FF96 14

#define ATMP_00FF97 15
#define ATMP_00FF98 16
#define ATMP_00FF10 17
#define ATMP_00FF11 18
#define ATMP_00FF12 19

#define ATMP_00FF61 20
#define ATMP_00FF62 21
#define ATMP_00FF60 22
#define ATMP_00FF93 23
#define ATMP_00FF94 24

#define ATMP_00FF04 26
#define ATMP_00FF05 27
#define ATMP_00FF06 28
#define ATMP_00FF07 29
#define ATMP_00FF69 30

#define ATMP_00F008 31
#define ATMP_00F009 32
#define ATMP_00FF40 33
#define ATMP_00FF20 34
#define ATMP_00FF21 35

#define ATMP_00FF09 36
#define ATMP_00FF41 37
#define ATMP_00FF42 38
#define ATMP_00FF43 39
#define ATMP_00FF44 40

#define ATMP_00FF45 41
#define ATMP_00FF46 42
#define ATMP_00FF47 43
#define ATMP_00FF48 44
#define ATMP_00FF49 45

#define ATMP_00FF4A 46
#define ATMP_00FF13 47
#define ATMP_00FF14 48
#define ATMP_00FF6A 49
#define ATMP_00FF50 50

#define ATMP_00FF0A 51
#define ATMP_00FF0B 52

// means s/Taiwan
//
const QByteArray at_cmds[MAX_NUM_COMMANDS] = {
    "AT MP 00FF90\r",
    "AT MP 00FF91\r",
    "AT MP 00FF92\r",
    "AT MP 00FF00\r", //
    "AT MP 00FF01\r", //

    "AT MP 00FF02\r", //
    "AT MP 00FF03\r", //
    "AT MP 00FF68\r", //
    "AT MP 00FF0C\r", //
    "AT MP 00FE6F\r",

    "AT MP 00F007\r",
    "AT MP 00FE5B\r",
    "AT MP 00FECA\r", //
    "AT MP 00FF95\r", //
    "AT MP 00FF96\r", //

    "AT MP 00FF97\r", //
    "AT MP 00FF98\r",
    "AT MP 00FF10\r",
    "AT MP 00FF11\r",
    "AT MP 00FF12\r",

    "AT MP 00FF61\r",
    "AT MP 00FF62\r",
    "AT MP 00FF60\r",
    "AT MP 00FF93\r", //
    "AT MP 00FF94\r", //

    "AT MP 00FF04\r", //
    "AT MP 00FF05\r",
    "AT MP 00FF06\r",
    "AT MP 00FF07\r",
    "AT MP 00FF69\r", //

    "AT MP 00F008\r",
    "AT MP 00F009\r", //
    "AT MP 00FF40\r", //
    "AT MP 00FF20\r", //
    "AT MP 00FF21\r", //

    "AT MP 00FF09\r", //
    "AT MP 00FF41\r", //
    "AT MP 00FF42\r", //
    "AT MP 00FF43\r", //
    "AT MP 00FF44\r", //

    "AT MP 00FF45\r", //
    "AT MP 00FF46\r", //
    "AT MP 00FF47\r", //
    "AT MP 00FF48\r", //
    "AT MP 00FF49\r", //

    "AT MP 00FF4A\r", //
    "AT MP 00FF13\r", //
    "AT MP 00FF14\r", //
    "AT MP 00FF6A\r",
    "AT MP 00FF50\r", //

    "AT MP 00FF0A\r",
    "AT MP 00FF0B\r"
};

const int at_cmd_timings[MAX_NUM_COMMANDS] = {
    1500, 2000, 150, 500, 500,	500, 500, 500, 500, 500,
    500, 500, 500, 500, 500,	500, 500, 500, 500, 500,
    500, 500, 500, 500, 500,	500, 500, 500, 500, 500,
    500, 500, 500, 500, 500,	500, 500, 500, 500, 500,
    500, 500, 500, 500, 500,	500, 500, 500, 500, 500,
    500, 500
};

#if 0
    QByteArray cmd_stp_42 = "STP 42\r";
    QByteArray cmd_stcmm_1 = "STCMM 1\r";
    QByteArray cmd_stfac = "STFAC\r";

    QByteArray cmd_stfpga_ff00 = "STFPGA FF00,00\r";
    QByteArray cmd_stfpga_ff01 = "STFPGA FF01\r";
    QByteArray cmd_stfpga_ff02 = "STFPGA FF02\r";
    QByteArray cmd_stfpga_ff03 = "STFPGA FF03\r";
    QByteArray cmd_stm = "STM\r";

    QByteArray cmd_ati = "ATI\r";
    QByteArray cmd_atspa = "AT SP A\r";
    QByteArray cmd_atdp = "ATDP\r";
    QByteArray cmd_atma = "AT MA\r";
    QByteArray cmd_atws = "ATWS\r";

    QByteArray cmd_atcs = "ATCS\r";
    QByteArray cmd_pgn_00ff00 = "AT MP 00FF00\r";
#endif

Can06Thread::Can06Thread()
{
    cout << __func__ << ":" << __LINE__ << " + " << endl;
}

Can06Thread::Can06Thread(Racev* racev):
    m_pRacev(racev),
    m_bPolling(true),
    m_iPollingTurn(0)
{
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " + " << endl;
#endif
#if 0 // works
    m_Commands[0] = cmd_at_mp_ff92;
    m_Commands[1] = cmd_at_mp_ff91;
    m_Commands[2] = cmd_at_mp_ff00;

    m_CommandTimings[0] = 1500; // ms
    m_CommandTimings[1] = 2000; // ms
    m_CommandTimings[2] = 150;  // ms
#endif
#if 0
    // 500 NG, 1000 not reliable
    m_CommandTimings[0] = 1000; // ms
    m_CommandTimings[1] = 1000; // ms
    m_CommandTimings[2] = 1000; // ms
#endif


}

Can06Thread::~Can06Thread()
{
#if defined ( QT_DEBUG )
    cout << "Can06Thread-" << endl;
#endif
}

#if 0
// TODO: to be obselete
void Can06Thread::processLine(const QByteArray & line) {
    //m_buffer.append(line);
#if 0
    qDebug() << __func__ << ":" << __LINE__
	<< QString::fromStdString(m_buffer.toStdString());
#endif
    // QByteArray split out data ( https://to.ly/1zjKv )
#if 0
    QList<QByteArray> lines = m_buffer.split('\n');
    foreach ( const QByteArray &line, lines) {
	// line.simplified();
	line.trimmed(); // ( https://to.ly/1zjMR )
	if ( 1 < line.size() )
	    qDebug() << __func__ << ":" << __LINE__
		<< QString::fromStdString(line.toStdString());
    }
    m_buffer = lines[lines.size()-1];
#endif
#if 0
    qDebug() << __func__ << ":" << __LINE__
	<< QString::fromStdString(m_buffer.toStdString());
#endif
}
#endif

void Can06Thread::writeCommand(const QByteArray &atcmd) {
cout << __func__ << ":" << __LINE__ << " - " << endl;
#if 0
    QByteArray cmd(QByteArray);
    std::string stdString(cmd.constData(), cmd.length());
#endif
#if 1
    QString qs = QString::fromStdString(atcmd.toStdString());
    qDebug() << __func__ << ":" << __LINE__ << qs;
    // emit this->issue(atcmd);
#endif
#if 0
    cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__
	<< " " << atcmd.size() << endl;
#endif
    // some checking here
    // if ( 0 < this->m_AtCommand.size() ) { // checking input is required
    //	m_AtCommand = &atcmd;
    // }
}

// TODO: initial serial port specific routines
int Can06Thread::initialize(void) {
    int rc = 0;
    return rc;
}

// ref: ( https://is.gd/jnVFc3 )
void Can06Thread::run() {
    int count = 0;
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__
	<< " VOIBCAN06_IMPL_ prio "
	<< QThread::currentThread()->priority()
	<< endl;
#endif

    //rc = initialize();
#if defined ( QT_DEBUG )
    cout << __func__ << ":" << __LINE__ << " "
	<< m_pRacev->m_pCANBusPort2->portName().toStdString() << endl;
#endif
    QObject::connect(
	this, &Can06Thread::issue,
	m_pRacev, &Racev::writeCAN06Data);
    // NG, hangs
#if 0
    emit this->issue(cmd_atz);
    sleep(1);
#endif

#if 1 // working example
    emit this->issue(cmd_atl1); // line feeds on for lines
    emit this->issue(cmd_ate0); // echo off
    emit this->issue(cmd_ath1); // header on
    // emit this->issue(cmd_atspa); // with or without will do ( default )
    // emit this->issue(cmd_atdp);
#endif

#if 0 // FIXME: testing STM...
    emit this->issue(cmd_atl1); // line feeds on for lines
    emit this->issue(cmd_ate0); // echo off
    emit this->issue(cmd_ath1);
    emit this->issue(cmd_atspa);
    //emit this->issue(cmd_atdp);

    // emit this->issue(cmd_stp_42); // required?
    emit this->issue(cmd_ate0); // echo off
    emit this->issue(cmd_atl1); // line feeds on for lines
    //emit this->issue(cmd_ath1); // to get(parse) address?
    emit this->issue(cmd_stfac);
    emit this->issue(cmd_atws);
    emit this->issue(cmd_stcmm_1);
    emit this->issue(cmd_stfpga_ff00);
    emit this->issue(cmd_stm); // testing
#endif
    while ( !QThread::currentThread()->isInterruptionRequested() ) {
	// cout << __func__ << ":" << __LINE__ << endl;
	//launchScript();

	// emit this->issue(cmd_ati);
	// emit this->issue(cmd_atma); // this works
	// emit this->issue(cmd_pgn_00ff00); // ok
	if ( count < 3 ) {
#if 0
	    if ( 0 == m_iPollingTurn ) {
		cout << __func__ << ":" << __LINE__
		    << " [" << at_cmds[m_iPollingTurn].toStdString() << "]..." << endl;
	    }
#endif
	    emit this->issue(/*m_Commands*/at_cmds[m_iPollingTurn]); // current command, works
	    msleep(/*m_CommandTimings*/at_cmd_timings[m_iPollingTurn]);
	    count++;
	}
	else {
	    count = 0;
	    m_iPollingTurn++;
	    if ( MAX_NUM_COMMANDS-1 < m_iPollingTurn ) {
		m_iPollingTurn = 0;
	    }
	    continue;
	}
    }
    // reset module whenever program close ( provide port opened )
    emit this->issue(cmd_atz);
    msleep(1000);
    cout << __func__ << ":" << __LINE__ << " close -" << endl;
}

// TODO: calling QProcess output ( but overhead is considerable )
// QProcess example: ( https://to.ly/1zhGD )
int Can06Thread::launchScript(void) {
    // absolute path required
    // user racev must have joined dialout group
    QString program = "/usr/bin/minicom";
    QStringList arguments;
    // arguments << "-v";
    //All the other arguments
    arguments << "-b 115200" << "-D /dev/ttyUSB0" << "-w";
    arguments << "-C output.txt" << "-S voib-can06.txt";

    //qDebug() << __func__ << ":" << __LINE__
    //	<< " cmd '" << program << " " << arguments << "'";

    QProcess myProcess;
    myProcess.start(program, arguments);
    if (!myProcess.waitForStarted())
        return false;
    //myProcess.write("Qt rocks!");
    //myProcess.closeWriteChannel();
    //cout << __func__ << ":" << __LINE__ << "*" << endl;
    //QByteArray result = myProcess.readAll();
    if (!myProcess.waitForFinished())
	qDebug() << "failed:" << myProcess.errorString();
    else
	qDebug() << "output:" << myProcess.readAll();
    //cout << __func__ << ":" << __LINE__ << "-" << endl;
    return 0;
}
#endif
