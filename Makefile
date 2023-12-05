PREFIX ?= ${HOME}/.local/bin/
DESTDIR ?=
SRCDIR := ./src

SCRIPTS  = $(SRCDIR)/02_genssh.sh
# SCRIPTS += $(SRCDIR)/__select-yubi-ssh.sh

# .PHONY: install uninstall

install :
	@install -v -d "$(PREFIX)" && install -m 0700 -v "$(SRCDIR)/02_genssh.sh" "$(PREFIX)/genssh.sh"
	bash src/00_base.sh

.PHONY : asdf gpg
asdf :
	bash src/03_asdf_deps.sh
	bash src/04_asdf_configure.sh

gpg :
	bash src/01_gpg.sh
