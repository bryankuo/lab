#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "ALM_MSG03.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG03::ALM_MSG03
///
/// HMI context
///
Handler_ALM_MSG03::Handler_ALM_MSG03(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_ALM_MSG03() +";
}

Handler_ALM_MSG03::~Handler_ALM_MSG03() {
    //qDebug() << "Handler_ALM_MSG03() ~";
}

void Handler_ALM_MSG03::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = nullptr;

#if defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< hex << pDstVw << dec << endl;
#endif
    try {
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
	// ALM_MSG_03
	// B0[0:7] 193 - 200
	// B1[0:7] 201 - 208
	// B2[0:7] 209 - 216
	// B3[0:7] 217 - 224
	// B4[0:7] 225 - 232
	// B5[0:7] 233 - 240
	// B6[0:7] 241 - 248
	// B7[0:7] 249 - 256

#if 0
	p_info->handleAlarmBits(3, 7, prev_payload, payload,
	    &p_info->is_cooling_water_olet_temp_sensor_abnormal,
	    NULL,
	    NULL,
	    NULL,
	    NULL,
	    NULL, NULL, NULL);
#endif

    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

