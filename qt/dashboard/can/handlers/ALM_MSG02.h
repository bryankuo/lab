#ifndef ALM_MSG02_H
#define ALM_MSG02_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_ALM_MSG02 : public QObject
{
    Q_OBJECT
public:
    Handler_ALM_MSG02(QObject* p_racev);
    ~Handler_ALM_MSG02();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // ALM_MSG02_H
