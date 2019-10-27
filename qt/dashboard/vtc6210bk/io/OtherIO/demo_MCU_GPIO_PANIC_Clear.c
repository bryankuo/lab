#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "OtherIO.h"


int main(int argc , char *argv[])
{
	MCU_GPIO_PANIC_Status_Clear();
	printf("The status of PANIC has been cleared\n");
	exit(0);
}

