SHELL = /bin/sh
.SUFFIXES:

.PHONY: help all build install
help:
	@echo "Targets: help all build install"

PROJECT_NAME = plat
HOMEPAGE = http://github.com/gavinbeatty/plat
PREFIX = /usr/local
VERSION_MAJOR := 1
VERSION_MINOR := 5
VERSION_PATCH := 0
VERSION := $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)

SED ?= sed
INSTALL ?= install
INSTALL_DIR ?= $(INSTALL) -d
INSTALL_DATA ?= $(INSTALL) -m 0644

gen_p = @echo '    GEN       ' $@;

all: plat.pc src/plat/config.h

plat.pc: plat.pc.in
	$(gen_p)$(SED) \
		-e 's#@PROJECT_NAME@#$(PROJECT_NAME)#g' \
		-e 's#@HOMEPAGE@#$(HOMEPAGE)#g' \
		-e 's#@PREFIX@#$(PREFIX)#g' \
		$(srcdir)/plat.pc.in > $(srcdir)/plat.pc

src/plat/config.h: src/plat/config.h.in
	$(gen_p)$(SED) \
		-e 's#@VERSION_MAJOR@#$(VERSION_MAJOR)#g' \
		-e 's#@VERSION_MINOR@#$(VERSION_MINOR)#g' \
		-e 's#@VERSION_PATCH@#$(VERSION_PATCH)#g' \
		-e 's#@VERSION@#$(VERSION)#g' \
		$(srcdir)/src/plat/config.h.in > $(srcdir)/src/plat/config.h
build: src/plat/config.h plat.pc

install: build
	$(INSTALL_DIR) $(DESTROOT)$(PREFIX)/include/plat
	$(INSTALL_DATA) $(wildcard src/plat/*.h) $(DESTROOT)$(PREFIX)/include/plat/
