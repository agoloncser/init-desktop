.PHONY : asdf asdf-upgrade asdf-setup-bashrc

ASDF := ${HOME}/.asdf/asdf.sh
ASDF_PLUGINS := ghq nodejs python

$(ASDF) :
	@git clone --branch "${ASDF_VERSION}" "https://github.com/asdf-vm/asdf.git" "${HOME}/.asdf"

$(ASDF_PLUGINS) : $(ASDF)
	@if [ ! -d "$(addprefix ${HOME}/.asdf/plugins/,$@)" ] ; then ASDF_DIR=${HOME}/.asdf;. "${HOME}/.asdf/asdf.sh" && asdf plugin add $@ ; fi

${HOME}/.tool-versions : $(ASDF_PLUGINS)
	$(info Install tool-versions...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && asdf install

${HOME}/.default-python-packages : ${HOME}/.tool-versions
	$(info update python packages...)
	@install -v -m 0600 share/asdf/requirements.txt "$@"
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && pip install --upgrade pip
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && pip install --upgrade -r "$@"

${HOME}/.default-npm-packages : ${HOME}/.tool-versions
	$(info Update npm packages...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && xargs npm install --global < "$$HOME/.default-npm-packages"
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && npm update -g npm
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && xargs npm update --global < "$$HOME/.default-npm-packages"

asdf-upgrade: $(ASDF)
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && asdf update
	@ASDF_DIR=${HOME}/.asdf; . "${HOME}/.asdf/asdf.sh" && asdf plugin-update --all

asdf-setup-bashrc:
	grep '\.asdf/asdf.sh' ${HOME}/.bashrc || echo '. "${HOME}/.asdf/asdf.sh"' >> ${HOME}/.bashrc

ifndef INSTALL_FAST
ASDF_TARGETS += ${HOME}/.tool-versions asdf-upgrade
endif
ASDF_TARGETS += ${HOME}/.default-python-packages ${HOME}/.default-npm-packages asdf-setup-bashrc

asdf: $(ASDF_TARGETS)

