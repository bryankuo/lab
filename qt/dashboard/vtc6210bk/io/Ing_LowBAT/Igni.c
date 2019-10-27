#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#define BASEADDR 0x0EE0         // Igni Base address

int main()
{
        int bfr=0,bfr1=0,fh,cnt;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }
        read(fh,&bfr1,BASEADDR);
        printf("The register is %x\n",bfr1);
	bfr = bfr1&0x04;
        if (bfr==0)
 		printf("The Ignition is at \"OFF\" state\n");
	else
		printf("The Ignition is at \"ON\" state\n");
	bfr = bfr1&0x08;
	if (bfr==0)
		printf ("The status of battery is \"Normal\" state\n"); 
	else 
		printf ("The status of battery is \"Low\" state\n");

	return 0;
}


