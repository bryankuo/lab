#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/io.h>

#define BASE 0x3BC

char *binprint( unsigned char x, char *buf )
{
  int i;
  for( i=0; i<8; i++ )
    buf[7-i]=(x&(1<<i))?'1':'0';
  buf[8]=0;
  return buf;
}

int main( int argc, char *argv[] )
{
  char c;
  unsigned char val;
  char buf[9];
  int x;
  if( argc<2 )
  {
    printf("  example usage: parcon 0l 1l 2h 4h 7l\n");
    return 2;
  }
  if( ioperm(BASE,1,1) )
  {
    printf("Couldn't get port %x\n",BASE);
    return 1;
  }
  val = inb(BASE);
  printf("old = %s\n",binprint(val,buf));
  for( x=1; x<argc; x++ )
    if( argv[x][1]!='h' )
      val &= ~(1<<(argv[x][0]-'1'));
    else
      val |= 1<<(argv[x][0]-'1');
  
  printf("new = %s\n",binprint(val,buf));
  outb(val,BASE); 
  return 0;
}

