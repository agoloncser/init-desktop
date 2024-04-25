ASDF := "${HOME}/.asdf/asdf.sh"
ASDF_PLUGINS := ghq nodejs python

$(ASDF) :
    git clone --branch "$ASDF_VERSION" "https://github.com/asdf-vm/asdf.git" "~/.asdf"

$(ASDF_PLUGINS) : $(ASDF)
	@if [ ! -d "$(addprefix ${HOME}/.asdf/plugins/,$@)" ] ; then . "${HOME}/.asdf/asdf.sh" && asdf plugin add $@ ; fi

${HOME}/.tool-versions : $(ASDF_PLUGINS)
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
	@xargs npm install --global < "$$HOME/.default-npm-packages"
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

.PHONY : asdf
