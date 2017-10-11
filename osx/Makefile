.PHONY: all bin etc keyboard defaults homebrew go atom atom-backup
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard etc/.??* etc/*)
BINFILES := $(wildcard bin/??*) 

help:
	@echo ".bluemaex/osx Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: bin etc keyboard defaults homebrew atom ## all osx tasks (probably only on a new setup)

bin: $(foreach F, $(BINFILES), _install-bin/$F) ## symlink bin files to $HOME/.bin	
_install-bin/%:
	@echo /bin/ln -sf $(DOTPATH)/$* $(HOME)/.bin/

etc: $(foreach F, $(DOTFILES), _install-dot/$F) ## Symlink files into home
_install-dot/%:
	@echo /bin/ln -sf $(DOTPATH)/$* $(HOME)/

keyboard: ## install all custom keyboard layouts (TODO: find out how to activate them)
	mkdir -p "/Library/Keyboard Layouts"
	cp -r $(DOTPATH)/osx/KeyboardLayouts/*.bundle /Library/Keyboard\ Layouts

defaults: ## set some sane osx default preferences
	$(DOTPATH)/osx/osx-defaults

homebrew: ## install homebrew and all homebrew packages (see Brewfile)
ifeq "$(wildcard /usr/local/bin/brew )" ""
	curl -fsSo $(TMPDIR)/brew-install.rb https://raw.githubusercontent.com/Homebrew/install/master/install
	/usr/bin/ruby $(TMPDIR)/brew-install.rb
endif
	brew bundle
		
go: ## install all go command line tools
	mkdir -p $(GOPATH)
	go get -u github.com/github/hub
	go get -ldflags -s -a -u github.com/jteeuwen/go-bindata/...
	go get -ldflags -s -a -u github.com/convox/rack/...
	go get -u github.com/convox/praxis/cmd/cx
	
atom: ## install atom plugins
	apm install --packages-file $(DOTPATH)/etc/.atom/Atomfile
	apm upgrade --no-confirm
	
atom-backup: ## save current atom plugin list
	apm list --installed --bare > $(DOTPATH)/etc/.atom/Atomfile