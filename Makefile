CC = gcc -std=gnu99

libnotify_CFLAGS = $(shell pkg-config --cflags libnotify)
libnotify_LIBS = $(shell pkg-config --libs libnotify)

libpulse_CFLAGS = $(shell pkg-config --cflags libpulse)
libpulse_LIBS = $(shell pkg-config --libs libpulse)

ifdef libnotify_LIBS
libnotify_CFLAGS += -DHAVE_NOTIFY
endif

CFLAGS := -Wall -Wextra -pedantic -O2 -g $(libpulse_CFLAGS) $(libnotify_CFLAGS) $(CFLAGS)
LDLIBS := -lm $(libpulse_LIBS) $(libnotify_LIBS)

all: ponymix

install: ponymix
	install -Dm755 ponymix $(DESTDIR)/usr/bin/ponymix
	install -Dm644 ponymix.1 $(DESTDIR)/usr/share/man/man1/ponymix.1

check: ponymix
	./runtests ./ponymix

clean:
	$(RM) ponymix ponymix.o
