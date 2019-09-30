#ifndef CONSTANTS_H
#define CONSTANTS_H

#define NUM_CELLS  14
#define NUM_PACKS  12
#define NUM_TPROBE 4
#define NUM_SMOKE  8
#define NUM_VCUIO  8
#define NUM_PCUIO  8

#define FACTOR_VOLTAGE (0.1)
#define MIN_V 0
#define MAX_V 750
#define MIN_V_CELL 0
#define MAX_V_CELL 5
#define FACTOR_CELLV (0.001)
#define OFFSET_CELL_INDEX (-1)

#define OFFSET_CURRENT (-4000)
#define FACTOR_CURRENT (0.1)
#define MIN_CURRENT (-400)
#define MAX_CURRENT 750

#define FACTOR_RMN (0.1)
#define MIN_RMN 0
#define MAX_RMN 750

#define MIN_SOC (0)
#define MAX_SOC (100)

#define OFFSET_TEMP (-40)

#define MIN_TEMP (-40)
#define MAX_TEMP (210)

#define OFFSET_WTEMP (-40) // water
#define LLIMIT_WTEMP (-40)
#define ULIMIT_WTEMP (100)

#define OFFSET_MTEMP (-40) // motor
#define LLIMIT_MTEMP LLIMIT_WTEMP
#define ULIMIT_MTEMP ULIMIT_WTEMP

#define LLIMIT_TTEMP (-40) // tyre
#define ULIMIT_TTEMP (100)

#define LLIMIT_PDEPTH (0)
#define ULIMIT_PDEPTH (65535)

#define OFFSET_DCLINK_CURRENT (-1600)

#define FACTOR_RPM (0.5)
#define OFFSET_RPM (-32128)
#define LLIMIT_RPM (-16064.0f)
#define ULIMIT_RPM (16703.5f)

#define OFFSET_ATORQUE (-32000)
#define LLIMIT_TORQUE (-32000)
#define ULIMIT_TORQUE (33535)

#define OFFSET_MECHPWR (-32128)
#define FACTOR_PWR (0.125)
#define LLIMIT_MTPWR (-4016)
#define ULIMIT_MTPWR (4175.875f)

#define FACTOR_DCLV (0.05)
#define LLIMIT_DCLV (0)
#define ULIMIT_DCLV (3276.75f)

#define OFFSET_FREQ (-32128)
#define FACTOR_FREQ (0.03125)
#define LLIMIT_FREQ (-1004)
#define ULIMIT_FREQ (1043.96875f)

#define FACTOR_APRESSURE (0.1)
#define LLIMIT_APRESSURE (0)
#define ULIMIT_APRESSURE (10)
#define MIN_AIRP 0
#define MAX_AIRP 10
#define MAX_TPMS_AIRP (16.1)
#define LLIMIT_TPMS_AIRP (0)
#define ULIMIT_TPMS_AIRP (16.1)

#define LLIMIT_DC2_OC (0.0f)
#define ULIMIT_DC2_OC (250.0f)
#define OFFSET_DC2_TEMPOFFSET OFFSET_TEMP // dc2 reality temp ( offset )
#define DC2_FACTOR_VOLTAGE FACTOR_VOLTAGE
#define LLIMIT_DC2_OV (0.0f)
#define ULIMIT_DC2_OV (50.0f)
#define LLIMIT_DC2_IV (0.0f)
#define ULIMIT_DC2_IV (4095.0f)

#define MIN_V24 0
#define MAX_V24 30
#define FACTOR_V24 (0.1)

#define FACTOR_SCALE (0.03125)
#define OFFSET_KELVIN (-273)

#define FACTOR_PA (0.1)
#define FACTOR_BAR (0.00001)
#define LLIMIT_FRATE (0.0f)
#define ULIMIT_FRATE (0.01f)

// @see https://tinyurl.com/yxj2fqzl
// 3.9 mG/LSB
// @see https://tinyurl.com/y49mdfoe
#define FACTOR_ACCELEROMETER_RESOLUTION (0.00390625) // unit: G
#define OFFSET_ACCELEROMETER_RAW (0)
#define ALPHA (0.5)
// #define PI (3.14159265)
#define PI (3.141592653589793238463)

// @see https://tinyurl.com/yxlukuma
#define GRAVITY_CONSTANT (9.81)
//#define GRAVITY_CONSTANT (9.80665)

#define LLIMIT_SLOPE_PERCENT (-100.0f)
#define ULIMIT_SLOPE_PERCENT (100.0f)


#define SPEED_ULIMIT 200
#define SPEED_LLIMIT 0
#endif // CONSTANTS_H
