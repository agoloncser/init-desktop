.PHONY: ssh

# Directories
SSH_SRC_DIR := ${SRCDIR}/ssh/conf
SSH_DST_DIR := ${HOME}/.ssh

# SSH Configurations
SSH_CONFIGS := $(wildcard ${SSH_SRC_DIR}/config ${SSH_SRC_DIR}/conf.d/*.conf)

# Rule to install SSH configurations
$(SSH_DST_DIR)/%: $(SSH_SRC_DIR)/%
	install -m 0700 -v -d $(dir $@)
	install -m 0600 -v $< $@

# Target to install all SSH configurations
ssh: $(addprefix $(SSH_DST_DIR)/, $(patsubst ${SSH_SRC_DIR}/%,%,${SSH_CONFIGS}))

# Add SSH CA host CA certificates to known_hosts
ssh-ca-host-ca-certs:
	@touch ${SSH_DST_DIR}/known_hosts
	@for cert_file in $$(find ${SSH_SRC_DIR}/host_ca_certs -type f) ; \
		do grep -Ff $$cert_file ${SSH_DST_DIR}/known_hosts >/dev/null \
		|| cat $$cert_file >> ${SSH_DST_DIR}/known_hosts ; \
	done

# Sign the local ssh hostkeys
ssh-sign-hostkeys:
	ca-ssh-create-local-hostkey.sh -C mmegh-host-ca

# Add ssh to desktop and help targets
DESKTOP_TARGETS += ssh ssh-ca-host-ca-certs
HELP_TARGETS += ssh ssh-ca-host-ca-certs
