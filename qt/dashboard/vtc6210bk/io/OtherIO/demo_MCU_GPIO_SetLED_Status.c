#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "OtherIO.h"


int main(int argc , char *argv[])
{
	char key;
        printf("Please select what you wnat to set:\n");
        printf("0) Set LED to OFF.\n");
	printf("1) Set LED to ON.\n");
	printf("Please select the number (0~1):");
	scanf("%c",&key);
        switch (key) {
		case '0':
			MCU_GPIO_SetLED_Status(0);
		  	break;
		case '1':
			MCU_GPIO_SetLED_Status(1);
			break;
		default:
                        printf("The number of you select is wrong, please execute this program again.\n");
			exit(0);
	}
	printf("The setting vlaue is available.\n");
	exit(0);
}

