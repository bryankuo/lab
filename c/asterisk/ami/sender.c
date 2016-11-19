/*
 * sender.c -- multicasts "hello, world!" to a multicast group once a second
 *
 * Antony Courtney,	25/11/94
 * gcc -g sender.c -o sender
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <string.h>
#include <stdio.h>


#define SVR_PORT 5038
#define SVR_ADDR "192.168.66.27"
#define BUFLEN 512  //Max length of buffer

int main(int argc, char *argv[])
{
     struct sockaddr_in addr;
     int fd, cnt, slen=sizeof(addr);;
     struct ip_mreq mreq;
	char buf[BUFLEN];
	char message[] =
		"Action: login\r\n"
		"Events: on\r\n"
		"Username: $user\r\n"
		"Secret: $secret\r\n\r\n"
		"Action: originate\r\n"
		"Channel: $channel\r\n"
		"WaitTime: 30\r\n"
		"CallerId: $callerId\r\n"
		"Extension: $number\r\n"
		"Context: from-internal\r\n"
		"Priority: 1\r\n\r\n"
		"Action: Logoff\r\n\r\n";

     /* create what looks like an ordinary UDP socket */
     if ((fd=socket(AF_INET,SOCK_DGRAM,0/*IPPROTO_UDP*/)) < 0) {
	  perror("socket");
	  exit(1);
     }

     /* set up destination address */
     memset(&addr,0,sizeof(addr));
     addr.sin_family=AF_INET;
     addr.sin_addr.s_addr=inet_addr(SVR_ADDR);
     addr.sin_port=htons(SVR_PORT);

     /* now just sendto() our destination! */
	 do {
		if (sendto(fd,message,sizeof(message),0,(struct sockaddr *) &addr,
			 sizeof(addr)) < 0) {
		   perror("sendto");
		   exit(1);
		}
		sleep(1);

        memset(buf,'\0', BUFLEN);
        //try to receive some data, this is a blocking call
        if (recvfrom(fd, buf, BUFLEN, 0, (struct sockaddr *) &addr, &slen) == -1)
        {
		   perror("recvfrom");
		   exit(1);
		}
        puts(buf);
     } while (0);
	 close(fd);
	return 0;
}
