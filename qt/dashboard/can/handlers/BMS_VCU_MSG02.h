#ifndef BMS_VCU_MSG02_H
#define BMS_VCU_MSG02_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BMS_VCU_MSG02 : public QObject
{
    Q_OBJECT
public:
    Handler_BMS_VCU_MSG02(QObject* p_racev);
    ~Handler_BMS_VCU_MSG02();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // BMS_VCU_MSG02_H
