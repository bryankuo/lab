#ifndef PCU_CMD_MOT_1_H
#define PCU_CMD_MOT_1_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_PCU_CMD_MOT_1 : public QObject
{
    Q_OBJECT
public:
    Handler_PCU_CMD_MOT_1(QObject* p_racev);
    ~Handler_PCU_CMD_MOT_1();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // PCU_CMD_MOT_1_H
