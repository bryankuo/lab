#ifndef TPMS_MSG02_H
#define TPMS_MSG02_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_TPMS_MSG02 : public QObject
{
    Q_OBJECT
public:
    Handler_TPMS_MSG02(QObject* p_racev);
    ~Handler_TPMS_MSG02();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // TPMS_MSG02_H
