# https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# ifeq ($(OS),Windows_NT)
# OS := win
# else
OS := $(shell uname -s)
ifeq ($(OS),Linux)
# The distribution should be able to be portably extracted by using
# /etc/os-release Note that there are more steps than just parsing this file on
# certain distributions. See
# https://gist.github.com/natefoo/814c5bf936922dad97ff for more details and
# alternatives
DISTRIBUTION := $(shell cat /etc/os-release | sed -n 's/^ID=\(.*\)$$/\1/p')
VERSION_CODENAME := $(shell cat /etc/os-release | sed -n 's/^VERSION_CODENAME=\(.*\)$$/\1/p')
endif

# INSIDE_DOCKER := $(or $(and $(wildcard /.dockerenv),1),0)
ifneq ($(wildcard /.dockerenv),)
    # .dockerenv file exists
    INSIDE_DOCKER := 1
else
    # .dockerenv file does not exist
    # INSIDE_DOCKER remains undefined
endif

HOST := $(shell hostname)
# Debug information
$(info -- Running on host.........: $(HOST))
$(info -- Detected OS.............: $(OS))
$(info -- Detected distribution...: $(DISTRIBUTION))
$(info -- Version codename .......: $(VERSION_CODENAME))
$(info -- Inside docker ..........: $(INSIDE_DOCKER))

BASE_TARGETS =
ASDF_TARGETS =
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include versions.mk
include make/apps/asdf.mk
include make/apps/gh.mk
include make/apps/1password.mk
include make/apps/resilio.mk

dev :
	@install -m 0700 "share/commit-hook.sh" .git/hooks/prepare-commit-msg

directories:
	@install -d -m 0700 "$HOME/src"
	@install -d -m 0700 "$HOME/tmp"

gnupg :
	install -m 0700 -v -d ${HOME}/.$@
	install -m 0600 -v share/$@/scdaemon.conf  ${HOME}/.$@
	install -m 0600 -v share/$@/gpg.conf       ${HOME}/.$@
	install -m 0600 -v share/$@/gpg-agent.conf ${HOME}/.$@

git :
	$@ config --global credential.helper cache
	$@ config --global alias.root "rev-parse --show-toplevel"
	$@ config --global ghq.root ~/src
	@install -m 0700 -d -v "${HOME}/src"

caps-lock :
	@gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps']"

install: directories $(BASE_TARGETS) $(ASDF_TARGETS)

apps : directories $(GH_TARGETS) $(1PASSWORD_TARGETS) $(RESILIO_TARGETS) $(TAILSCALE_TARGETS);

.PHONY : apps caps-lock gnupg dev directories
