# Configure git
git:
	@install -m 0700 -d -v "${HOME}/src"
	@git config --global ghq.root "${HOME}/src"
	@git config --global pull.rebase "false"
	@git config --global credential.helper cache
	@git config --global core.autocrlf "false"
	@git config --global diff.gpg.textconv "gpg --no-tty --decrypt"
	@git config --global init.defaultBranch main

	@git config --global alias.root "rev-parse --show-toplevel"
	@git config --global alias.b "branch"
	@git config --global alias.d "diff"
	@git config --global alias.l "log"
	@git config --global alias.l1 "log --oneline"
	@git config --global alias.r "remote"
	@git config --global alias.f "fetch"
	@git config --global alias.p "pull"
	@git config --global alias.s "status"
	@git config --global alias.a "annex"
	@git config --global alias.ai "annex info --fast"
	@git config --global alias.aS "annex sync --no-content"

	@git config --global filter.lfs.clean "git-lfs clean -- %f"
	@git config --global filter.lfs.smudge "git-lfs smudge -- %f"
	@git config --global filter.lfs.process "git-lfs filter-process"
	@git config --global filter.lfs.required "true"

# Add targets to groups
DESKTOP_TARGETS += git
SERVER_TARGETS += git
HELP_TARGET += git
