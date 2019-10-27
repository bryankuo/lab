#ifndef VCU_HMI_MSG01_H
#define VCU_HMI_MSG01_H

#include <QObject>
#include <QCanBusFrame>

using namespace std;

//
// PGN context
//

class Handler_VCU_HMI_MSG01 : public QObject
{
    Q_OBJECT
public:
    Handler_VCU_HMI_MSG01(QObject* p_racev);
    ~Handler_VCU_HMI_MSG01();
    void updateMsg(QCanBusFrame* pframe, QObject* pDstVw);
private:
    void updateMessage_VCU_HMI_Msg_1_Byte_1(QCanBusFrame* pframe, QObject* pDstVw);
    void updateMessage_VCU_HMI_Msg_1_Byte_2(QCanBusFrame* pframe, QObject* pDstVw);
    void updateMessage_VCU_HMI_Msg_1_Byte_3(QCanBusFrame* pframe, QObject* pDstVw);
    void updateMessage_VCU_HMI_Msg_1_Byte_4(QCanBusFrame* pframe, QObject* pDstVw);
    void updateMessage_VCU_HMI_Msg_1_Byte_5(QCanBusFrame* pframe, QObject* pDstVw);
    void updateMessage_VCU_HMI_Msg_1_Byte_6(QCanBusFrame* pframe, QObject* pDstVw);
    QObject* m_pRacev;
};

#endif // VCU_HMI_MSG01_H
