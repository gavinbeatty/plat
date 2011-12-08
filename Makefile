SHELL = /bin/sh
.SUFFIXES:

.PHONY: help all configure config conf confclean install
help:
	@echo "Targets: help all configure confclean install"

PREFIX = /usr/local
VERSION_MAJOR = 1
VERSION_MINOR = 5
VERSION_PATCH = 0
VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)

SED ?= sed
RM ?= rm
INSTALL ?= install
INSTALL_DIR ?= $(INSTALL) -d
INSTALL_DATA ?= $(INSTALL) -m 0644

gen_p = @echo '    GEN       ' $@;

all: configure

plat.pc: plat.pc.in
	$(gen_p)$(SED) \
		-e 's#@VERSION_MAJOR@#$(VERSION_MAJOR)#g' \
		-e 's#@VERSION_MINOR@#$(VERSION_MINOR)#g' \
		-e 's#@VERSION_PATCH@#$(VERSION_PATCH)#g' \
		-e 's#@PREFIX@#$(PREFIX)#g' \
		plat.pc.in > plat.pc

src/plat/config.h: src/plat/config.h.in
	$(gen_p)$(SED) \
		-e 's#@VERSION_MAJOR@#$(VERSION_MAJOR)#g' \
		-e 's#@VERSION_MINOR@#$(VERSION_MINOR)#g' \
		-e 's#@VERSION_PATCH@#$(VERSION_PATCH)#g' \
		src/plat/config.h.in > src/plat/config.h
configure: src/plat/config.h plat.pc
config: configure
conf: configure

confclean:
	$(RM) src/plat/config.h plat.pc


install: configure
	$(INSTALL_DIR) $(DESTROOT)$(PREFIX)/include/plat
	$(INSTALL_DATA) $(wildcard src/plat/*.h) $(DESTROOT)$(PREFIX)/include/plat/
