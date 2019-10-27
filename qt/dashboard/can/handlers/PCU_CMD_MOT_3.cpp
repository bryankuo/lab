#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_CMD_MOT_3.h"

///
/// \brief Handler_PCU_CMD_MOT_3::PCU_CMD_MOT_3
///
/// HMI context
///
Handler_PCU_CMD_MOT_3::Handler_PCU_CMD_MOT_3(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_CMD_MOT_3() +";
}

Handler_PCU_CMD_MOT_3::~Handler_PCU_CMD_MOT_3() {
    //qDebug() << "Handler_PCU_CMD_MOT_3() ~";
}

void Handler_PCU_CMD_MOT_3::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    float freq_ref = 0, reactive_pwr_ref = 0;
    QString s_freq_ref, s_reactive_pwr_ref;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( payload.isEmpty() || pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	i = 0; freq_ref = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_FREQ ) ;
	freq_ref *= static_cast<float>(FACTOR_FREQ);
	// saturation control
	if ( ULIMIT_FREQ< freq_ref ) {
	    freq_ref = ULIMIT_FREQ;
	}
	if ( freq_ref < LLIMIT_FREQ ) {
	    freq_ref = LLIMIT_FREQ;
	}

	i = 2; reactive_pwr_ref = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_MECHPWR ) ;
	reactive_pwr_ref *= static_cast<float>(FACTOR_PWR);
	if ( ULIMIT_MTPWR < reactive_pwr_ref ) {
	    reactive_pwr_ref = ULIMIT_MTPWR;
	}
	if ( reactive_pwr_ref < LLIMIT_MTPWR ) {
	    reactive_pwr_ref = LLIMIT_MTPWR;
	}
	// FIXME: if trailing zero then ignore.
	s_freq_ref = QString::number(static_cast<double>(freq_ref), 'f', 5);
	s_reactive_pwr_ref = QString::number(static_cast<double>(reactive_pwr_ref), 'f', 3);
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_CMD_MOT_3",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_freq_ref),
	    Q_ARG(QVariant, s_reactive_pwr_ref));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

