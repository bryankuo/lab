#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#define BASEADDR1 0x0ED2         // GPO Base address
#define BASEADDR2 0x0ED1         // GPI Base address
#define BASEADDR3 0x0ED6         // GPIO Type Base address


int GPIOType_Set(char number,char type)
{
	int bfr=0,bfr1=0,fh,cnt;	
  	fh = open("/dev/NEXCOM_IO", O_RDWR);
	if (fh==0)
	{
		printf("NEXCOM_IO driver cannot be opened.\n");
		return -1;
	}
	read(fh,&bfr1,BASEADDR3);
 	printf("The register is %x before\n",bfr1);
	if (type =='0'){
		switch (number) {
			case '1':
				bfr=bfr1 & 0xfe;
				cnt = write(fh,&bfr,BASEADDR3);
                	break;
			case '2':
				bfr=bfr1 & 0xfd;	
				cnt = write(fh,&bfr,BASEADDR3);
			break;
			case '3':
                		bfr=bfr1 & 0xfb;	
				cnt = write(fh,&bfr,BASEADDR3);
       			break;
	 		case '4':
               			bfr=bfr1 & 0xf7;	
				cnt = write(fh,&bfr,BASEADDR3);
                	break;
			case '5':
                		bfr=bfr1 & 0xef;	
			 	cnt = write(fh,&bfr,BASEADDR3);
                	break;
			case '6':
                        	bfr=bfr1 & 0xdf;	
				cnt = write(fh,&bfr,BASEADDR3);
                	break;
			case '7':
                                bfr=bfr1 & 0xbf;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
			case '8':
                                bfr=bfr1 & 0x7f;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;

			default:
				printf("The GPIO number of you select is wrong, please execute this program again.\n");
			read(fh,&bfr1,BASEADDR3);
        		printf("The register is %x after\n",bfr1);
			close(fh);
			return -1;
		}

        } 
	else if ( type == '1'){
		   switch (number) {
                        case '1':
                                bfr=bfr1 | 0x01;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '2':
                                bfr=bfr1 | 0x02;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '3':
                                bfr=bfr1 | 0x04;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '4':
                                bfr=bfr1 | 0x08;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '5':
                                bfr=bfr1 | 0x10;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '6':
                                bfr=bfr1 | 0x20;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
			case '7':
                                bfr=bfr1 | 0x40;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;
                        case '8':
                                bfr=bfr1 | 0x80;
                                cnt = write(fh,&bfr,BASEADDR3);
                        break;

                        default:
                                printf("The GPIO number of you select is wrong, please execute this program again.\n");
                        close(fh);
                        return -1;
                }

        }


	else {
		 printf("The GPIO type of you select is wrong, please execute this program again.\n");
                        close(fh);
                        return -1;

	}
	bfr1=0;
	read(fh,&bfr1,BASEADDR3);

	close(fh);
	return 0;
}

int GPO_Set(char number, char level)
{
	int bfr=0,bfr1=0,fh,cnt;	
  	fh = open("/dev/NEXCOM_IO", O_RDWR);
	if (fh==0)
	{
		printf("NEXCOM_IO driver cannot be opened.\n");
		return -1;
	}
	
        read(fh,&bfr1,BASEADDR1);
	if (level =='0'){
                switch (number) {
                        case '1':
                                bfr=bfr1 & 0xfe;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '2':
                                bfr=bfr1 & 0xfd;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '3':
                                bfr=bfr1 & 0xfb;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '4':
                                bfr=bfr1 & 0xf7;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '5':
                                bfr=bfr1 & 0xef;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '6':
                                bfr=bfr1 & 0xdf;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
			case '7':
                                bfr=bfr1 & 0xbf;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '8':
                                bfr=bfr1 & 0x7f;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;

                        default:
                                printf("The GPIO number of you select is wrong, please execute this program again.\n");
                        close(fh);
                        return -1;
                }

        }
	else if ( level == '1'){
                   switch (number) {
                        case '1':
                                bfr=bfr1 | 0x01;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '2':
                                bfr=bfr1 | 0x02;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '3':
                                bfr=bfr1 | 0x04;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '4':
                                bfr=bfr1 | 0x08;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '5':
                                bfr=bfr1 | 0x10;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '6':
                                bfr=bfr1 | 0x20;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
			case '7':
                                bfr=bfr1 | 0x40;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;
                        case '8':
                                bfr=bfr1 | 0x80;
                                cnt = write(fh,&bfr,BASEADDR1);
                        break;

                        default:
                                printf("The GPIO number of you select is wrong, please execute this program again.\n");
                        close(fh);
                        return -1;
                }

        }
  	else {
                 printf("The GPIO level of you select is wrong, please execute this program again.\n");
                        close(fh);
                        return -1;

        }
        close(fh);
        return 0;
}

int GPI_Get()
{
        int bfr=0,bfr1=0,fh,cnt;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }

        read(fh,&bfr1,BASEADDR2);
        close (fh);
	return bfr1;

}

int GPIOType_Get()
{
        int bfr=0,bfr1=0,fh,cnt;
        fh = open("/dev/NEXCOM_IO", O_RDWR);
        if (fh==0)
        {
                printf("NEXCOM_IO driver cannot be opened.\n");
                return -1;
        }

        read(fh,&bfr1,BASEADDR3);
        close (fh);
        return bfr1;

}

