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
        printf("0) Startup 11.5V/23V, shutdown 10.5V/21V.\n");
	printf("1) Startup 12V/24V, shutdown 10.5V/21V.\n");
	printf("2) Startup 12.5V/25V, shutdown 11V/22V.\n");
	printf("3) Startup 12.5V/25V, shutdown 11.5V/23V.\n");
 	printf("Please select the number (0~3):");
        scanf("%c",&key);
        switch (key) {
		case '0':
			Voltage_Select_Setting(0);
		  	break;
		case '1':
			 Voltage_Select_Setting(1);
			break;
		case '2':
                         Voltage_Select_Setting(2);
                        break;
		case '3':
                         Voltage_Select_Setting(3);
                        break;

		default:
                        printf("The number of you select is wrong, please execute this program again.\n");
			exit(0);
	}
	printf("The setting vlaue is available.\n");
	exit(0);
}

