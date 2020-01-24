#ifndef ALM_MSG01_H
#define ALM_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_ALM_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_ALM_MSG01(QObject* p_racev);
    ~Handler_ALM_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
signals:
    void signalAlmMSG01(int is_charging_in_progress);
private:
    QObject* m_pRacev;
    // a placeholder for signaled frame
    QCanBusFrame m_Frame;
};

#endif // ALM_MSG01_H
