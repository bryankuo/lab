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
#include "OtherIO.h"

void EXTERNAL_12_Power(int nStatus)

{
	int bfr=0,fh;
  	fh = open("/dev/NEXCOM_IO", O_RDWR);
	if (fh==0)
	{
		printf("NEXCOM_IO driver cannot be opened.\n");
		return;
	}
	read(fh,&bfr,0xEE6);
	if ( 0==nStatus)
	{
		bfr = bfr & 0xFB;
		write(fh,&bfr,0xEE6);
	}
	if( 1 == nStatus )
	{
		bfr = bfr | 0x04;
		write(fh,&bfr,0xEE6);
	}
	close(fh);
	return;
}

int Voltage_Get()
{	// GAL =======================================================
	// ===========================================================
	// BIOS ======================================================
	int bfr=0,bfr1,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
	bfr1=0x48;
	write(fh,&bfr1,0x070);
        read (fh,&bfr,0x71);
	bfr = bfr & 0x0C; // ¥ý§â€£»Ý­nªº­È¥h±Œ
	close(fh);
	if( bfr == 0x00 )
		return 0;
	if( bfr == 0x04 )
		return 1;
	if( bfr == 0x08 )
		return 2;
	if( bfr == 0x0C )
		return 3;

}

void Voltage_Select_Setting(int nData)
{
	int bfr=0,bfr1=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return;
        }
	bfr1=0x48;
	write(fh,&bfr1,0x070);
        read(fh,&bfr,0x071);
	switch(nData)
	{
		case 0:
			write(fh,&bfr1,0x070);
			bfr = bfr | 0x03;
			bfr = bfr & 0xFC;
			write(fh,&bfr,0x071);
			break;
		case 1:
  			write(fh,&bfr1,0x070);
                        bfr = bfr | 0x03;
                        bfr = bfr & 0xFD;
                        write(fh,&bfr,0x071);
                        break;
		case 2:
  			write(fh,&bfr1,0x070);
                        bfr = bfr | 0x03;
                        bfr = bfr & 0xFE;
                        write(fh,&bfr,0x071);
                        break;
		case 3:
  			write(fh,&bfr1,0x070);
                        bfr = bfr | 0x03;
                        bfr = bfr & 0xFF;
                        write(fh,&bfr,0x071);
                        break;
		default:
			break;

	}
	close(fh);
        return;

}

void Module_Wireless_WAN_Switch(int nStatus)
{
	int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xEE6);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xFE;
                write(fh,&bfr,0x0EE6);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x01;
                write(fh,&bfr,0x0EE6);
        }

        close(fh);
        return ;
}

void Module_Wireless_LAN_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
	read(fh,&bfr,0xEE6);
	if( 0 == nStatus )
	{
		bfr = bfr & 0xFD;
		write(fh,&bfr,0x0EE6);

	}
	if( 1 == nStatus )
	{
		bfr = bfr | 0x02;
                write(fh,&bfr,0x0EE6);
	}

	close(fh);
        return;
}

void Module_Wireless_LAN_DIS2_L_Switch(int nStatus)
{
	int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED7);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xF7;
                write(fh,&bfr,0x0ED7);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x08;
                write(fh,&bfr,0x0ED7);
        }

        close(fh);
        return ;
}

void Module_Wireless_LAN_DIS3_L_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED7);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xEF;
                write(fh,&bfr,0x0ED7);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x10;
                write(fh,&bfr,0x0ED7);
        }

        close(fh);
        return ;
}

void Module_USB2Con_Power_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED7);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xDF;
                write(fh,&bfr,0x0ED7);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x20;
                write(fh,&bfr,0x0ED7);
        }

        close(fh);
        return ;
}

void Module_USB3Con_Power_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED7);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xBF;
                write(fh,&bfr,0x0ED7);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x40;
                write(fh,&bfr,0x0ED7);
        }

        close(fh);
        return ;
}

void Module_GPS_Power_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED7);
        if( 0 == nStatus )
        {
                bfr = bfr & 0x7F;
                write(fh,&bfr,0x0ED7);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x80;
                write(fh,&bfr,0x0ED7);
        }

        close(fh);
        return ;
}


void SIM_CARD_Switch(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xEE6);
        if( 0 == nStatus )
        {
                bfr = bfr & 0x7F;
                write(fh,&bfr,0x0EE6);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x80;
                write(fh,&bfr,0x0EE6);
        }

        close(fh);
        return ;
}


void Wake_On_Wireless_WAN_Switch(int nStatus)
{
        int bfr=0,bfr1=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        //GAL
	read(fh,&bfr,0xEE6);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xEF;
                write(fh,&bfr,0x0EE6);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x10;
                write(fh,&bfr,0x0EE6);
        }
	//BIOS
	bfr1=0x46;
	write(fh,&bfr1,0x070);
        read(fh,&bfr,0x071);
        if( 0 == nStatus )
	{
              	write(fh,&bfr1,0x070);
                bfr = bfr & 0xEF;
                write(fh,&bfr,0x071);
        }
	if( 1 == nStatus )
        {
                write(fh,&bfr1,0x070);
                bfr = bfr | 0x10;
                write(fh,&bfr,0x071);
        }
        close(fh);
        return ;
}

void Wake_On_RTC_Switch(int nStatus)
{
        int bfr=0,bfr1=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return;
        }
        //GAL
        read(fh,&bfr,0xEE6);
        if( 0 == nStatus )
        {
                bfr = bfr & 0xDF;
                write(fh,&bfr,0x0EE6);

        }
        if( 1 == nStatus )
        {
                bfr = bfr | 0x20;
                write(fh,&bfr,0x0EE6);
        }
        //BIOS
	bfr1=0x46;
        write(fh,&bfr1,0x070);
        read(fh,&bfr,0x071);
        if( 0 == nStatus )
        {
                write(fh,&bfr1,0x070);
                bfr = bfr & 0xDF;
                write(fh,&bfr,0x071);
        }
        if( 1 == nStatus )
        {
                write(fh,&bfr1,0x070);
                bfr = bfr | 0x20;
                write(fh,&bfr,0x071);
        }
        close(fh);
        return ;
}

void MCU_GPIO_SetGPO_Status_1(int nData)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return;
        }
        read(fh,&bfr,0xED8);
        if( 0 == nData )
        {
                bfr = bfr & 0xFE;
                write(fh,&bfr,0x0ED8);

        }
        if( 1 == nData )
        {
                bfr = bfr | 0x01;
                write(fh,&bfr,0x0ED8);
        }
        close(fh);
        return ;
}

void MCU_GPIO_SetGPO_Status_2(int nData)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED8);
        if( 0 == nData )
        {
                bfr = bfr & 0xFD;
                write(fh,&bfr,0x0ED8);

        }
        if( 1 == nData )
        {
                bfr = bfr | 0x02;
                write(fh,&bfr,0x0ED8);
        }
        close(fh);
        return ;
}

int  MCU_GPIO_ReadGPO_Status_1()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED8);
        if( bfr& 0x01 )
	{
        	close(fh);
		return 1;
	}
	else
	{
        	close(fh);
        	return 0;
	}
}

int  MCU_GPIO_ReadGPO_Status_2()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
        read(fh,&bfr,0xED8);
        if( bfr& 0x02 )
        {
                close(fh);
                return 1;
        }
        else
        {
                close(fh);
                return 0;
        }
}
int  MCU_GPIO_ReadGPI_Status_1()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
        read(fh,&bfr,0xED8);
        if( bfr& 0x10 )
        {
                close(fh);
                return 1;
        }
        else
        {
                close(fh);
                return 0;
        }
}

int  MCU_GPIO_ReadGPI_Status_2()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
        read(fh,&bfr,0xED8);
        if( bfr& 0x20 )
        {
                close(fh);
                return 1;
        }
        else
        {
                close(fh);
                return 0;
        }
}

int  MCU_GPIO_ReadPANIC_Status()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
        read(fh,&bfr,0xED8);
        if( bfr& 0x80 )
        {
                close(fh);
                return 1;
        }
        else
        {
                close(fh);
                return 0;
        }
}

void MCU_GPIO_PANIC_Status_Clear()
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xED8);
        bfr = bfr& 0x7f;
        write(fh,&bfr,0xED8);
	close(fh);
        return ;
}

void MCU_GPIO_SetLED_Status(int nStatus)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
	read(fh,&bfr,0xEDD);
	if ( 0== nStatus)
	{
		bfr = bfr & 0x7f;
		write(fh,&bfr,0xEDD);
	}
	if ( 0== nStatus)
        {
                bfr = bfr | 0x80;
                write(fh,&bfr,0xEDD);
        }
	close(fh);
        return ;
}

void SerialPort_Select(int nData)
{
        int bfr=0,fh;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return ;
        }
        read(fh,&bfr,0xEE6);
        if ( 0== nData)
        {
                bfr = bfr & 0xbf;
                write(fh,&bfr,0xEE6);
        }
        if ( 1== nData)
        {
                bfr = bfr | 0x40;
                write(fh,&bfr,0xEE6);
        }
        close(fh);
        return ;
}
#ifdef __cplusplus
}
#endif
