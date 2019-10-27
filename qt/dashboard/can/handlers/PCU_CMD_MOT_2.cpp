#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_CMD_MOT_2.h"

///
/// \brief Handler_PCU_CMD_MOT_2::PCU_CMD_MOT_2
///
/// HMI context
///
Handler_PCU_CMD_MOT_2::Handler_PCU_CMD_MOT_2(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_CMD_MOT_2() +";
}

Handler_PCU_CMD_MOT_2::~Handler_PCU_CMD_MOT_2() {
    //qDebug() << "Handler_PCU_CMD_MOT_2() ~";
}

void Handler_PCU_CMD_MOT_2::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    int torq_ref = 0;
    float rpm_ref = 0, dclv_ref = 0, mtpwr_ref = 0;
    QString s_rpm_ref, s_dclv_ref, s_mtpwr_ref;
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

	i = 0; rpm_ref = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_RPM );
	rpm_ref *= static_cast<float>(0.5);
	if ( ULIMIT_RPM < rpm_ref ) {
	    rpm_ref = ULIMIT_RPM;
	}
	if ( rpm_ref < LLIMIT_RPM ) {
	    rpm_ref = LLIMIT_RPM;
	}

	i = 2; torq_ref =
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_ATORQUE;
	// saturation control
	if ( ULIMIT_TORQUE < torq_ref ) {
	    torq_ref = ULIMIT_TORQUE;
	}
	if ( torq_ref < LLIMIT_TORQUE ) {
	    torq_ref = LLIMIT_TORQUE;
	}

	i = 4; dclv_ref = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) ) ;
	// saturation control
	dclv_ref *= static_cast<float>(0.05);
	if ( ULIMIT_DCLV < dclv_ref ) {
	    dclv_ref = ULIMIT_DCLV;
	}
	if ( dclv_ref < LLIMIT_DCLV ) {
	    dclv_ref = LLIMIT_DCLV;
	}

	i = 6; mtpwr_ref = static_cast<float>(
	    (payload[i]&0xFF) + ((payload[i+1]&0xFF)<<8) + OFFSET_MECHPWR );
	mtpwr_ref *= static_cast<float>(FACTOR_PWR);
	// saturation control
	if ( ULIMIT_MTPWR < mtpwr_ref ) {
	    mtpwr_ref = ULIMIT_MTPWR;
	}
	if ( mtpwr_ref < LLIMIT_MTPWR ) {
	    mtpwr_ref = LLIMIT_MTPWR;
	}

	s_rpm_ref = QString::number(static_cast<double>(rpm_ref), 'f', 1);
	s_dclv_ref = QString::number(static_cast<double>(dclv_ref), 'f', 2);
	s_mtpwr_ref = QString::number(static_cast<double>(mtpwr_ref), 'f', 3);

	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_CMD_MOT_2",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_rpm_ref),
	    Q_ARG(QVariant, torq_ref),
	    Q_ARG(QVariant, s_dclv_ref),
	    Q_ARG(QVariant, s_mtpwr_ref));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

