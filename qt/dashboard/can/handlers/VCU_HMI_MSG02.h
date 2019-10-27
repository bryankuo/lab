#ifndef VCU_HMI_MSG02_H
#define VCU_HMI_MSG02_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_HMI_MSG02 : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_HMI_MSG02(QObject* p_racev);
    ~Handler_VCU_HMI_MSG02();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_HMI_MSG02_H
