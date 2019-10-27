#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "OtherIO.h"


int main(int argc , char *argv[])
{
	int key;
        key = Voltage_Get();
	if (key==0)
	{
		printf("The voltage range is 9V~36V.\n");
		exit(0);
	}
	if (key==1)
        {
                printf("The voltage range is 24V.\n");
                exit(0);
        }
	if (key==2)
        {
                printf("The voltage range is 9V~36V.\n");
                exit(0);
        }
	if (key==3)
        {
                printf("The voltage range is 12V.\n");
                exit(0);
        }
	exit(0);
}

