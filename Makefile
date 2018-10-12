ROOTDIR							=	$(CURDIR)

SHELL							=	/bin/sh

PROJNAME						=	open-materials-datasets

RM								=	rm
COPY							=	cp
FIND							=	find

CONDA							=	conda
CONDA_ENV_FILE					=	environment.yml

PY								?=	python3
PY_SETUP						=	setup.py
PY_SETUP_DOCS					=	build_sphinx
PY_PROJ_SH						=	projtool

JUPYTER							=	jupyter
JUPYTERLAB_EXTENSIONS			=	jupyterlab_vim									\
									jupyterlab_bokeh								\
									jupyterlab_templates							\
									@jupyterlab/git									\
									@jupyterlab/github								\
									@jupyterlab/plotly-extension					\
									@mflevine/jupyterlab_html						\
									@jupyter-widgets/jupyterlab-manager				\
									jupyter-matplotlib								\
									@ryantam626/jupyterlab_code_formatter
JUPYTERLAB_SERVEREXTENSION		=	jupyterlab_templates							\
									jupyterlab_git									\
									jupyterlab_code_formatter

CLEAN_FILES						=	build/											\
									*_cache/										\
									docs/_build/ 									\
									dist/											\
									.pytest_cache/									\
									*.egg-info/

define cleanup
	-$(RM) -rf $(CLEAN_FILES)
endef

define makefile_help
	@echo 'Makefile for the data visualization demo repository.                      '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make help                           display this message (default)     '
	@echo '                                                                          '
	@echo '   make build                          build everything needed to install '
	@echo '   make clean                          remove temporary and build files   '
	@echo '   make develop                        install project in development mode'
	@echo '   make docs                           generate documentation             '
	@echo '   make env                            create conda venv and install deps '
	@echo '   make sdist                          create a source distribution       '
	@echo '   make test                           run unit tests                     '
	@echo '                                                                          '
endef

define pycache_cleanup
	$(FIND) -name "__pycache__" -type d -exec $(RM) -rf {} +
endef

define update_conda_env
	bash -lc "$(CONDA) env update --file $(CONDA_ENV_FILE)"
endef

define run_setup_py
	$(PY) ./$(PY_SETUP) $(1)
endef

define install_jupyterlab_extensions
	$(JUPYTER) labextension install $(1)
endef

define install_serverextension
	$(JUPYTER) serverextension enable --py $(1)
endef

help :
	$(call makefile_help)

build :
	$(call run_setup_py,build)

clean :
	$(call cleanup)
	$(call pycache_cleanup)

develop :
	$(call run_setup_py,develop)

docs :
	$(call run_setup_py,$(PY_SETUP_DOCS))

env :
	$(call update_conda_env)

labextensions :
	$(foreach extension,$(JUPYTERLAB_EXTENSIONS),$(call install_jupyterlab_extensions,$(extension));)

serverextensions :
	$(foreach serverextension,$(JUPYTERLAB_SERVEREXTENSION),$(call install_serverextension,$(serverextension));)

sdist :
	$(call run_setup_py,sdist)

test :
	$(call run_setup_py,test)

.SILENT :
.PHONY : help build clean develop docs env labextensions serverextensions sdist test
