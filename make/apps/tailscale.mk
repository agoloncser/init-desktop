# https://tailscale.com/download/linux/opensuse-tumbleweed

tailscale-install-opensuse :
	@sudo zypper ar -g -r https://pkgs.tailscale.com/stable/opensuse/tumbleweed/tailscale.repo
	@sudo zypper ref
	@sudo zypper in -y tailscale

tailscale-install-ubuntu :
	@curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.noarmor.gpg" | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
	@curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.tailscale-keyring.list" | sudo tee /etc/apt/sources.list.d/tailscale.list
	@sudo apt-get update
	@sudo apt-get install -y tailscale

tailscale-install-fedora :
	@sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
	@sudo dnf install -y tailscale

tailscale-install-darwin :
	@brew install --cask tailscale

tailscale-configure-linux :
	@sudo systemctl enable --now tailscaled

TAILSCALE_TARGETS :=
ifeq (${OS},Darwin)
TAILSCALE_TARGETS += tailscale-install-darwin
endif
ifneq (${OS},Darwin)
TAILSCALE_TARGETS += "tailscale-install-${DISTRIBUTION}" tailscale-configure-linux
endif


tailscale: $(TAILSCALE_TARGETS) 
