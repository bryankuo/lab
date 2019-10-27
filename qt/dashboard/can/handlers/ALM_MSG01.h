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
private:
    QObject* m_pRacev;
};

#endif // ALM_MSG01_H
