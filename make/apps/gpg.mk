# Directories
GPG_DST_DIR := ${HOME}/.gnupg
GPG_SRC_DIR := ${SRCDIR}/gpg/conf

# Files to be installed
GPG_FILES := scdaemon.conf gpg-agent.conf gpg.conf

# Rule to install GPG configuration files
$(GPG_DST_DIR)/%: $(GPG_SRC_DIR)/%
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

# Target to install all GPG files
gpg: $(addprefix $(GPG_DST_DIR)/, $(GPG_FILES))

# Add gpg to desktop and help targets
SERVER_TARGETS += gpg
DESKTOP_TARGETS += gpg
HELP_TARGETS += gpg
