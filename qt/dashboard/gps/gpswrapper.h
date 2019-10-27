#ifndef GPSWRAPPER_H
#define GPSWRAPPER_H

#include "../info.h"

class GPSWrapper
{
public:
    GPSWrapper();
    ~GPSWrapper();
    int parse(/*const */char* line, int len);
    // int getInfo(void);
    int parse(QByteArray sentence, Info* p_info);
    int parse(std::string sentence, Info* p_info);

private:
};

#endif // GPSWRAPPER_H
