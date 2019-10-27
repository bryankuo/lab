#ifndef FPCAN06_H
#define FPCAN06_H

#include <QCanBusFrame>

#include "../../info.h"

class FrameParserViobCan06: public QObject
{
    Q_OBJECT
public:
    FrameParserViobCan06(QObject* p_racev);
    int parse(QByteArray data);

signals:
    void canSignalFrame(quint32 can_addr, QCanBusFrame* pframe);

private:
    QObject* m_pRacev; // FIXME: downcasting
    Info* m_pInfo;
};

#endif // FPCAN06_H
