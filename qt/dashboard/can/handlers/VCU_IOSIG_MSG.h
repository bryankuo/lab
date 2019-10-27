#ifndef VCU_IOSIG_MSG_H
#define VCU_IOSIG_MSG_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_IOSIG_MSG : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_IOSIG_MSG(QObject* p_racev);
    ~Handler_VCU_IOSIG_MSG();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    QObject* m_pRacev;
};

#endif // VCU_IOSIG_MSG_H
