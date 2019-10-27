#ifndef VCU_DIAG02_H
#define VCU_DIAG02_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_DIAG02 : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_DIAG02(QObject* p_racev);
    ~Handler_VCU_DIAG02();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_DIAG02_H
