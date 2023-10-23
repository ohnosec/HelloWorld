# makefile for HelloWorld

# comment out the `-DHAVE_GETOPT' if, for some reason or other, you
# don't have getopt(). (This is mainly so it'll work on MS-DOG, though
# I'm not entirely sure why I bothered supporting that. :-))
#
CC=gcc
CFLAGS=-O -Wall -DHAVE_GETOPT
RMAN=./rman/rman

# these set where the executable and man page are installed
PREFIX=/usr/local

BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/man/man1

all: HelloWorld HelloWorld.guide

HelloWorld: HelloWorld.o
	$(CC) $(CFLAGS) -o HelloWorld HelloWorld.o

installdirs:
	/bin/sh ./mkinstalldirs $(BINDIR) $(MANDIR)

install: HelloWorld installdirs
	install -m 511 HelloWorld $(BINDIR)
	install -m 444 HelloWorld.1 $(MANDIR)

uninstall:
	$(RM) $(BINDIR)/HelloWorld
	$(RM) $(MANDIR)/HelloWorld.1*

clean:
	$(RM) *~ *.o HelloWorld

HelloWorld.guide: HelloWorld.1
	$(RMAN) -fAmigaGuide ./HelloWorld.1 >./HelloWorld.guide

# The stuff below makes the distribution tgz.

VERS=1.8.4

dist: tgz
tgz: ../HelloWorld-$(VERS).tar.gz
  
../HelloWorld-$(VERS).tar.gz: clean
	$(RM) ../HelloWorld-$(VERS)
	@cd ..;ln -s HelloWorld HelloWorld-$(VERS)
	cd ..;tar zchvf HelloWorld-$(VERS).tar.gz HelloWorld-$(VERS)
	@cd ..;$(RM) HelloWorld-$(VERS)