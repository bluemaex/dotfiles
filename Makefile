.PHONY: all bin etc osx go
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard etc/.??*) 

help:
	@echo ".bluemaex Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@$(MAKE) osx-help

all: etc bin go ## Run everything (except osx tasks)

etc: $(foreach F, $(DOTFILES), _install/$F) ## Symlink dotfiles

bin: ## symlink bin to $HOME/.bin
		/bin/ln -sfn $(DOTPATH)/bin $(HOME)/.bin

go: ## install all go command line tools
	mkdir -p $(GOPATH)
	go get github.com/github/hub
	go get -ldflags -s -a -u github.com/jteeuwen/go-bindata/...
	go get -ldflags -s -a -u github.com/convox/rack/...
	go get github.com/convox/praxis/cmd/cx
	
osx: ## run osx all task, see below
	$(MAKE) -C ./osx all

osx-%:
	@$(MAKE) -C ./osx $*

# Meta install and uninstall targets
_install/%:
		@echo /bin/ln -sf $(DOTPATH)/$* $(HOME)/
