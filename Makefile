# makefile for HelloWorld

CC=gcc
CFLAGS=-O -Wall -DHAVE_GETOPT

all: HelloWorld 

HelloWorld: HelloWorld
	$(CC) $(CFLAGS) main.c -o HelloWorld

clean:
	$(RM) *~ *.o HelloWorld
