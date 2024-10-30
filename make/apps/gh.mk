gh-install-opensuse :
	@sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
	@sudo zypper ref
	@sudo zypper install -y gh

gh-install-ubuntu :
	@sudo apt-get update
	@sudo apt-get install curl -y
	@curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of="/usr/share/keyrings/githubcli-archive-keyring.gpg"
	@sudo chmod go+r "/usr/share/keyrings/githubcli-archive-keyring.gpg"
	@echo "deb [arch=${ARCHITECTURE} signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	@sudo apt-get update
	@sudo apt-get install gh -y

gh-install-fedora :
	@sudo dnf install 'dnf-command(config-manager)'
	@sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
	@sudo dnf install -y gh

gh-install-darwin :
	@brew install gh

gh-login :
	@gh auth login
	@gh auth setup-git

GH_TARGETS :=
ifeq (${OS},Darwin)
GH_TARGETS += gh-install-darwin
endif
ifneq (${OS},Darwin)
GH_TARGETS += gh-install-${DISTRIBUTION}
endif

gh: $(GH_TARGETS) 
