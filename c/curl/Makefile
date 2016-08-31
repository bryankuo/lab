# Which compiler
CC = gcc

# Where to install
INSTDIR = /usr/local/bin

# Where are include files kept
INCLUDE = .
MYSQL_INC = /usr/include/mysql

# Where are library files kept
LDFLAGS = /usr/lib/mysql -lmysqlclient -lz

# Options for development
CFLAGS = -g -Wall

# Options for release
# CFLAGS = -O -Wall -ansi

all: curl-test

curl-test: main.o
	$(CC) -o curl-test -lcurl main.o 

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

clean:
	@rm -f *.o
	rm -f curl-test
