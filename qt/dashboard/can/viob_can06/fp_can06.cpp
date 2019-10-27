#include <iostream>
#include <iomanip>
#include <stdexcept>

#include <QDateTime>
#include <QDebug>

#include "fp_can06.h"
#include "../../info.h"
#include "../../racev.h"

FrameParserViobCan06::FrameParserViobCan06(QObject* p_racev = 0)
    :m_pRacev(p_racev),m_pInfo(nullptr) {
    // qDebug() << "FrameParserViobCan06() +";
    // How to convert from QObject to UI elements?
    // ( https://goo.gl/muFuqg )
    Racev *p_racev1 = qobject_cast<Racev*>(m_pRacev);
    m_pInfo = p_racev1->m_pInfo;
}

// #define EN_OUTPUT_
int FrameParserViobCan06::parse(QByteArray data) {
    QString output = QString::fromStdString(data.toStdString()); // FIXME: make it simple
    QStringList list;
    QStringList frame_s;
    bool ok; int n_packet = 0; int i = 0;/* qint64 ts = 0;*/
#if 0
    ts = QDateTime::currentMSecsSinceEpoch();
    cout << __func__ << ":" << __LINE__ << " " << ts << " " << endl;
#endif
    // split: ( https://tinyurl.com/yy2pn3ap )
    // into list: ( https://tinyurl.com/yxwq3o7t )
    //list = output.split(QRegExp("[\r\n]"), QString::SkipEmptyParts);
    list = output.split("\r\n", QString::SkipEmptyParts);
    // cout << __func__ << ":" << __LINE__ << " " << list.count() << endl;
    if ( list[0].contains("ecff", Qt::CaseInsensitive) ) {
	frame_s = list[0].split(' ', QString::SkipEmptyParts);
	// Assume 00ECFF respond will be at very first line
	// Assume the number of BAM respond line varies
	// 7 0ECFF F4 20 50 01 30 FF 91 FF 00
	n_packet = frame_s[6].toInt(&ok, 16);
#if 0
	cout << __func__ << ":" << __LINE__
	    << " BAM " << n_packet << "," << list.count() << endl;
#endif
#if 0
	if ( list[0] <= list.count() ) {
	    // iterate: ( https://tinyurl.com/yxanf63x )
	    for ( const auto& i : frame_s ) {
		qDebug() << i.toLocal8Bit().constData() << "\r";
	    }
	}
#endif
#if defined ( EN_OUTPUT_ )
	for ( i = 0; i < list.count() && i < n_packet; i++ ) {
	    cout << list[i].toStdString() << endl;
	}
#endif
    }
    else {
#if 0
	qDebug() << __func__ << ":" << __LINE__
	    << QString::fromStdString(data.toStdString());
#endif
#if defined ( EN_OUTPUT_ )
	// Assume 1 line is enough for non-BAM frame, or not
	for ( i = 0; i < list.length(); i++ )
	    if ( 20 < list[0].length()
		&& !list[0].contains("?", Qt::CaseInsensitive)
		&& !list[0].contains("CAN ERROR", Qt::CaseInsensitive)
		&& !list[0].contains("STOPPED", Qt::CaseInsensitive)
		&& !list[0].contains("NO DATA", Qt::CaseInsensitive)
		&& !list[0].contains("EBFF", Qt::CaseInsensitive)
		&& !list[0].contains("ECFF", Qt::CaseInsensitive)) {
		qDebug() << list[0].toLocal8Bit().constData();
		break; // for
	    }
#endif
    }
#if 0
    cout << __func__ << ":" << __LINE__ << " - " << endl;
#endif
    // TODO: error counter
    return 0;
}
