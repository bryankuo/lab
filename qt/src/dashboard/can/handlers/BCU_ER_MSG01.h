#ifndef BCU_ER_MSG01_H
#define BCU_ER_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BCU_ER_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_BCU_ER_MSG01(QObject* p_racev);
    ~Handler_BCU_ER_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
signals:
    void signalBmsErMSG01B3ANDB7(
	const QString &s_bcu_alarm_lcounter, int bms_ierr,
	int vsam_err, int tsam_err, int ccom_err, int cer_err,
	int chot, int ch_scerr, int ch_wcerr);
    void signalBmsErMSG01B0(
	int ch_shv,
	int ds_shv,
	int ch_whv,
	int ds_whv,
	int ds_slv,
	int ds_wlv,
	int ds_hdv,
	int ds_lsoc);
    void signalBmsErMSG01B1(
	int sht_ch,
	int sht_ds,
	int wht_ch,
	int wht_ds,
	int slt_ch,
	int slt_ds,
	int wlt_ch,
	int wlt_ds);
    void signalBmsErMSG01B2(
	int oc_ch,
	int oc_ds);
    void signalBmsErMSG01B4(
	int issl_ch,
	int issl_ds,
	int iswl_ch,
	int iswl_ds,
	int hvil_ch,
	int hvil_ds);
    void signalBmsErMSG01B5(
	int c1,
	int c2,
	int c3,
	int c4,
	int c5,
	int c6,
	int c7,
	int c8);

    void signalBmsErMSG01B6(
	int c9,
	int c10,
	int c11,
	int c12,
	int c13,
	int c14,
	int chg,
	int bms);

private:
    QObject* m_pRacev;
    // a placeholder for signaled frame
    QCanBusFrame m_Frame;
    QCanBusFrame m_prevFrame;
};

#endif // BCU_ER_MSG01_H
