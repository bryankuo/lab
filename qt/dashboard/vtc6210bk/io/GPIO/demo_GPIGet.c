#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include "GPIO_IO.h"


int main(int argc , char *argv[])
{
	int value=0,type=0;
	type = GPIOType_Get();
	printf("GPIO type register is %x\n",type);
/*  
	The bit0 of "type" is GPIO1 type, bit1 of "type" is GPIO2 and so on. 
	The type of GPIO is "input" type if bit of "type" is '0', and The type of GPIO is "output" type if bit of "type" is '1'
	For example, if value of "type" is 0xf4 and GPIO type is as below.
		GPIO1 : input 
		GPIO2 : input
		GPIO3 : Output
		GPIO4 : input
		GPIO5 : Output
		GPIO6 : Outoput  
*/
        value = GPI_Get();
        printf("GPI register is %x\n",value);
/*  
        The bit0 of "value" is GPI1 level, bit1 of "value" is GPI2 and so on.
	Please don't care the value of bit if you set this type of GPIO to GPO.  
        The level of GPI is "low" if bit of "value" is '0', and The level of GPI is "high" if bit of "value" is '1'
        For example, if value of "type" is 0xf4 and GPIO type is as below.
                GPIO1 : input 
                GPIO2 : input
                GPIO3 : Output
                GPIO4 : input
                GPIO5 : Output
                GPIO6 : Outoput  
		And then value of "value" is 0xf3 and GPI level is as below.
                GPI1 : high  
                GPI2 : high
                GPI3 : don't care (because GPIO3 type is set to output )
                GPI4 : low
                GPI5 : don't care (because GPIO3 type is set to output )
                GPI6 : don't care (because GPIO3 type is set to output )  
*/


	exit(0);
}

