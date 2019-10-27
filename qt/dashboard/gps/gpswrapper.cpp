#include <iostream>     // std::cout, std::endl
#include <iomanip>      // std::setfill, std::setw

// #include <sstream>
#include <string>
#include <iostream>
#include <vector>

#include <QTextCodec>

// #define EN_LIBNMEA_
#if defined ( EN_LIBNMEA_ )
#include <nmea.h>
#include <nmea/gpgll.h>
#include <nmea/gpgga.h>
#endif

#include "gpswrapper.h"

using namespace std;

// #pragma GCC diagnostic ignored "-fpermissive"
// @see https://tinyurl.com/y5af5tbq

GPSWrapper::GPSWrapper()
{
    // cout << __func__ << ":" << __LINE__ << " + " << endl;
    cout << __func__ << ":" << __LINE__ << " - " << endl;
}

GPSWrapper::~GPSWrapper()
{
    // cout << __func__ << ":" << __LINE__ << " + " << endl;
    cout << __func__ << ":" << __LINE__ << " - " << endl;
}

int GPSWrapper::parse(/*const */char* line, int len) {
#if 0
    cout << __FILE__ << ":" << __func__ << ":" << __LINE__ << " "
    << "len " << len << "[" << line << "]" << endl;
#endif
#if defined ( EN_LIBNMEA_ )
    nmea_s *data;
    // Parse...
    data = nmea_parse(line, len, 0);
#if 0
    cout << __FILE__ << ":" << __LINE__ << " type " << data->type << endl;
#endif
    // Pointer to struct containing the parsed data. Should be freed manually.
    // @see https://tinyurl.com/yypp55w8
    if (NMEA_GPGLL == data->type) {
    nmea_gpgll_s *gpgll = (nmea_gpgll_s *) data;
#if 1
    cout << __FILE__ << ":" << __LINE__ << " "
        << "Longitude Degree : " << gpgll->longitude.degrees << " "
        << "Minutes: " << gpgll->longitude.minutes << " "
        << "Cardinal: " << static_cast<char>(gpgll->longitude.cardinal) << "\n"
        << "Latitude Degree : " << gpgll->latitude.degrees << " "
        << "Minutes: " << gpgll->latitude.minutes << " "
        << "Cardinal: " << static_cast<char>(gpgll->latitude.cardinal)
    << endl;
#endif
    }
    // https://tinyurl.com/yypp55w8
    nmea_free(data);
#endif
    // assume $GNGGA sentence

    return 0;
    // cout << __func__ << ":" << __LINE__ << " - " << endl;
}

// TODO: to be obselete
int GPSWrapper::parse(QByteArray sentence, Info* p_info) {
    // converting QByteArray to QString
    // @see https://tinyurl.com/y2krrf82
    //int i;

    QString gngga_sentence = QTextCodec::codecForMib(1015)->toUnicode(sentence);
    QStringList list = gngga_sentence.split(',', QString::SkipEmptyParts);
    // @see https://tinyurl.com/y3udmxlc
    // for ( QStringList::Iterator S = list.begin(); S != list.end(); S++ )
    // cout << __FILE__ << ":" << __LINE__ << " [" << (*S) << "]" << endl;
    // cout << __FILE__ << ":" << __LINE__ << " " << list.count() << endl;
    //cout << __FILE__ << ":" << __LINE__
    //	<< " [" << gngga_sentence.toStdString().c_str() << "]" << endl;
    return 0;
}

int GPSWrapper::parse(std::string sentence, Info* p_info) {
    vector<string> strings;
    std::istringstream iss(sentence);
    string s;
    std::string::size_type sz; // alias of size_t
#if 0
	cout << __FILE__ << ":" << __LINE__
	    << " s [" << sentence << "]"
	    << endl;
#endif
    // TODO: time synchronization
    try {
	// GGA - Global Positioning System Fix Data
	// @see https://tinyurl.com/yxpf9e9t
	while (getline(iss, s, ',')) {
	    // cout << s << endl;
	    strings.push_back(s);
	}
	// cout << strings[2] << endl;
	// @see https://tinyurl.com/y2qmft6y
	if ( 0 < strings[2].length()
	    && 0 < strings[3].length()
	    && 0 < strings[4].length()
	    && 0 < strings[5].length() ) {
	    p_info->latitude = std::stof(strings[2],&sz)/100;
	    p_info->dir_latitude = strings[3];
	    p_info->longitude = std::stof(strings[4],&sz)/100;
	    p_info->dir_longitude = strings[5];
	}
	else {
	    // bad signal, not parsed
	    p_info->latitude = 0;
	    p_info->dir_latitude = "";
	    p_info->longitude = 0;
	    p_info->dir_longitude = "";
	    return 0;
	}
#if 0
	cout << p_info->latitude/100 << " " << p_info->dir_latitude << ", "
	    << p_info->longitude/100 << " " << p_info->dir_longitude
	    << endl;
#endif
    } catch (const std::exception& ex) {
	cout << __FILE__ << ":" << __LINE__
	    << " exception " << ex.what()
	    // << " 2 [" << strings[2] << "]"
	    // << " 4 [" << strings[4] << "]"
	    << endl;
    }
    return strings.size();
}
