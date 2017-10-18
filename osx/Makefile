.PHONY: all etc keyboard defaults homebrew go atom atom-backup
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard etc/.??* etc/*)
BINFILES := $(wildcard bin/??*) 

help:
	@echo ".bluemaex/osx Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: etc keyboard keyboard-user defaults homebrew go atom ## all osx tasks (probably only on a new setup)

etc: $(foreach F, $(DOTFILES), _install-dot/$F) ## Symlink files into home
_install-dot/%:
	@echo /bin/ln -sf $(DOTPATH)/$* $(HOME)/

keyboard: ## install all custom keyboard layouts
	mkdir -p "/Library/Keyboard Layouts"
	sudo cp -r $(DOTPATH)/KeyboardLayouts/*.bundle "/Library/Keyboard Layouts"
	
keyboard-user: keyboard ## set usumlaut as default keyboard for the current user
	sh -c 'cat $(DOTPATH)/KeyboardLayouts/com.apple.HIToolbox.plist > ~/Library/Preferences/com.apple.HIToolbox.plist'
	
keyboard-root: keyboard ## set usumlaut as default keyboard for all users
	sudo sh -c 'cat $(DOTPATH)/KeyboardLayouts/com.apple.HIToolbox.plist > /Library/Preferences/com.apple.HIToolbox.plist'

defaults: ## set some sane osx default preferences
	$(DOTPATH)/osx-defaults

homebrew: ## install homebrew and all homebrew packages (see Brewfile)
ifeq "$(wildcard /usr/local/bin/brew )" ""
	curl -fsSo $(TMPDIR)/brew-install.rb https://raw.githubusercontent.com/Homebrew/install/master/install
	/usr/bin/ruby $(TMPDIR)/brew-install.rb
endif
	brew bundle --verbose
		
go: ## install all go command line tools
	mkdir -p $(GOPATH)
	go get -u github.com/github/hub
	go get -u github.com/olivere/iterm2-imagetools/cmd/imgcat
	go get -u github.com/olivere/iterm2-imagetools/cmd/imgls
	go get -ldflags -s -a -u github.com/jteeuwen/go-bindata/...
	go get -ldflags -s -a -u github.com/convox/rack/...
	go get -u github.com/convox/praxis/cmd/cx
	
atom: ## install atom plugins
	apm install --packages-file $(DOTPATH)/etc/.atom/Atomfile
	apm upgrade --no-confirm
	
atom-backup: ## save current atom plugin list
	apm list --installed --bare > $(DOTPATH)/etc/.atom/Atomfile
