#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "BMS_VCU_MSG02.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_BMS_VCU_MSG02::BMS_VCU_MSG02
///
/// HMI context
///
Handler_BMS_VCU_MSG02::Handler_BMS_VCU_MSG02(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_BMS_VCU_MSG02() +";
}

Handler_BMS_VCU_MSG02::~Handler_BMS_VCU_MSG02() {
    //qDebug() << "Handler_BMS_VCU_MSG02() ~";
}

void Handler_BMS_VCU_MSG02::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    QString s_cmaxv;
    QString s_cminv;
    float cell_diffv = 0; QString s_cdiffv;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);

    //cout << typeid(*this).name() << "::" << __func__ << ":" << __LINE__ << " + "<< endl;
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    cout << __FILE__ << ":" << __LINE__ << " !" << endl;
	    goto ERROR_HANDLER;
	}
	p_racev->m_pInfo->cell_maxv = static_cast<float>(
	    (payload[0]&0xFF) + ((payload[1]&0xFF)<<8) );
	p_racev->m_pInfo->cell_maxv *= static_cast<float>(FACTOR_CELLV);
	if ( p_racev->m_pInfo->cell_maxv < MIN_V_CELL )
	    p_racev->m_pInfo->cell_maxv = MIN_V_CELL;
	if ( MAX_V_CELL < p_racev->m_pInfo->cell_maxv )
	    p_racev->m_pInfo->cell_maxv = MAX_V_CELL;
	s_cmaxv = QString::number(
	    static_cast<double>(p_racev->m_pInfo->cell_maxv), 'f', 3);
	p_racev->m_pInfo->cell_maxi = (payload[2]&0xFF) + OFFSET_CELL_INDEX;

	p_racev->m_pInfo->cell_minv = static_cast<float>(
	    (payload[3]&0xFF) + ((payload[4]&0xFF)<<8) );
	p_racev->m_pInfo->cell_minv *= static_cast<float>(FACTOR_CELLV);
	if ( p_racev->m_pInfo->cell_minv < MIN_V_CELL )
	    p_racev->m_pInfo->cell_minv = MIN_V_CELL;
	if ( MAX_V_CELL < p_racev->m_pInfo->cell_minv )
	    p_racev->m_pInfo->cell_minv = MAX_V_CELL;
	s_cminv = QString::number(
	    static_cast<double>(p_racev->m_pInfo->cell_minv), 'f', 3);
	p_racev->m_pInfo->cell_mini = (payload[5]&0xFF) + OFFSET_CELL_INDEX;

	cell_diffv = static_cast<float>(
	    (payload[6]&0xFF) + ((payload[7]&0xFF)<<8) );
	cell_diffv *= static_cast<float>(FACTOR_CELLV);
	s_cdiffv = QString::number(static_cast<double>(cell_diffv), 'f', 3);
#if 0
	qDebug() << "s_cmaxv" << s_cmaxv
	<< "cell_maxi" << cell_maxi
	<< "s_cminv" << s_cminv
	<< "cell_mini" << cell_mini
	<< "s_cdiffv" << s_cdiffv;
#endif
	QMetaObject::invokeMethod(pDstVw, "updateBMS_VCU_MSG02",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_cmaxv),
	    Q_ARG(QVariant, p_racev->m_pInfo->cell_maxi),
	    Q_ARG(QVariant, s_cminv),
	    Q_ARG(QVariant, p_racev->m_pInfo->cell_mini),
	    Q_ARG(QVariant, s_cdiffv));
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

