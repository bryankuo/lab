#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>

int main()
{
    printf("Hello world!\n");
    //setlogmask();
    openlog("testlala:", LOG_NDELAY|LOG_PID,  LOG_USER);
    char* aa = "Hello world!\n";
    syslog(2, "%s", aa);
    closelog();
    return 0;
}
