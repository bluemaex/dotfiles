.PHONY: all keyboard defaults homebrew atom
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	@echo ".bluemaex/osx Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: keyboard defaults homebrew atom ## all osx tasks, probably only on a new setup

keyboard: ## install all custom keyboard layouts (TODO: find out how to activate them)
		mkdir -p /Library/Keyboard\ Layouts
		cp -r $(DOTPATH)/osx/KeyboardLayouts/*.bundle /Library/Keyboard\ Layouts

defaults: ## set some sane osx default preferences
		$(DOTPATH)/osx/osx-defaults

homebrew: ## install homebrew and all homebrew packages (see Brewfile)
ifeq "$(wildcard /usr/local/bin/brew )" ""
		curl -fsSo $(TMPDIR)/brew-install.rb https://raw.githubusercontent.com/Homebrew/install/master/install
		/usr/bin/ruby $(TMPDIR)/brew-install.rb
endif
		brew bundle
		
go:
	mkdir -p $(HOME)/workspace/go
	go get github.com/convox/rack/...
	go get github.com/github/hub
	
atom:
		$(DOTPATH)/Atom/Atomfile