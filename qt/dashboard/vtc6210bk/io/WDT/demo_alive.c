#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "WDT_IO.h"


int main(int argc , char *argv[])
{
	WDT_ClearTimer();
	exit(0);
}

