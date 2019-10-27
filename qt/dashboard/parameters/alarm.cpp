#include <iostream>
#include <string>
#include <string.h>

#include <QObject>

#include "alarm.h"
AlarmParameters::AlarmParameters()
// FIXME:    :m_Items({0})
{
#if 0 //defined ( QT_DEBUG )
    std::cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " AlarmParameters( ) "
	<< std::endl;
#endif
}

AlarmParameters::AlarmParameters(QObject* p_racev):m_pRacev(p_racev)
{
#if 0 //defined ( QT_DEBUG )
    std::cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " AlarmParameters( " << static_cast<void*>(p_racev) << " ) "
	<< std::endl;
#endif
}

AlarmParameters::~AlarmParameters()
{
#if 1 //defined ( QT_DEBUG )
    std::cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " ~AlarmParameters( ) "
	<< std::endl;
#endif
}

int AlarmParameters::insert(
    unsigned int id, uint16_t display, uint16_t record, uint16_t beeps,
    uint16_t voice, std::string content) {
    ALARM_PARAMETER* p_alarm = &m_Items[id];
#if 0 //defined ( QT_DEBUG )
    std::cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< " (" << id << ", " << display << ", " << record << ", " << beeps
	<< ", " << voice << ", [" << content << "])"
	<< std::endl;
#endif
    // try:
    // 1. real adding to but just function call (ongoing)
    // 2. execpt strncpy ( possible )
    // 3. less items
    p_alarm->id = id;
    p_alarm->display = display;
    p_alarm->record = record;
    p_alarm->beeps = beeps;
    p_alarm->voice = voice;
    p_alarm->count = 0;
#if 0
    // @see https://tinyurl.com/y6k569f8
    strncpy(p_alarm->content, content.c_str(), LEN_CONTENT - 1);
    p_alarm->content[LEN_CONTENT - 1] = '\0';
#endif
#if 0 //defined ( QT_DEBUG )
    std::cout <<
	__func__ << ":" << __LINE__ << " -" << std::endl;
#endif
    return 0;
}
