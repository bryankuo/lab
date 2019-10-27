#ifndef ALM_MSG03_H
#define ALM_MSG03_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_ALM_MSG03 : public QObject
{
    Q_OBJECT
public:
    Handler_ALM_MSG03(QObject* p_racev);
    ~Handler_ALM_MSG03();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // ALM_MSG03_H
