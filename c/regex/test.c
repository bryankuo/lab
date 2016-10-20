#include <stdio.h>
#include <unistd.h>
#include <errno.h>

int main(void) {

int fd = open ("inputfile.txt", O_RDONLY);
if (fd == -1) {
/* The open failed. Print an error message and exit. */
fprintf (stderr, "error opening file: %s\n", strerror (errno));
exit (1);
}
/*
while (1) {
//printf (".");
fprintf (stderr, ".");
sleep (1);
}*/

return 0;
}