
SSH_SRC := share/ssh-server
SSH_TARGET := /etc/ssh
SSH_CONFIGS := ${SSH_SRC}/sshd_config ${SSH_SRC}/TrustedUserCAKeys

SSH_TARGETS := $(subst ${SSH_SRC},${SSH_TARGET},$(SSH_CONFIGS))

$(SSH_TARGETS) : $(SSH_CONFIGS)
	ifneq ($(wildcard $@),)
		grep 'scripts-init-server$' $@ || sudo cp $< $@
	else
		sudo cp $< $@
	endif

	ifeq (${OS},Linux)
		sudo systemctl enable ssh
		sudo systemctl restart ssh
	endif
	ifeq (${OS},FreeBSD)
		sysrc sshd_enable="YES"
		service sshd restart
	endif

ssh-server : $(SSH_TARGETS)

SERVER_TARGETS += ssh-server
