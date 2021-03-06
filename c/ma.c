/*#include <sys/ioctl.h>
#include <net/if.h> 
#include <unistd.h>
#include <netinet/in.h>
#include <string.h>
*/
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/if.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <openssl/sha.h>

// gcc -g -o ma -Wall -pedantic -ansi -std=c99 -O2 ma.c -lcrypto

//#define GET_AUTH // TODO:
#define PRINT_OUT_MAC
#define DO_HASH

int main(int argc, char *argv[])
{
    struct ifreq ifr;
    struct ifconf ifc;
    char buf[1024];
    int success = 0;
	int i;
#ifdef GET_AUTH
	unsigned char auth[SHA_DIGEST_LENGTH] = {0};
	unsigned int auth_uint[SHA_DIGEST_LENGTH] = {0};

	if ( 2 != argc )
	{
		puts("bye!\n");
		return 0;
	}
	//printf("auth: %ld\n", strtol(argv[1], NULL, 16));
    for(i = 0; i<SHA_DIGEST_LENGTH; i++)
    {
        //auth[i]=argv[i+1]; 
        sscanf(argv[i+1], "%x", &auth_uint[i]);
        auth[i] = (unsigned char) auth_uint[i];
    }
	for (i = 0; i < SHA_DIGEST_LENGTH; ++i)
	  printf(" %02x", (unsigned char) auth[i]);
	puts("\n");
#endif

    int sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sock == -1) { /* handle error*/ };

    ifc.ifc_len = sizeof(buf);
    ifc.ifc_buf = buf;
    if (ioctl(sock, SIOCGIFCONF, &ifc) == -1) { /* handle error */ }

    struct ifreq* it = ifc.ifc_req;
    const struct ifreq* const end = it + (ifc.ifc_len / sizeof(struct ifreq));

    for (; it != end; ++it) {
        strcpy(ifr.ifr_name, it->ifr_name);
        if (ioctl(sock, SIOCGIFFLAGS, &ifr) == 0) {
            if (! (ifr.ifr_flags & IFF_LOOPBACK)) { // don't count loopback
                if (ioctl(sock, SIOCGIFHWADDR, &ifr) == 0) {
                    success = 1;
                    break;
                }
            }
        }
        else { /* handle error */ }
    }

    unsigned char mac_address[6];

    if (success) 
	{
		memcpy(mac_address, ifr.ifr_hwaddr.sa_data, 6);
#ifdef PRINT_OUT_MAC
		printf("%s:", ifr.ifr_name);
		for (i = 0; i < 6; ++i)
		  printf(" %02x", (unsigned char) mac_address[i]/*ifr.ifr_addr.sa_data[i]*/);
		puts("\n");
#endif
#ifdef DO_HASH
		printf("hash:");
		//unsigned char data[] = "Hello, world!";
		//size_t length = sizeof(data);
		size_t length = sizeof(mac_address);
		unsigned char hash[SHA_DIGEST_LENGTH];
		SHA1(mac_address, length, hash);
		for (i = 0; i < SHA_DIGEST_LENGTH; ++i)
		  printf(" %02x", (unsigned char) hash[i]);
		puts("\n");
#endif
	}
	return 0;
}
