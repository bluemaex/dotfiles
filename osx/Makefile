.PHONY: all etc keyboard defaults homebrew go atom atom-backup
.DEFAULT_GOAL := help

DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
SYMFILES := $(wildcard etc-sym/.??*)
PREFPATH := $(DOTPATH)/etc
PREFFILES := $(shell find $(PREFPATH) -type f ! -iname ".DS_Store" | sed 's~$(PREFPATH)/~~g' | sed 's/ /@/g')
GOPATH := $(if $(GOPATH),$(GOPATH),$(HOME)/.go)

help:
	@echo ".bluemaex/osx Tasks:"
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: etc keyboard keyboard-user defaults homebrew shell go npm ## all osx tasks (probably only on a new setup)

etc: $(foreach S, $(SYMFILES), _etc-sym/$S) $(foreach F, $(PREFFILES), _etc-sub/$F) ## Symlink files into home
_etc-sym/%:
	/bin/ln -sf "$(DOTPATH)/$*" $(HOME)
_etc-sub/%:
	mkdir -p "$(HOME)/$(subst @, ,$(dir $*))" && /bin/ln -sf "$(PREFPATH)/$(subst @, ,$*)" "$(HOME)/$(subst @, ,$*)"

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

npm: ## install global npm packages
	yarn global add

lolcommits: ## install lolcommits and activate it for every git repo by default
	gem install lolcommits
	cd $(HOME)/.git_template.d/hooks && cp post-commit.lolcommits post-commit
	ln -sf /Users/bluemaex/Seafile/Photos/lolcommits $(HOME)/.lolcommits

python: # install pip packages for eg itermß
	pip3 install itomate

smb-fix: ## Fix Slow smb speeds on OSX (see https://dpron.com/os-x-10-11-5-slow-smb/)
	printf "[default]\nsigning_required=no\n" | sudo tee /etc/nsmb.conf

code: ## install vscode plugins
	while read line; do code --install-extension $line; done < $(DOTPATH)/etc/Library/Application\ Support/Code/Vscodefile
	$(MAKE) code-backup

code-backup: ## save current vscode plugin list
	code --list-extensions > $(DOTPATH)/etc/Library/Application\ Support/Code/Vscodefile

wallpaper: ## get every day the bing wallpaper as a service
	curl -fsSo /usr/local/bin/bing-wallpaper https://raw.githubusercontent.com/thejandroman/bing-wallpaper/master/bing-wallpaper.sh
	chmod +x /usr/local/bin/bing-wallpaper
	/bin/launchctl load $(HOME)/Library/LaunchAgents/de.blmx.bingwallpaper.plist
	/usr/local/bin/bing-wallpaper --set-wallpaper

texteditor: 
	duti -s com.microsoft.VSCode public.plain-text all
	duti -s com.microsoft.VSCode public.data all
	duti -s com.microsoft.VSCode public.unix-executable all