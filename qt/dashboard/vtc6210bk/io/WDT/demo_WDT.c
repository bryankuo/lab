#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "WDT_IO.h"


int main(int argc , char *argv[])
{
	char key;
        printf("Please select what you wnat to set:\n");
        printf("0) Disable WDT function\n");
	printf("1) 1sec\n");
	printf("2) 2sec\n"); 
	printf("3) 4sec\n"); 
	printf("4) 8sec\n"); 
	printf("5) 16sec\n");
	printf("6) 32sec\n"); 
	printf("7) 64sec\n");
	printf("8) 128sec\n");
	printf("Please select the value of WDT time out(0~8):");
        scanf("%c",&key);
        switch (key) {
//                case '0','1','2','3','4','5','6','7','8','9':
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
			WDT_SetTimer(key);
		break;
		default:
                        printf("The number of you select is wrong, please execute this program again.\n");
	}
	exit(0);
}

