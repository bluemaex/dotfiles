.PHONY: all bin etc osx
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard etc/.??*) 
BINFILES := $(wildcard bin/??*) 

help:
	@echo ".bluemaex Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@$(MAKE) osx-help

all: etc bin ## Run everything (except osx tasks)

etc: $(foreach F, $(DOTFILES), _install-dot/$F) ## Symlink dotfiles

bin: _make-bin $(foreach F, $(BINFILES), _install-bin/$F) ## symlink bin files to $HOME/.bin
	
osx: ## run osx all task, see below
	$(MAKE) -C ./osx all

osx-%:
	@$(MAKE) -C ./osx $*

# Meta install and uninstall targets
_install-dot/%:
	/bin/ln -sf $(DOTPATH)/$* $(HOME)/

_make-bin:
	mkdir -p $(HOME)/.bin

_install-bin/%:
	/bin/ln -sf $(DOTPATH)/$* $(HOME)/.bin/