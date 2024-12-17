.PHONY : freebsd-pkg-update freebsd-pkg-upgrade freebsd-base

PACKAGES += bash curl fish git mosh rsync sudo tmux fzf
PACKAGES += hunspell en-hunspell hu-hunspell hs-git-annex

freebsd-pkg-update :
	@pkg update -f

freebsd-pkg-upgrade :
	@export ASSUME_ALWAYS_YES=YES ; pkg upgrade -y
	@export PAGER=cat ; freebsd-update fetch install --not-running-from-cron

freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)


ifndef INSTALL_FAST
BASE_TARGETS += freebsd-pkg-update
BASE_TARGETS += freebsd-pkg-upgrade
endif
BASE_TARGETS += freebsd-base
