#ifndef VCU_PWR_STATUS_H
#define VCU_PWR_STATUS_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_PWR_STATUS : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_PWR_STATUS(QObject* p_racev);
    ~Handler_VCU_PWR_STATUS();
    int updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_PWR_STATUS_H
