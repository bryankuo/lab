#ifndef VCU_DIAG01_H
#define VCU_DIAG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_DIAG01 : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_DIAG01(QObject* p_racev);
    ~Handler_VCU_DIAG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_DIAG01_H
