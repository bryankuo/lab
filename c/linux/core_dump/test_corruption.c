#include <stdio.h>
#include <pthread.h>

void
depth3() {
    int *ptr;
    int i;

    ptr = (int *)&ptr;
    ptr++;
    for(i = 0; i < 1024; i++) {
	*ptr++ = 0xff;
    }
}

void
depth2() {
    depth3();
}

void *
depth1(void *dummy) {
    depth2();
}

int
main(int argc, const char *argv[]) {
    pthread_t pth;
    void *value;
    
    pthread_create(&pth, NULL, depth1, NULL);
    pthread_join(pth, &value);
    return 0;
}

