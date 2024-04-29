.PHONY : freebsd-pkg-update freebsd-pkg-upgrade freebsd-base

PACKAGES += bash curl fish git mosh rsync sudo tmux

freebsd-pkg-update :
	@pkg update

freebsd-pkg-upgrade :
	@pkg upgrade -y
	@freebsd-update fetch install

freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)


ifndef INSTALL_FAST
BASE_TARGETS += freebsd-pkg-update
BASE_TARGETS += freebsd-pkg-upgrade
endif
BASE_TARGETS += freebase-base
