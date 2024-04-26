UNAME_A := $(shell uname -a)
BREW := /opt/homebrew/bin/brew
ifeq ($(UNAME_A),x86_64)
BREW := /usr/local/bin/brew
endif

PACKAGES += curl fish git gnupg mosh openssh pass pass-otp tmux
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += openssl readline sqlite3 tcl-tk zlib
PACKAGES_CASKS := gpg-suite-no-mail emacs

$(BREW) :
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

darwin-brew-update : | $(BREW)
	@brew update

darwin-brew-upgrade : | $(BREW)
	@brew update

darwin-base : | $(BREW)
	@brew install $(PACKAGES)
	@brew install --cask $(PACKAGES_CASKS)

ifndef INSTALL_FAST
BASE_TARGETS += darwin-brew-update
BASE_TARGETS += darwin-brew-upgrade
endif
BASE_TARGETS += darwin-base
