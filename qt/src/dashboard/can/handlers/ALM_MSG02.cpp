#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "ALM_MSG02.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG02::ALM_MSG02
///
/// HMI context
///
Handler_ALM_MSG02::Handler_ALM_MSG02(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_ALM_MSG02() +";
}

Handler_ALM_MSG02::~Handler_ALM_MSG02() {
    //qDebug() << "Handler_ALM_MSG02() ~";
}

void Handler_ALM_MSG02::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    // QObject* pCurrentWindow = nullptr;

#if 0 // defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< hex << pDstVw << dec << endl;
#endif
    try {
	// TODO: nullptr check and valid payload size
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	m_Frame = *pframe; // assign to member ASAP
	payload = m_Frame.payload();

	// TODO: to be defined
	// ALM_MSG_02
	// B0[0:7] 129 - 136
	// B1[0:7] 137 - 144
	// B2[0:7] 145 - 152
	// B3[0:7] 153 - 160
	// B4[0:7] 161 - 168
	// B5[0:7] 169 - 176
	// B6[0:7] 177 - 184
	// B7[0:7] 185 - 192

#if 0
	p_info->handleAlarmBits(2, 0, prev_payload, payload,
	    &p_info->is_cooling_water_olet_temp_sensor_abnormal,
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    NULL, NULL, NULL);
#endif

    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception "
	    << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

