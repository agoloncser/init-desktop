
# https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux

resilio-install-opensuse :
	@sudo rpm --import https://linux-packages.resilio.com/resilio-sync/key.asc
	@sudo zypper ar --gpgcheck-allow-unsigned-repo -f https://linux-packages.resilio.com/resilio-sync/rpm/\$basearch resilio-sync || true
	@sudo zypper install -y resilio-sync

resilio-install-ubuntu :
	@sudo apt-get update
	@sudo apt-get install -y wget
	@echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
	@wget -qO- https://linux-packages.resilio.com/resilio-sync/key.asc | sudo tee /etc/apt/trusted.gpg.d/resilio-sync.asc > /dev/null 2>&1
	@sudo apt-get update
	@sudo apt-get install -y resilio-sync

resilio-install-fedora :
	@sudo rpm --import https://linux-packages.resilio.com/resilio-sync/key.asc
	@printf "[resilio-sync]\nname=Resilio Sync\nbaseurl=https://linux-packages.resilio.com/resilio-sync/rpm/\$basearch\nenabled=1\ngpgcheck=1\n" | sudo tee /etc/yum.repos.d/resilio-sync.repo
	@sudo dnf install -y resilio-sync

resilio-install-darwin :
	@brew install --cask resilio-sync

resilio-configure-linux :
	@sudo systemctl stop resilio-sync
	@sudo systemctl disable resilio-sync || true
	@systemctl --user enable resilio-sync
	@systemctl --user start resilio-sync

RESILIO_TARGETS :=
ifeq (${OS},Darwin)
RESILIO_TARGETS += resilio-install-darwin
endif
ifeq (${OS},Linux)
RESILIO_TARGETS += resilio-configure-linux
endif
ifneq (${OS},Darwin)
RESILIO_TARGETS += "resilio-install-${DISTRIBUTION}"
endif

resilio: $(RESILIO_TARGETS) 
