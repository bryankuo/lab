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
        key = MCU_GPIO_ReadGPI_Status_2();
	if ( key == 0 )
		printf("MCU GPI2 is Low\n");
	if ( key == 1 )
                printf("MCU GPI2 is High\n");

	exit(0);
}

