#ifndef TPMS_MSG01_H
#define TPMS_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_TPMS_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_TPMS_MSG01(QObject* p_racev);
    ~Handler_TPMS_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // TPMS_MSG01_H
