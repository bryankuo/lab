#ifdef __cplusplus
extern "C"
{
#endif

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>

#include "G-sensor.h"

#define SMB_BASE 0xE000
#define HCTL	 0x02
#define HSTS	 0x00
#define TSA	 0x04
#define HCMD	 0x03
#define HDATA    0x05
#define HBD	 0x07
#define DATAX0   0x32
#define DATAX1   0x33
#define DATAY0   0x34
#define DATAY1   0x35
#define DATAZ0   0x36
#define DATAZ1   0x37

int Wait_PCH_Running(int dwTime,int fh)
{
	int rData = 0,i=0;
	do
	{
		read(fh,&rData,SMB_BASE+HSTS);
		i++;
		if( i > dwTime )
		{
			return 0; // Time out
		}
	}while( rData & 0x01 );
	return 1;
}
void ClearINTR(int fh)
{
	int wData=0,rData=0,i=0;
	do
	{
		i++;
		read(fh,&rData,SMB_BASE+HSTS);
		if( rData & 0x02 )
		{
			wData=0x02;
			write(fh,&wData,SMB_BASE+HSTS);

		}
	}while( i <= 100 );

}

int InitAccelerometer(int fh)
{
    int bfr=0;
	// Clear all status
	bfr = 0xFF;
	write(fh,&bfr,SMB_BASE+HSTS);
	// check SMBus whether is busy
	if( 0 == Wait_PCH_Running(100,fh) )
		return -2;
  	// Set Slave address to 3A for writting
	bfr = 0x3A;
        write(fh,&bfr,SMB_BASE+TSA);
	//Set G-sensor register to 0x2D¡XPOWER_CTL
	bfr = 0x2D;
        write(fh,&bfr,SMB_BASE+HCMD);
	//Set data 0x80 to XPOWER_CTL
 	bfr = 0x08;
        write(fh,&bfr,SMB_BASE+HDATA);
	//Set SMBus to 1byte translation cycle
	bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);

	if( 0 == Wait_PCH_Running(100,fh) )
		return -3;
	ClearINTR(fh); // Clear  Host Status
		return 1;
}

G_Sensor_Read(int byRegister, int *byData,int fh)

{
	int bfr=0;
	if( byRegister < 0 && byRegister > 0x39 )
		return -1;
	if( byRegister >= 0x01 && byRegister <= 0x1C )
		return -1;
	// check SMBus wheather is busy
	if( 0 == Wait_PCH_Running(100,fh) )
		return -2;
	// Set slave address to 3B for reading
	bfr = 0x3B;
        write(fh,&bfr,SMB_BASE+TSA);
	// Set G-sensor register
        bfr = byRegister;
	write(fh,&bfr,SMB_BASE+HCMD);
	//Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
	if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
	bfr = 0;
	read(fh,&bfr,SMB_BASE+HDATA);
 	ClearINTR(fh); // Clear  Host Status
	*byData = bfr;
	return 1;
}

int  G_Sensor_Write(int byRegister, int byData,int fh)
{
	int bfr;
	if( byRegister < 0 && byRegister > 0x39 )
		return -1;
	if( byRegister >= 0x01 && byRegister <= 0x1C )
		return -1;
	if( byRegister == 0x00
	    || byRegister == 0x2B
	    || byRegister == 0x30
	    || byRegister == 0x32
	    || byRegister == 0x33
	    || byRegister == 0x34
	    || byRegister == 0x35
	    || byRegister == 0x36
	    || byRegister == 0x37
	    || byRegister == 0x39
	)
		return -1;
	// check SMBus wheather is busy
        if( 0 == Wait_PCH_Running(100,fh) )
                return -2;
	// Set slave address to 3A for writing
        bfr = 0x3A;
        write(fh,&bfr,SMB_BASE+TSA);
	//Set G-sensor register to byRegister
        bfr = byRegister;
        write(fh,&bfr,SMB_BASE+HCMD);
	//Set data to byData
        bfr = byData;
        write(fh,&bfr,SMB_BASE+HDATA);
	//Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
	ClearINTR(fh); // Clear  Host Status
	return 1;
}


int  G_Sensor_X_Axis(int *byXAxis,int fh)

{
	int bfr;
	// check SMBus wheather is busy
        if( 0 == Wait_PCH_Running(100,fh) )
                return -2;
        // Set slave address to 3B for reading
        bfr = 0x3B;
        write(fh,&bfr,SMB_BASE+TSA);
        // Set G-sensor register
        bfr = DATAX0;
        write(fh,&bfr,SMB_BASE+HCMD);
        //Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
        bfr = 0;
        read(fh,&bfr,SMB_BASE+HDATA);
        ClearINTR(fh); // Clear  Host Status
        *byXAxis = bfr;
        return 1;
}

int  G_Sensor_Y_Axis(int *byYAxis,int fh)

{
        int bfr;
        // check SMBus wheather is busy
        if( 0 == Wait_PCH_Running(100,fh) )
                return -2;
        // Set slave address to 3B for reading
        bfr = 0x3B;
        write(fh,&bfr,SMB_BASE+TSA);
        // Set G-sensor register
        bfr = DATAY0;
        write(fh,&bfr,SMB_BASE+HCMD);
        //Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
        bfr = 0;
        read(fh,&bfr,SMB_BASE+HDATA);
        ClearINTR(fh); // Clear  Host Status
        *byYAxis = bfr;
        return 1;
}

int  G_Sensor_Z_Axis(int *byZAxis,int fh)
{
        int bfr;
        // check SMBus wheather is busy
        if( 0 == Wait_PCH_Running(100,fh) )
                return -2;
        // Set slave address to 3B for reading
        bfr = 0x3B;
        write(fh,&bfr,SMB_BASE+TSA);
        // Set G-sensor register
        bfr = DATAZ0;
        write(fh,&bfr,SMB_BASE+HCMD);
        //Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
        bfr = 0;
        read(fh,&bfr,SMB_BASE+HDATA);
        ClearINTR(fh); // Clear  Host Status
        *byZAxis = bfr;
        return 1;
}

int G_Sensor_3_Axis(int *byXAxis, int *byYAxis, int *byZAxis, int fh)
{
	if( G_Sensor_X_Axis(byXAxis,fh) != 1 )
		return 0;
	if( G_Sensor_Y_Axis(byYAxis,fh) != 1 )
		return 0;
	if( G_Sensor_Z_Axis(byZAxis,fh) != 1 )
		return 0;
	return 1;
}

#if defined ( EN_2BYTE_DATA_ )
int  G_Sensor_X_AxisEx(int *byXAxis0, int *byXAxis1, int fh)

{
	int bfr;
	// check SMBus wheather is busy
        if( 0 == Wait_PCH_Running(100,fh) )
                return -2;
        // Set slave address to 3B for reading
        bfr = 0x3B;
        write(fh,&bfr,SMB_BASE+TSA);

        // Set G-sensor register
        bfr = DATAX0;
        write(fh,&bfr,SMB_BASE+HCMD);
        //Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
        bfr = 0;
        read(fh,&bfr,SMB_BASE+HDATA);
        ClearINTR(fh); // Clear  Host Status
        *byXAxis0 = bfr;

        // Set G-sensor register
        bfr = DATAX1;
        write(fh,&bfr,SMB_BASE+HCMD);
        //Set SMBus to 1byte translation cycle
        bfr = 0x48;
        write(fh,&bfr,SMB_BASE+HCTL);
        if( 0 == Wait_PCH_Running(100,fh) )
                return -3;
        bfr = 0;
        read(fh,&bfr,SMB_BASE+HDATA);
        ClearINTR(fh); // Clear  Host Status
        *byXAxis1 = bfr;

        return 1;
}
#endif

#ifdef __cplusplus
}
#endif
