UNAME_A := $(shell uname -a)
BREW := /opt/homebrew/bin/brew
ifeq ($(UNAME_A),x86_64)
BREW := /usr/local/bin/brew
endif

PACKAGES += curl fish git gnupg mosh openssh pass pass-otp tmux fzf git-lfs git-annex
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += openssl readline sqlite3 tcl-tk zlib ripgrep
PACKAGES_CASKS := gpg-suite-no-mail emacs

$(BREW) :
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

darwin-brew-update : | $(BREW)
	@${BREW} update

darwin-brew-upgrade : | $(BREW)
	@${BREW} update

darwin-base : | $(BREW)
	@${BREW} install $(PACKAGES)
	@${BREW} install --cask $(PACKAGES_CASKS)

brew-setup-shell:
	@grep 'brew\ shellenv' ${HOME}/.bashrc || echo 'eval "$$(${BREW} shellenv)"' >> ${HOME}/.bashrc
	@grep 'brew\ shellenv' ${HOME}/.zshrc || echo 'eval "$$(${BREW} shellenv)"' >> ${HOME}/.zshrc

ASDF_TARGETS += ${HOME}/.tool-versions asdf-upgrade
ASDF_TARGETS += ${HOME}/.default-python-packages ${HOME}/.default-npm-packages asdf-setup-shell

ifndef INSTALL_FAST
BASE_TARGETS += darwin-brew-update
BASE_TARGETS += darwin-brew-upgrade
endif
BASE_TARGETS += darwin-base
