#ifndef BMS_OBC_MSG01_H
#define BMS_OBC_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_BMS_OBC_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_BMS_OBC_MSG01(QObject* p_racev);
    ~Handler_BMS_OBC_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // BMS_OBC_MSG01_H
