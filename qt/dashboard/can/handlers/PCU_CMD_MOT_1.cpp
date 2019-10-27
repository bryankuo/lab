#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "PCU_CMD_MOT_1.h"

///
/// \brief Handler_PCU_CMD_MOT_1::PCU_CMD_MOT_1
///
/// HMI context
///
Handler_PCU_CMD_MOT_1::Handler_PCU_CMD_MOT_1(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_PCU_CMD_MOT_1() +";
}

Handler_PCU_CMD_MOT_1::~Handler_PCU_CMD_MOT_1() {
    //qDebug() << "Handler_PCU_CMD_MOT_1() ~";
}

void Handler_PCU_CMD_MOT_1::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; int i = 0; QByteArray payload;
    int ctrl_mode = 0, mtr_cmd = 0;
    QString s_ctrl_mode, s_mtr_cmd;
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
	i = 0; ctrl_mode = (payload[i]&0x0F); mtr_cmd = ((payload[i]&0x30)>>4);
#if 0
	cout << __func__ << ":" << __LINE__ << " "
	    << std::hex << "0x" << ctrl_mode << " 0x" << mtr_cmd << std::dec
	    << endl;
#endif
	switch ( ctrl_mode ) {
	    case 0 : s_ctrl_mode = "MOTOR SPEED"; break;
	    case 1 : s_ctrl_mode = "MOTOR TORQUE"; break;
	    case 2 : s_ctrl_mode = "DC LINK VOLTAGE"; break;
	    case 3 : s_ctrl_mode = "NOT APPLICABLE"; break;
	    case 4 : s_ctrl_mode = "MOTOR POWER"; break;
	    case 5 : s_ctrl_mode = "NOT APPLICABLE"; break;
	    case 6 : s_ctrl_mode = "NOT APPLICABLE"; break;
	    case 7 : s_ctrl_mode = "OUTPUT FREQUENCY"; break;
	    case 8 ... 14 : s_ctrl_mode = "RESERVED"; break;
	    case 15 : s_ctrl_mode = "PARAMETER SELECT"; break;
	}
	switch ( mtr_cmd ) {
	    case 0 : s_mtr_cmd = "OFF"; break;
	    case 1 : s_mtr_cmd = "ON"; break;
	    case 2 : s_mtr_cmd = "RESERVED"; break;
	    case 3 : s_mtr_cmd = "NO ACTION"; break;
	}
	QMetaObject::invokeMethod(pDstVw, "updateMsg_PCU_CMD_MOT_1",
	    Qt::BlockingQueuedConnection,
	    Q_RETURN_ARG(QVariant, returnedValue),
	    Q_ARG(QVariant, s_ctrl_mode),
	    Q_ARG(QVariant, s_mtr_cmd));
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

