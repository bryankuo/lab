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
private:
    QObject* m_pRacev;
};

#endif // DCDC_MSG00_H
