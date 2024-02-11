.PHONY : 1password resilio gh tailscale

install :
	bash src/00_base.sh
	bash src/01_gpg.sh
	bash src/02_gitconfig_initial.sh
	bash src/04_asdf_configure.sh

gh :
	bash src/10_gh.sh

1password :
	bash src/10_1password.sh

tailscale :
	bash src/10_tailscale.sh

resilio :
	bash src/10_resilio.sh
