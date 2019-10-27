#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "TPMS_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_TPMS_MSG01::TPMS_MSG01
///
/// HMI context
///
Handler_TPMS_MSG01::Handler_TPMS_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_TPMS_MSG01() +";
}

Handler_TPMS_MSG01::~Handler_TPMS_MSG01() {
    //qDebug() << "Handler_TPMS_MSG01() ~";
}

void Handler_TPMS_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    unsigned int ax,tyr,conn,deflat,ht_a,pr_alarm;
    float prssr, temp, drop_rate;
    QString s_prssr, s_temp, s_drop_rate;
    //Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
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
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << mx_allowed_chg_current << " " << s_mx_allowed_chg_current;
#endif
	ax  = ((payload[0]&0xF0)>>4);
	tyr = (payload[0]&0x0F);
	prssr = static_cast<float>((payload[1]&0xFF));
	prssr *= static_cast<float>(FACTOR_APRESSURE);
	if ( ULIMIT_TPMS_AIRP < prssr ) {
	    prssr = ULIMIT_TPMS_AIRP;
	}
	if ( prssr < LLIMIT_TPMS_AIRP ) {
	    prssr = LLIMIT_TPMS_AIRP;
	}
	s_prssr = QString::number(static_cast<double>(prssr), 'f', 1);

	temp = static_cast<float>(
	    (payload[2]&0xFF)+((payload[3]&0xFF)<<8));
	temp *= static_cast<float>(FACTOR_SCALE);
	temp += static_cast<float>(OFFSET_KELVIN);
	if ( ULIMIT_TTEMP < temp ) {
	    temp = ULIMIT_TTEMP;
	}
	if ( temp < LLIMIT_TTEMP ) {
	    temp = LLIMIT_TTEMP;
	}
	s_temp = QString::number(static_cast<double>(temp), 'f', 0);
	conn = (payload[4]&0x0F);
	deflat = ((payload[4]&0x30)>>4);
	ht_a = ((payload[4]&0xC0)>>6);

	drop_rate = static_cast<float>(
	    (payload[5]&0xFF)+((payload[6]&0xFF)<<8));
	drop_rate *= static_cast<float>(FACTOR_PA);
	drop_rate *= static_cast<float>(FACTOR_BAR);
	if ( ULIMIT_FRATE < drop_rate ) {
	    drop_rate = ULIMIT_FRATE;
	}
	if ( drop_rate < LLIMIT_FRATE ) {
	    drop_rate = LLIMIT_FRATE;
	}
	s_drop_rate =
	    QString::number(static_cast<double>(drop_rate), 'f', 3);
	pr_alarm = ((payload[7]&0xE0)>>5);
	QMetaObject::invokeMethod(pDstVw, "updateMsg_TPMS_MSG01",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, ax),
	    Q_ARG(QVariant, tyr),
	    Q_ARG(QVariant, s_prssr),
	    Q_ARG(QVariant, s_temp),
	    Q_ARG(QVariant, conn),
	    Q_ARG(QVariant, deflat), /* diff. name than QML to protect */
	    Q_ARG(QVariant, ht_a),
	    Q_ARG(QVariant, s_drop_rate),
	    Q_ARG(QVariant, pr_alarm));

    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

