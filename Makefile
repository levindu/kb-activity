BIN     = $(DESTDIR)/usr/bin
ETC     = $(DESTDIR)/etc

all: build

build:
	gcc -o kb-activity syndaemon.c -lX11 -lXtst

install: build
	install -d $(BIN) $(ETC)/default $(ETC)/modprobe.d
	install kb-activity $(BIN)
	install set-touch-pad.sh $(BIN)
	install auto-touch-pad.sh $(BIN)
	install -m644 etc/touch-pad.conf $(ETC)/default/touch-pad
	install -m644 etc/touch-pad.mod.conf $(ETC)/modprobe.d/touch-pad.conf
