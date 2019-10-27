#ifndef FRAMEPARSER_H
#define FRAMEPARSER_H

#include <QCanBusFrame>

#include "../info.h"

#define BAM_CTRL_BYTE 0x20
#define BAM_PROB_TEMP 0x30
#define BAM_CELL_VOLT 0x50
#define BAM_PROB_NUM_FRAME 7
#define BAM_CELL_NUM_FRAME 48
#define BAM_T1_MS     750

#define EN_PARSE_BY_FRAME_PTR_

class FrameParser: public QObject
{
    Q_OBJECT
public:
    FrameParser(QObject* p_racev);
    int parse();
    int parseBAM(QCanBusFrame* pframe);
#if defined ( EN_PARSE_BY_FRAME_PTR_ )
    int parse(QCanBusFrame* pframe);
#else
    int parse(QCanBusFrame& frame);
#endif
    quint32 m_bamTempMsgMap; // bit map for update insertion status
    quint64 m_bamVoltMsgMap; // TP.DT bit map

signals:
    void canSignalFrame(quint32 can_addr, QCanBusFrame* pframe);

private:
    QObject* m_pRacev; // FIXME: downcasting
    Info* m_pInfo;
    int m_iBamLength;
    int m_iBamBody;
    int m_iBamBodyIndex;
    int m_init;

    quint32 m_bamVoltSequenceNum; // expect sequence
    quint32 m_bamTempSequenceNum; // expect sequence
    bool m_bamVoltGateOn; // 0: false, 1: true
    bool m_bamTempGateOn; // 0: false, 1: true
    quint64 m_bamT1VoltStop; // BAM Timeout
    quint64 m_bamT1TempStop; // BAM Timeout
    quint32 m_bamNumFrame;
    quint32 m_bamMessageLen;

    int handleBAM_Voltage(QCanBusFrame* pframe);
    int handleBAM_Temperature(QCanBusFrame* pframe);
    int handleBAM_VoltageTpdt(QCanBusFrame* pframe, quint32 seq_num);
    int handleBAM_TemperatureTpdt(QCanBusFrame* pframe, quint32 seq_num);
    bool isAtLeastXBytesGreaterThanCriteria(QByteArray payload, int n_bytes, unsigned char criteria);

};

#endif // FRAMEPARSER_H
