#include <iostream>
#include <iomanip>
#include <stdexcept>

#include <QDateTime>
#include <QDebug>

#include "frameparser.h"
#include "info.h"
#include "racev.h"

FrameParser::FrameParser(QObject* p_racev)
    :m_bamTempMsgMap(0),m_bamVoltMsgMap(0),
    m_pRacev(p_racev),m_pInfo(nullptr),m_iBamLength(0),
    m_iBamBody(0),m_iBamBodyIndex(0),// m_init(0),
    m_bamVoltSequenceNum(0),
    m_bamTempSequenceNum(0),
    m_bamT1VoltStop(UINT_MAX),
    m_bamT1TempStop(UINT_MAX),
    m_bamNumFrame(0),m_bamMessageLen(0)
{

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" <<  __LINE__ << " " << __func__ << " +" << endl;
#endif
    // How to convert from QObject to UI elements?
    // ( https://goo.gl/muFuqg )
    Racev *p_racev1 = qobject_cast<Racev*>(m_pRacev);
    m_pInfo = p_racev1->m_pInfo;
}

void FrameParser::doParse(/*const QString &parameter*/) { // consider passing racev as parameter
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QCanBusFrame* pframe = nullptr;
#if defined ( EN_IPC_ )
    // QMutexLocker locker(&m_pRacev->m_CANBusFrameQueueMutex);
    // @see https://tinyurl.com/tg5p7y3
#endif
    // ... here is the expensive or blocking operation ...

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " +" << endl;
#endif

    do {
	usleep(1*1000);
#if defined ( EN_IPC_ )
	p_racev->m_CANBusFrameQueueMutex.lock();
#endif
	if ( p_racev->m_CANBusCircularBufferTail
	    != p_racev->m_CANBusCircularBufferHead ) {
	    // there at least one frame

	    pframe = &p_racev
		->m_CANBusCircularBuffer[p_racev->m_CANBusCircularBufferTail];

	    // read one
#if defined ( _TRACE_HEAD_TAIL_ )
	    cout << __FILE__ << ":" <<  __LINE__ << " " << __func__
		<< " tail " << setfill('0') << setw(2) << p_racev->m_CANBusCircularBufferTail
		<< " pframe " << pframe
		<< endl;
#endif
	    // parsing here and emit signal
	    // if split then no segfault found
#if defined ( EN_PARSER_THREAD_ )
	    if ( pframe->frameId() && 0 < pframe->payload().size() ) {
		this->parse(pframe);
	    }
	    // TODO: for each hander,
	    // there is no need checking size of frame
	    // if we do the check here ( upstream )
#endif

	    p_racev->m_CANBusCircularBufferTail++; // finished
	    // parsing and emit signal here

	    if ( NUM_CANCB <= p_racev->m_CANBusCircularBufferTail ) {
		p_racev->m_CANBusCircularBufferTail = 0;
		// solving extra frame signaled by set mem. zero
		// such that charging state interfered
		//	we use frame id as identification instead of memset
		p_racev->m_CANBusCircularBuffer[NUM_CANCB-1].setFrameId(0);
	    }
	    else {
		p_racev
		    ->m_CANBusCircularBuffer[p_racev->m_CANBusCircularBufferTail-1]
		    .setFrameId(0);
	    }
	    // TODO: consider set payload length to 0 if finished
	}


#if defined ( EN_IPC_ )
	p_racev->m_CANBusFrameQueueMutex.unlock();
	// p_racev->m_CANBusFrameQueueWaitCondition.wakeAll();
	// FIXME: more than 2 concurrent access
#endif

    } while ( 1 ); // assume always running until shutdown
}

int FrameParser::parse()
{
    int rc = 0;
    return rc;
}

/*
 * rc = 1 (handled)
 * */
int FrameParser::handleBAM_Voltage(QCanBusFrame* pframe) {
    int rc = 0;
    qint64 current_ts = 0;
#if 0
    std::cout << __func__ << ":" <<  __LINE__ << " +" << endl;
#endif
    // if we do assume starting from 1, a timer counter start ticking...
    // for efficiency, we should receive and update whenever messages arrives
    if ( m_bamT1VoltStop == UINT_MAX ) {
#if defined ( TRACK_BAM_ )
	std::cout << __func__ << ":" << __LINE__
	    << " vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
	    << endl;
#endif
	m_bamVoltSequenceNum = 0;
	m_bamVoltMsgMap = 0;
	m_bamVoltGateOn = true;
	// assume interleave, each BAM has its own state machine.
	current_ts = QDateTime::currentMSecsSinceEpoch();
	m_bamT1VoltStop = current_ts + BAM_T1_MS;
    }
    else {
	//std::cout << __func__ << ":" << __LINE__ << " v og " << endl;
    }
    return rc;
}

int FrameParser::handleBAM_Temperature(QCanBusFrame* pframe) {
    int rc = 0;
    quint32 current_ts = 0;
#if 0
    std::cout << __func__ << ":" <<  __LINE__ << " +" << endl;
#endif
    // if we do assume starting from 1, a timer counter start ticking...
    // for efficiency, we should receive and update whenever messages arrives
    if ( m_bamT1TempStop == UINT_MAX ) {
#if defined ( TRACK_BAM_ )
	std::cout << __func__ << ":" << __LINE__
	    << " tttttttttttttttttttttttttttttttttttttt"
	    << endl;
#endif
	// m_bamTempSequenceNum = 0;
	// m_bamTempMsgMap = 0;
	m_bamTempGateOn = true;
	// assume interleave, each BAM has its own state machine.
	current_ts = QDateTime::currentMSecsSinceEpoch();
	m_bamT1TempStop = current_ts + BAM_T1_MS;
    }
    else {
	//std::cout << __func__ << ":" << __LINE__ << " t og " << endl;
    }
    return rc;
}

int FrameParser::handleBAM_VoltageTpdt(QCanBusFrame* pframe, quint32 seq_num) {
    int rc = 0, i;
    quint32 current_ts = 0;
#if 0
    std::cout << __func__ << ":" << __LINE__
	<< " + " << seq_num << endl;
#endif
    ++m_bamVoltSequenceNum; // expected
    // m_pInfo->cached_cell_voltage.insert(seq_num, *pframe); // TODO: to be obselete
#if 1
    for ( i = 0; i < NUM_BYTE_FRAME; i++ ) {
	// there are 7 data bytes in a frame
	m_pInfo->cell_voltage[( seq_num - 1 )*NUM_BYTE_FRAME + i]
	    = pframe->payload().at(i+1);
    }
#endif
#if 0
    // show every data byte
    cout << "vtpdt:" << __LINE__ << " seq " << seq_num << " ";
    for ( i = 0; i < NUM_BYTE_FRAME; i++ ) {
	cout << "0x" << setw(2) << hex << pframe->payload()[i+1] << " ";
    }
    cout << "m 0x" << setfill('0') << setw(16) << m_bamVoltMsgMap;
    cout << dec;
    cout << endl;
#endif
    m_bamVoltMsgMap |= (1<<(seq_num-1));
    if ( m_bamT1VoltStop < current_ts ) {
	std::cout << __func__ << ":" << __LINE__ << " v tmout " << endl;
	m_bamT1VoltStop = UINT_MAX;
	// timeout
	m_bamVoltGateOn = false;
    }
    else {
	if ( seq_num != m_bamVoltSequenceNum ) {
	    m_bamVoltSequenceNum = seq_num+1;
	}
	if ( m_bamVoltSequenceNum < BAM_CELL_NUM_FRAME ) {
	    current_ts = QDateTime::currentMSecsSinceEpoch();
	    m_bamT1VoltStop = current_ts + BAM_T1_MS;
	}
	else {
	    m_bamT1VoltStop = UINT_MAX;
	    // finished
	    m_bamVoltGateOn = false;
	}
    }
    return rc;
}

int FrameParser::handleBAM_TemperatureTpdt(QCanBusFrame* pframe, quint32 seq_num) {
    int rc = 0, i;
    quint32 current_ts = 0;
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + " << endl;
#endif
    try {
	// QByteArray to std::string @see https://tinyurl.com/y59nkw48
	// std::string stdString(pframe->payload().constData(), pframe->payload().length());
	// qDebug() << __func__ << ":" << __LINE__
	//    << " + " << seq_num << " " << pframe->payload().toHex(0);
	m_pInfo->m_TemperatureMutex.lock();
	for ( i = 0; i < NUM_BYTE_FRAME; i++ ) {
	    // there are 7 data bytes in a frame
	    m_pInfo->probe_temperature[( seq_num - 1 )*NUM_BYTE_FRAME + i]
		= pframe->payload().at(i+1);
	}
	m_pInfo->m_TemperatureMutex.unlock();
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    ++m_bamTempSequenceNum; // expected
    // m_pInfo->cached_probe_temperature.insert(seq_num, *pframe); // to be obselete
    // TODO: assign to new position
    m_bamTempMsgMap |= (1<<(seq_num-1));
    if ( m_bamT1TempStop < current_ts ) {
	std::cout << __func__ << ":" << __LINE__ << " t tmout " << endl;
	m_bamT1TempStop = UINT_MAX;
	// timeout
	m_bamTempGateOn = false;
    }
    else {
	if ( seq_num != m_bamTempSequenceNum ) {
	    m_bamTempSequenceNum = seq_num+1;
	}
	if ( m_bamTempSequenceNum < BAM_PROB_NUM_FRAME ) {
	    current_ts = QDateTime::currentMSecsSinceEpoch();
	    m_bamT1TempStop = current_ts + BAM_T1_MS;
	}
	else {
	    m_bamT1TempStop = UINT_MAX;
	    // finished
	    m_bamTempGateOn = false;
	}
    }
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " - " << endl;
#endif
    return rc;
}

#define NUM_BYTES_CHECK 7
// design doc: BAM-tpdt-identification.drawio
bool FrameParser::isAtLeastXBytesGreaterThanCriteria(
	QByteArray payload, int n_bytes, unsigned char criteria) {
    int i = 0; int count = 0;

    try {
	for ( i = 0; i < NUM_BYTES_CHECK; i++ ) {
	    if ( criteria < (payload[i]&0xFF) )
		++count;
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    return ( (n_bytes <= count) ? true : false );
}

#define EN_CRITERIA_
#define MAX_NUM_TPDT_TEMPERATURE 7
// rc = 1 parsed
int FrameParser::parseBAM(QCanBusFrame* pframe) {
    int rc = 0;
    quint32 seq_num = 0; quint32 fid = 0;
    qint64 current_ts = 0;
    QByteArray payload;
#if defined ( TRACK_BAM_ )
    Racev *p_racev1 = qobject_cast<Racev*>(m_pRacev);
#endif

#if 0
    std::cout << __func__ << ":" <<  __LINE__ << " +" << endl;
#endif
    try {
	fid = pframe->frameId();
	payload = pframe->payload();
	switch ( fid ) {
	    case J1939_BAM_HEAD:
		//std::cout << __func__ << ":" << __LINE__ << endl;
		//m_bamMessageLen = ((payload[2]&0xFF)<<8)+(payload[1]&0xFF);
		//m_bamNumFrame = (payload[3]&0xFF);
		// TODO: TP.CM_BAM paremeters
		if ( !((payload[5]&0xFF)^J1939_BAM_VLTG) ) {
		    handleBAM_Voltage(pframe);
		}
		else if (!((payload[5]&0xFF)^J1939_BAM_TEMP) ) {
		    handleBAM_Temperature(pframe);
		}
		else {
		    /* unidentified BAM, to be revealed */
		    std::cout << __func__ << ":" << __LINE__
			<< " u.tp.cm_bam " << static_cast<int>(payload[5]) << endl;
		}
		break;
	    case J1939_BAM_BODY:
		current_ts = QDateTime::currentMSecsSinceEpoch();
		seq_num = (payload[0]&0xFF);
#if defined ( TRACK_BAM_ )
		std::cout << __func__ << ":" << std::dec << __LINE__ << " "
		<< setfill('0') << setw(4) << std::dec << current_ts%10000 << " "
		<< setfill('0') << setw(2) << seq_num << " "
		    << setw(1)  << m_bamVoltGateOn
		    << setw(1)  << m_bamTempGateOn << " "
		    << setw(2)  << m_bamVoltSequenceNum << " "
		    << setw(4)  << m_bamT1VoltStop%10000 << " "
	    << "0x" << setw(8)  << hex << m_bamVoltMsgMap << std::dec << " "
		    << setw(2)  << m_bamTempSequenceNum << " "
		    << setw(4)  << m_bamT1TempStop%10000 << " "
	    << "0x" << setw(2)  << hex << m_bamTempMsgMap << std::dec << " "
		    << setw(2)  << p_racev1->m_CANBusCircularBufferHead << " "
		    << setw(2)  << p_racev1->m_CANBusCircularBufferTail << " "
		    << endl;
#endif

#if defined ( EN_CRITERIA_ )
		// design doc: BAM-tpdt-identification.drawio
		if ( MAX_NUM_TPDT_TEMPERATURE < seq_num ) {
		    handleBAM_VoltageTpdt(pframe, seq_num);
		}
		else if ( MAX_NUM_TPDT_TEMPERATURE == seq_num ) {
		    // temperature last byte ending 0xff
		    if ( 0xFF == (payload[7]&0xFF) )
			handleBAM_TemperatureTpdt(pframe, seq_num);
		    else
			handleBAM_VoltageTpdt(pframe, seq_num);
		}
		else { // MAX_NUM_TPDT_TEMPERATURE > seq_num
		    if ( isAtLeastXBytesGreaterThanCriteria(payload, 4, 0x20) ) {
			handleBAM_TemperatureTpdt(pframe, seq_num);
		    }
		    else {
			handleBAM_VoltageTpdt(pframe, seq_num);
		    }
		}
#else
		if ( m_bamVoltGateOn ) {
		    //Q_ASSERT( m_bamMessageLen == BAM_CELL_VOLT );
		    handleBAM_VoltageTpdt(pframe, seq_num);
		}
		else if ( m_bamTempGateOn ) {
		    //Q_ASSERT( m_bamMessageLen == BAM_PROB_TEMP );
		    handleBAM_TemperatureTpdt(pframe, seq_num);
		}
		else {
		    /* unidentified BAM TP.DT, to be revealed */
#if 1
		    std::cout << __func__ << ":" << __LINE__
			<< " u.tp.dt sq# " << static_cast<int>(payload[0]&0xFF) << endl;
#endif
		}
#endif
		break;
	    default:
		/* unidentified frame id, to be revealed */
		std::cout << __func__ << ":" << __LINE__
		    << " u.fid 0x" << hex << fid << dec << endl;
		break;
	}
	rc = 1;
	// TODO: emit canSignalFrame(fid, pframe); in case there is need to latest update
    } catch (const std::exception& ex) {
        cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
    return rc;
}

int FrameParser::parse(QCanBusFrame* pframe) {
    int rc = 0;
    quint32 fid = 0;
    // QByteArray payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< __func__ << " + " << endl;
#endif

    try {
	Q_ASSERT( pframe != nullptr );
	fid = pframe->frameId();
	if ( fid == J1939_BAM_HEAD || fid == J1939_BAM_BODY ) {
	    rc = parseBAM(pframe);
	}
	else {
	    switch ( fid ) {
	    // VCU
	    case VCU_HMI_Msg_1:
		m_pInfo->FrameVCU_HMI_MSG01 = *pframe;
		//  note: must assign, or trying find a better solution
		emit canSignalFrame(fid, pframe);
		// can pointer to QCanBusFrame be parameter?
	    break;
	    case VCU_HMI_Msg_2:
		m_pInfo->FrameVCU_HMI_MSG02 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_HMI_Msg_3:
		m_pInfo->FrameVCU_HMI_MSG03 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_HMI_Msg_4:
		m_pInfo->FrameVCU_HMI_MSG04 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_PWR_STATUS:
		m_pInfo->FrameVCU_PWR_STATUS = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_IOSIG_MSG:
		m_pInfo->FrameVCU_IOSIG_MSG = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_DIAG01:
		m_pInfo->FrameVCU_DIAG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case VCU_DIAG02:
		m_pInfo->FrameVCU_DIAG02 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    // BMS
	    case BMS_VCU_Msg01:
		m_pInfo->FrameBMS_VCU_MSG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BMS_VCU_Msg02:
		m_pInfo->FrameBMS_VCU_MSG02 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BMS_VCU_Msg03:
		m_pInfo->FrameBMS_VCU_MSG03 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BMS_VCU_Msg04:
		m_pInfo->FrameBMS_VCU_MSG04 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BMS_OBC_MSG01:
		m_pInfo->FrameBMS_OBC_MSG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BMS_CMUERR_MSG01:
		m_pInfo->FrameBMS_CMUERR_MSG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BCU_VCU_MSG0:
		m_pInfo->FrameBCU_VCU_MSG0 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case BCU_VCU_SMD:
		m_pInfo->FrameBCU_VCU_SMD = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    // PCU
	    case PCU_ST_MOT_1:
		m_pInfo->FramePCU_ST_MOT_1 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_ST_MOT_2:
		m_pInfo->FramePCU_ST_MOT_2 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_ST_MOT_3:
		m_pInfo->FramePCU_ST_MOT_3 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    case PCU_ST_SYS_1:
		m_pInfo->FramePCU_ST_SYS_1 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_ST_SYS_2:
		m_pInfo->FramePCU_ST_SYS_2 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_ST_SYS_3:
		m_pInfo->FramePCU_ST_SYS_3 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_ST_SYS_4:
		m_pInfo->FramePCU_ST_SYS_4 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    case PCU_CMD_MOT_1:
		m_pInfo->FramePCU_CMD_MOT_1 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_CMD_MOT_2:
		m_pInfo->FramePCU_CMD_MOT_2 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case PCU_CMD_MOT_3:
		m_pInfo->FramePCU_CMD_MOT_3 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    // TODO: implement when there is a receiver
	    //case PCU_IO_SIG00:
	    //	m_pInfo->FramePCU_IO_SIG00 = *pframe;
	    //	emit canSignalFrame(fid, pframe);
	    //break;

	    case PCU_CMD_SYS_1:
		m_pInfo->FramePCU_CMD_SYS_1 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    // DCDC
	    // ALM_MSG_04
	    case DCDC_MSG00:
		m_pInfo->FrameDCDC_MSG00 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

#if 0
	    // TPMS
	    case TPMS_MSG01:
		m_pInfo->FrameTPMS_MSG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case TPMS_MSG02:
		m_pInfo->FrameTPMS_MSG02 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
#endif

	    // ALARM
	    case ALM_MSG_00:
		m_pInfo->FrameALM_MSG_00 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case ALM_MSG_01:
		m_pInfo->FrameALM_MSG_01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case ALM_MSG_02:
		m_pInfo->FrameALM_MSG_02 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    case ALM_MSG_03:
		m_pInfo->FrameALM_MSG_03 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;
	    // case ALM_MSG_04: // DCDC_MSG00
	    // break;
	    case BCU_ER_MSG01: // ALM_MSG05
		m_pInfo->FrameBCU_ER_MSG01 = *pframe;
		emit canSignalFrame(fid, pframe);
	    break;

	    default:
#if 0 //defined ( QT_DEBUG )
		cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " "
		    "type 0x" << setw(2) << hex << pframe->frameType() << std::dec << " "
		    "id  0x" << setw(8) << hex << fid << std::dec << " " << endl;
#endif
	    break;
	    }


	    rc = 1;
	}
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__
	    << " exception " << ex.what() << endl;
    }
#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " "
	<< __func__ << " - " << endl;
#endif
    return rc;
}
