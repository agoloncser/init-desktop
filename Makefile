# https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# ifeq ($(OS),Windows_NT)
# OS := win
# else
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
OS := linux
# The distribution should be able to be portably extracted by using
# /etc/os-release Note that there are more steps than just parsing this file on
# certain distributions. See
# https://gist.github.com/natefoo/814c5bf936922dad97ff for more details and
# alternatives
DISTRIBUTION := $(shell cat /etc/os-release | sed -n 's/^ID=\(.*\)$$/\1/p')
endif
ifeq ($(UNAME_S),Darwin)
OS := macos
endif

host := $(shell hostname)
# Debug information
$(info -- Running on host $(host))
$(info -- Detected OS $(OS))
$(info -- Detected distribution $(DISTRIBUTION))

BASE_TARGETS =
ASDF_TARGETS =
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(UNAME_S).mk
-include make/distro/$(DISTRIBUTION).mk
include make/asdf.mk
include make/gh.mk
include make/1password.mk

# dev :
# 	@install -m 0700 "share/commit-hook.sh" .git/hooks/prepare-commit-msg

# directories:
# 	@install -m 0700 "$HOME/src"
# 	@install -m 0700 "$HOME/tmp"
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

install : $(BASE_TARGETS) $(ASDF_TARGETS) $(GH_TARGETS) $(1PASSWORD_TARGETS);

# bash src/00_base.sh
# bash src/01_gpg.sh
# bash src/02_gitconfig_initial.sh
# bash src/04_asdf_configure.sh

# gh :
# 	bash src/10_gh.sh

# 1password :
# 	bash src/10_1password.sh

# tailscale :
# 	bash src/10_tailscale.sh

# resilio :
# 	bash src/10_resilio.sh

# .PHONY : 1password resilio gh tailscale dev dependencies
.PHONY : install
