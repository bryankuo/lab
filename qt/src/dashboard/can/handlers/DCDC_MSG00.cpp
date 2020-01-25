#include <iostream>

#include <QDebug>
#include <QCanBusFrame>
#include <QByteArray>
#include <QVariant>

#include "../../constants.h"
#include "DCDC_MSG00.h"
#include "../../racev.h" // TODO: modify include path in project setting

///
/// \brief Handler_DCDC_MSG00::DCDC_MSG00
///
/// HMI context
///
Handler_DCDC_MSG00::Handler_DCDC_MSG00(QObject* p_racev = 0)
    :m_pRacev(p_racev)
{
    //qDebug() << "Handler_DCDC_MSG00() +";
}

Handler_DCDC_MSG00::~Handler_DCDC_MSG00() {
    //qDebug() << "Handler_DCDC_MSG00() ~";
}

void Handler_DCDC_MSG00::updateMsg(QCanBusFrame* pframe, QObject* pDstVw) {
    QVariant returnedValue; QByteArray prev_payload, payload;
    int output_under = 0, output_over = 0, input_under = 0,
	input_over = 0, fault_f = 0, w_mode = 0, d_rating = 0,
	input_oc = 0, ot = 0, output_oc = 0, i_dcdc_v = 0;
    QString s_real_oc, s_real_ov, s_real_iv;
    int i_reality_t = 0;
    double real_oc, real_ov, real_iv;
    Racev *p_racev = qobject_cast<Racev*>(m_pRacev);
    Info* p_info = p_racev->m_pInfo;
    QObject* pCurrentWindow = nullptr;

#if 0 //defined ( QT_DEBUG )
    cout << __FILE__ << ":" << __LINE__ << " " << __func__ << " + "
	<< hex << pDstVw << dec << endl;
#endif
    try {
	if ( nullptr == pframe ) {
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	// payload = pframe->payload();
	if ( pframe->payload().size() != 8 ) {
	    // ( http://tinyurl.com/yyzfux2f )
	    qDebug() << __FILE__ << ":" << __LINE__ << "!";
	    goto ERROR_HANDLER;
	}
	m_Frame = *pframe; // assign to member ASAP
	payload = m_Frame.payload();
	prev_payload = m_prevFrame.payload();

	output_under = (payload[0]&0x01);
	output_over = ((payload[0]&0x02)>>1);
	input_under = ((payload[0]&0x04)>>2);
	input_over = ((payload[0]&0x08)>>3);
	fault_f = ((payload[0]&0x10)>>4);
	w_mode = ((payload[0]&0xC0)>>6);
	d_rating = (payload[1]&0x01);
	input_oc = ((payload[1]&0x02)>>1);
	ot = ((payload[1]&0x04)>>2);
	output_oc = ((payload[1]&0x08)>>3);
	i_dcdc_v = (payload[7]&0xFF);

	real_oc = static_cast<double>(
	    ((payload[1]&0xF0)>>4) + ((payload[2]&0xFF)<<4) );
	real_oc *= static_cast<double>(FACTOR_CURRENT);
	if ( real_oc < LLIMIT_DC2_OC ) real_oc = LLIMIT_DC2_OC;
	if ( ULIMIT_DC2_OC < real_oc ) real_oc = ULIMIT_DC2_OC;
	s_real_oc = QString::number(static_cast<double>(real_oc), 'f', 1);

	i_reality_t = (payload[3]&0xFF) + OFFSET_DC2_TEMPOFFSET;

	real_ov = static_cast<double>(
	    (payload[4]&0xFF) + ((payload[5]&0x0F)<<8) );
	real_ov *= static_cast<double>(DC2_FACTOR_VOLTAGE);
	if ( real_ov < LLIMIT_DC2_OV ) real_ov = LLIMIT_DC2_OV;
	if ( ULIMIT_DC2_OV < real_ov ) real_ov = ULIMIT_DC2_OV;
	s_real_ov = QString::number(static_cast<double>(real_ov), 'f', 1);

	real_iv = static_cast<double>(
	    ((payload[5]&0xF0)>>4) + ((payload[6]&0xFF)<<4) );
	if ( real_iv < LLIMIT_DC2_IV ) real_iv = LLIMIT_DC2_IV;
	if ( ULIMIT_DC2_IV < real_iv ) real_iv = ULIMIT_DC2_IV;
	s_real_iv = QString::number(static_cast<double>(real_iv), 'f', 0);

	p_info->handleAlarmBits(4, 0, prev_payload, payload,
	    &p_info->is_DCDC_under_o_voltage,
	    &p_info->is_DCDC_over_o_voltage,
	    &p_info->is_DCDC_under_i_voltage,
	    &p_info->is_DCDC_under_i_voltage,
	    &p_info->is_DCDC_hwfault,
	    NULL, &p_info->is_DCDC_derating,
	    &p_info->is_DCDC_over_i_current);

	// B1[0:7] 265 - 272
	p_info->handleAlarmBits(4, 0, prev_payload, payload,
	    &p_info->is_DCDC_over_temperature,
	    &p_info->is_DCDC_over_o_current,
	    // B1[2:7] TBD
	    nullptr,
	    nullptr,
	    nullptr,
	    nullptr,
	    nullptr,
	    nullptr);

	pCurrentWindow = p_racev->getActiveWindow();
	if ( pCurrentWindow = p_racev->m_pWinDcdc ) {
#if defined ( EN_INVOKE_METHOD_ )
	    QMetaObject::invokeMethod(pCurrentWindow,
		"updateMsg_DCDC_MSG00_Byte0To1",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, output_under),
		Q_ARG(QVariant, output_over),
		Q_ARG(QVariant, input_under),
		Q_ARG(QVariant, input_over),
		Q_ARG(QVariant, fault_f),
		Q_ARG(QVariant, w_mode),
		Q_ARG(QVariant, d_rating),
		Q_ARG(QVariant, input_oc),
		Q_ARG(QVariant, ot),
		Q_ARG(QVariant, output_oc));

	    QMetaObject::invokeMethod(pCurrentWindow,
		"updateMsg_DCDC_MSG00_Byte1To7",
		Qt::DirectConnection,
		Q_RETURN_ARG(QVariant, returnedValue),
		Q_ARG(QVariant, s_real_oc),
		Q_ARG(QVariant, i_reality_t),
		Q_ARG(QVariant, s_real_ov),
		Q_ARG(QVariant, s_real_iv),
		Q_ARG(QVariant, i_dcdc_v));
#elif defined ( EN_PUSHING_REF2QML_ )
	    emit signalDcdcMSG00B01(output_under,
		output_over,
		input_under,
		input_over,
		fault_f,
		w_mode,
		d_rating,
		input_oc,
		ot,
		output_oc);

	    emit signalDcdcMSG00B17(s_real_oc,
		i_reality_t,
		s_real_ov,
		s_real_iv,
		i_dcdc_v);
#endif
	}
	m_prevFrame = m_Frame; // keep for next compare
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__ << " exception " << ex.what() << endl;
    }
ERROR_HANDLER:
    //cout << __func__ <<":"<< __LINE__ << " - "<< endl;
    return;
}

