#include <iostream>
#include <iomanip>

#include "iowrapper.h"
#include "vtc6210bk/io/OtherIO/OtherIO.h"

IOWrapper::IOWrapper()
{
#if defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< endl;
#endif
}

IOWrapper::~IOWrapper()
{
#if defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< endl;
#endif

}

int IOWrapper::GPS_Power_Switch(int on) {
#if defined ( QT_DEBUG )
    cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< on
	<< endl;
#endif
    Module_GPS_Power_Switch(on);
    return 0;
}
