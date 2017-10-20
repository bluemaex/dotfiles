.PHONY: all etc keyboard defaults homebrew go atom atom-backup
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard etc/.??* etc/*)
BINFILES := $(wildcard bin/??*)
LIBFILES := $(wildcard Library/**/**)


help:
	@echo ".bluemaex/osx Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: etc lib keyboard keyboard-user defaults shell homebrew go atom ## all osx tasks (probably only on a new setup)

etc: $(foreach F, $(DOTFILES), _install-dot/$F) ## Symlink files into home
_install-dot/%:
	/bin/ln -sf $(DOTPATH)/$* $(HOME)/

lib: $(foreach F, $(LIBFILES), _install-lib/$F) ## Symlink Library files into ~/Library
_install-lib/%:
	@echo /bin/ln -sf $(DOTPATH)/$* $(HOME)/$*

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

shell: ## adds homebrew bash and zsh to /etc/shells and sets bash as new shell
	sudo sh -c "if ! grep /usr/local/bin/bash /etc/shells; then echo /usr/local/bin/bash >> /etc/shells; fi"
	chsh -s /usr/local/bin/bash

go: ## install all go command line tools
	mkdir -p $(GOPATH)
	go get -u github.com/github/hub
	go get -u github.com/olivere/iterm2-imagetools/cmd/imgcat
	go get -u github.com/olivere/iterm2-imagetools/cmd/imgls
	go get -ldflags -s -a -u github.com/jteeuwen/go-bindata/...
	go get -ldflags -s -a -u github.com/convox/rack/...
	go get -u github.com/convox/praxis/cmd/cx

lolcommits: ## install lolcommits and activate it for everyone
	gem install lolcommits
	cd $(HOME)/.git_template.d/hooks && mv post-commit.lolcommits post-commit

atom: ## install atom plugins
	apm install --packages-file $(DOTPATH)/etc/.atom/Atomfile
	apm upgrade --no-confirm

atom-backup: ## save current atom plugin list
	apm list --installed --bare > $(DOTPATH)/etc/.atom/Atomfile
