#ifndef PCU_IO_SIG00_H
#define PCU_IO_SIG00_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_PCU_IO_SIG00 : public QObject
{
    Q_OBJECT
public:
    Handler_PCU_IO_SIG00(QObject* p_racev);
    ~Handler_PCU_IO_SIG00();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // PCU_IO_SIG00_H
