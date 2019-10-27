#ifdef __cplusplus
extern "C"
{
#endif

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int  InitAccelerometer(int); // return = 1 => Success,
                                              // return = 0 => failed,
                                              // return = -2 => G-sensor is busy,
                                              // return = -3 => Time out (5 sec).
/*
byRegister :
	0x00 Device ID
	0x01 to 0x1C Reserved; do not access
	0x1D Tap threshold
	0x1E X-axis offset
	0x1F Y-axis offset
	0x20 Z-axis offset
	0x21 Tap duration
	0x22 Tap latency
	0x23 Tap window
	0x24 Activity threshold
	0x25 Inactivity threshold
	0x26 Inactivity time
	0x27 Axis enable control for activity and inactivity detection
	0x28 Free-fall threshold
	0x29 Free-fall time
	0x2A Axis control for single tap/double tap
	0x2B Source of single tap/double tap
	0x2C Data rate and power mode control
	0x2D Power-saving features control
	0x2E Interrupt enable control
	0x2F Interrupt mapping control
	0x30 Source of interrupts
	0x31 Data format control
	0x32 X-Axis Data 0
	0x33 X-Axis Data 1
	0x34 Y-Axis Data 0
	0x35 Y-Axis Data 1
	0x36 Z-Axis Data 0
	0x37 Z-Axis Data 1
	0x38 FIFO control
	0x39 FIFO status
*/

int  G_Sensor_Read(int , int *,int); // return = 1 => Success,
                                                     // return = 0 => read failed,
                                                     // return = -1 => The register number is out of range,
                                                     // return = -2 => G-sensor is busy,
                                                     // return = -3 => Time out (5 sec).
int  G_Sensor_Write(int , int,int ); // return = 1 => Success,
                                                     // return = 0 => read failed,
                                                     // return = -1 => The register number is out of range,
                                                     // return = -2 => G-sensor is busy,
                                                     // return = -3 => Time out (5 sec).
int  G_Sensor_X_Axis(int *,int); // return = 1 => Success, return = 0 => failed, return = -2 => G-sensor is busy, return = -3 => Time out (5 sec).
int  G_Sensor_Y_Axis(int *,int); // return = 1 => Success, return = 0 => failed, return = -2 => G-sensor is busy, return = -3 => Time out (5 sec).
int  G_Sensor_Z_Axis(int *,int); // return = 1 => Success, return = 0 => failed, return = -2 => G-sensor is busy, return = -3 => Time out (5 sec).
int  G_Sensor_3_Axis(int *, int *, int *,int); // return = 1 => Success, return = 0 => read failed.
// #define EN_2BYTE_DATA_ test
#if defined ( EN_2BYTE_DATA_ )
int  G_Sensor_X_AxisEx(int *byXAxis0, int *byXAxis1, int fh);
// int  G_Sensor_Y_AxisEx(int *byYAxis0, int *byYAxis1, int fh);
// int  G_Sensor_Z_AxisEx(int *byZAxis0, int *byZAxis1, int fh);
#endif

#ifdef __cplusplus
}
#endif
