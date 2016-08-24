#include <stdio.h>
#include <sys/stat.h>
#include <string.h>

int main()
{
    FILE *my_stream;
    char _buffer[4096] = "";
    char _pathname[256] = "snazzyjazz.txt";

    my_stream = fopen (_pathname, "w+");

    if (my_stream == NULL) {
        printf ("File could not be opened\n");
    } else {
#if 0
        chmod(_pathname, S_IRWXU | S_IRWXG | S_IROTH | S_IWOTH);
#endif
        strcat(_buffer, "</include>\n");
        fwrite(_buffer, sizeof(_buffer[0]), strlen(_buffer), my_stream);
        printf ("File opened!  Closing it now...\n");
        /* Close stream; skip error-checking for brevity of example */
        fclose (my_stream);
#if 1
        int i = chmod(_pathname,
                      S_IRUSR | S_IWUSR | S_IXUSR |
                      S_IRGRP | S_IWGRP | S_IXGRP /*| S_IROTH*/);
#endif
    }
    return 0;
}
