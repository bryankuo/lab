#ifndef DCDC_MSG00_H
#define DCDC_MSG00_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_DCDC_MSG00 : public QObject
{
    Q_OBJECT
public:
    Handler_DCDC_MSG00(QObject* p_racev);
    ~Handler_DCDC_MSG00();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
signals:
    void signalDcdcMSG00B01(int output_under,
	int output_over,
	int input_under,
	int input_over,
	int fault_f,
	int w_mode,
	int d_rating,
	int input_oc,
	int ot,
	int output_oc);

    void signalDcdcMSG00B17(const QString &real_oc, int reality_t,
	const QString &real_ov, const QString &real_iv, int dcdc_v);

private:
    QObject* m_pRacev;
    // a placeholder for signaled frame
    QCanBusFrame m_Frame;
    QCanBusFrame m_prevFrame;
};

#endif // DCDC_MSG00_H
