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
        printf("0) Set MCU GPO1 to Low.\n");
	printf("1) Set MCU GPO1 to high.\n");
	printf("Please select the number (0~1):");
	scanf("%c",&key);
        switch (key) {
		case '0':
			MCU_GPIO_SetGPO_Status_1(0);
		  	break;
		case '1':
			MCU_GPIO_SetGPO_Status_1(1);
			break;
		default:
                        printf("The number of you select is wrong, please execute this program again.\n");
			exit(0);
	}
	printf("The setting vlaue is available.\n");
	exit(0);
}

