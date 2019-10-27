#ifndef PCU_ST_MOT_2_H
#define PCU_ST_MOT_2_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_PCU_ST_MOT_2 : public QObject
{
    Q_OBJECT
public:
    Handler_PCU_ST_MOT_2(QObject* p_racev);
    ~Handler_PCU_ST_MOT_2();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // PCU_ST_MOT_2_H
