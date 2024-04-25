ASDF := "${HOME}/.asdf/asdf.sh"
# renovate: datasource=github-releases depName=asdf-vm/asdf versioning=semver registryUrl=https://github.com
ASDF_VERSION := v0.13.1
ASDF_PLUGINS := kajisha/asdf-ghq asdf-vm/asdf-nodejs danhper/asdf-python


PLUGINS_INSTALLED := $(lastword $(subst asdf-, ,${ASDF_PLUGINS}))
# PLUGINS_INSTALLED := $(addprefix ~/.asdf/plugins/,$(lastword $(subst -, ,$(shell basename ${ASDF_PLUGINS}))))

$(ASDF) :
    git clone --branch "$ASDF_VERSION" "https://github.com/asdf-vm/asdf.git" "~/.asdf"

$(ASDF_PLUGINS) : $(ASDF)
	$(eval PLUGIN := $(lastword $(subst -, ,$@)))
	$(eval PLUGINDIR := $(addprefix ${HOME}/.asdf/plugins/,$(lastword $(subst -, ,$@))))
	@if [ ! -d "${PLUGINDIR}" ] ; then . "${HOME}/.asdf/asdf.sh" && asdf plugin add ${PLUGIN} "https://github.com/$@" ; fi

asdf-install-plugins : $(ASDF_PLUGINS)

${HOME}/.tool-versions : $(ASDF)
	$(info Install tool-versions...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	@ . "${HOME}/.asdf/asdf.sh" && asdf install

${HOME}/.default-python-packages : ${HOME}/.tool-versions
	$(info update python packages...)
	@install -v -m 0600 share/asdf/requirements.txt "$@"
	@pip install --upgrade pip
	@pip install --upgrade -r "$@"

${HOME}/.default-npm-packages : ${HOME}/.tool-versions
	$(info Update npm packages...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	@npm update -g npm
	@xargs npm update --global < "$$HOME/.default-npm-packages"

asdf-upgrade: $(ASDF)
	@ . "${HOME}/.asdf/asdf.sh" && asdf update
	@ . "${HOME}/.asdf/asdf.sh" && asdf plugin-update --all

ifndef INSTALL_FAST
ASDF_TARGETS += ${HOME}/.tool-versions asdf-upgrade
endif
ASDF_TARGETS += ${HOME}/.default-python-packages ${HOME}/.default-npm-packages

asdf: $(ASDF_TARGETS)
