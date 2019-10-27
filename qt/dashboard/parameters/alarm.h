#ifndef ALARM_H
#define ALARM_H

#define NUM_ALARM_DESC	695
#define LEN_CONTENT	128
#define LEN_ALARM_SEG	5

/*
 * @see https://tinyurl.com/y3yrjo2p
 * @see https://tinyurl.com/y4ks8dyf
 */
typedef struct alarm_parameter {
    unsigned int id;
    uint16_t display;
    uint16_t record;
    uint16_t beeps;
    uint16_t voice;
    unsigned long int count;
    char content[LEN_CONTENT];
} ALARM_PARAMETER;

class AlarmParameters
{
public:
    AlarmParameters();
    AlarmParameters(QObject* p_racev);
    ~AlarmParameters();
    ALARM_PARAMETER m_Items[NUM_ALARM_DESC];
    int insert(unsigned int id, uint16_t display, uint16_t record,
	uint16_t beeps, uint16_t voice, std::string content);
    // TODO:
    // bool clearStats(void);
    // int update(); // by signal
    // int sync(); // to file
    // int changeLanguage();
private:
    QObject* m_pRacev;
};

#endif // ALARM_H
