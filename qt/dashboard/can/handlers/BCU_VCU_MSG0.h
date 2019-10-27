#ifndef BCU_VCU_MSG0_H
#define BCU_VCU_MSG0_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BCU_VCU_MSG0 : public QObject
{
    Q_OBJECT
public:
    Handler_BCU_VCU_MSG0(QObject* p_racev);
    ~Handler_BCU_VCU_MSG0();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // BCU_VCU_MSG0_H
