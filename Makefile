OS := $(shell uname -s)
ARCHITECTURE := $(shell uname -m)
ifeq ($(OS),Linux)
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
$(info -- Version codename .......: $(ARCHITECTURE))
$(info -- Inside docker ..........: $(INSIDE_DOCKER))

BASE_TARGETS :=
SERVER_TARGETS := 
DESKTOP_TARGETS := 
ASDF_TARGETS :=
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include versions.mk
include make/apps/asdf.mk
include make/apps/gh.mk
include make/apps/1password.mk
include make/apps/resilio.mk
include make/apps/ssh-server.mk
include make/apps/tailscale.mk

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

server : directories $(BASE_TARGETS) $(SERVER_TARGETS)
desktop : directories $(BASE_TARGETS) $(DESKTOP_TARGETS)
install : desktop

apps : directories $(GH_TARGETS) $(1PASSWORD_TARGETS) $(RESILIO_TARGETS) $(TAILSCALE_TARGETS);

.PHONY : apps caps-lock gnupg dev directories server desktop install

test :
	fish --version
	git --version
	gpg --version
	node --version
	pass --version
	python --version
	tmux -V
