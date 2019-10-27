#ifndef BCU_VCU_SMD_H
#define BCU_VCU_SMD_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BCU_VCU_SMD : public QObject
{
    Q_OBJECT
public:
    Handler_BCU_VCU_SMD(QObject* p_racev);
    ~Handler_BCU_VCU_SMD();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // BCU_VCU_SMD_H
