#ifndef VCU_HMI_MSG03_H
#define VCU_HMI_MSG03_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_HMI_MSG03 : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_HMI_MSG03(QObject* p_racev);
    ~Handler_VCU_HMI_MSG03();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_HMI_MSG03_H
