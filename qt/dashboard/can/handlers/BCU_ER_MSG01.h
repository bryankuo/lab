#ifndef BCU_ER_MSG01_H
#define BCU_ER_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BCU_ER_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_BCU_ER_MSG01(QObject* p_racev);
    ~Handler_BCU_ER_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // BCU_ER_MSG01_H
