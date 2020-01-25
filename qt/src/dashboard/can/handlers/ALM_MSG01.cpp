#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "ALM_MSG01.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_ALM_MSG01::ALM_MSG01
///
/// HMI context
///
Handler_ALM_MSG01::Handler_ALM_MSG01(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_ALM_MSG01() +";
}

Handler_ALM_MSG01::~Handler_ALM_MSG01() {
    //qDebug() << "Handler_ALM_MSG01() ~";
}

void Handler_ALM_MSG01::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray prev_payload, payload;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    QObject* pCurrentWindow = nullptr;

#if 0 // defined ( QT_DEBUG )
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

	// TODO:
	// ALM_MSG_01
	// B0[0:7]  65 -  72
	// B1[0:7]  73 -  80
	// B2[0:7]  81 -  88
	// B3[0:7]  89 -  96
	// B4[0:7]  97 - 104
	// B5[0:7] 105 - 112
	// B6[0:7] 113 - 120
	// B7[0:7] 121 - 128
	m_prevFrame = m_Frame; // keep for next compare
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

