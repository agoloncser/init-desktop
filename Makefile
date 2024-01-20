PREFIX ?= ${HOME}/.local/bin/
DESTDIR ?=
SRCDIR := ./src

SCRIPTS  = $(SRCDIR)/02_genssh.sh
# SCRIPTS += $(SRCDIR)/__select-yubi-ssh.sh

install :
	@install -v -d "$(PREFIX)" && install -m 0700 -v "$(SRCDIR)/02_genssh.sh" "$(PREFIX)/genssh.sh"
	bash src/00_base.sh
	bash src/01_gpg.sh
	bash src/02_gitconfig_initial.sh
	bash src/02_trust_github.sh
	bash src/04_asdf_configure.sh
