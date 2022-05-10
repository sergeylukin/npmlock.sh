
BIN ?= npmlock
PREFIX ?= /usr/local

install:
	cp npmlock.sh $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
