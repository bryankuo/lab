#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#define BASEADDR 0x0ee5         // Base address


int WDT_SetTimer(char setting)
{
	int bfr=0,fh,cnt;	
  	fh = open("/dev/NEXCOM_IO", O_RDWR);
	if (fh==0)
	{
		printf("NEXCOM_IO driver cannot be opened.\n");
		return -1;
	}
	
	switch (setting) {
		case '0':
			bfr=0x00;
			cnt = write(fh,&bfr,BASEADDR);
                        if (cnt==0)
                                printf("The WDT has been disabled.\n");
                        else
                                printf("The WDT timer cannot be disaled.\n");
    		break;
		case '1':
			bfr=0x10;
			cnt = write(fh,&bfr,BASEADDR);
			if (cnt==0)
				printf("The WDT has been enable and set time out to 1sec\n");
			else 
				printf("The WDT timer cannot be set.\n");
		break;
		case '2':
                	bfr=0x11;
                	cnt = write(fh,&bfr,BASEADDR);
                	if (cnt==0)
                      		printf("The WDT has been enable and set time out to 2sec\n");
                	else 
                      		printf("The WDT timer cannot be set.\n");
       		break;
	 	case '3':
               		bfr=0x12;
               		cnt = write(fh,&bfr,BASEADDR);
               		if (cnt==0)
                       		printf("The WDT has been enable and set time out to 4sec\n");
               		else 
                       		printf("The WDT timer cannot be set.\n");
                break;
		case '4':
                	bfr=0x13;
		        cnt = write(fh,&bfr,BASEADDR);
                        if (cnt==0)
                       		printf("The WDT has been enable and set time out to 8sec\n");
		        else 
                                printf("The WDT timer cannot be set.\n");
                break;
		case '5':
                        bfr=0x14;
		        cnt = write(fh,&bfr,BASEADDR);
                        if (cnt==0)
                       		printf("The WDT has been enable and set time out to 16sec\n");
		        else 
                                printf("The WDT timer cannot be set.\n");
                break;
		case '6':
                        bfr=0x15;
                	cnt = write(fh,&bfr,BASEADDR);
		        if (cnt==0)
                                printf("The WDT has been enable and set time out to 32sec\n");
                	else 
		                printf("The WDT timer cannot be set.\n");
                 break;
		 case '7':
                        bfr=0x16;
		        cnt = write(fh,&bfr,BASEADDR);
                        if (cnt==0)
		                printf("The WDT has been enable and set time out to 64sec\n");
                        else 
                     		printf("The WDT timer cannot be set.\n");
 	       	 break;
		 case '8':
                         bfr=0x17;
                         cnt = write(fh,&bfr,BASEADDR);
                         if (cnt==0)
                                 printf("The WDT has been enable and set time out to 128sec\n");
                         else
                                 printf("The WDT timer cannot be set.\n");
                 break;
		 default:
			printf("The number of you select is wrong, please execute this program again.\n");
			

        }  		 	
 	read(fh,&bfr,BASEADDR);
  	close(fh);
	return 0;
}

int WDT_ClearTimer()
{
	int bfr=0,fh;  
        fh = open("/dev/NEXCOM_IO", O_RDWR);
	if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
	read(fh,&bfr,BASEADDR);
	write(fh,&bfr,BASEADDR);
        close(fh);
        return 0;
}





