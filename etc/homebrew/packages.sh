#!/bin/sh

# first install homebrew 
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# must have
brew install git
brew install mercurial

# zsh
brew install zsh

# vim
brew install macvim --override-system-vim

# useful tools
brew install wget
brew install multitail
brew install iftop
brew install htop
brew install tree
bre install tmux

# local dns for dev tld
brew install dnsmasq
sudo mkdir /etc/resolver
sudo cp $HOME/dotfiles/etc/resolver/* /etc/resolver
sudo cp $HOME/dotfiles/etc/dnsmasq/*.conf /usr/local/etc/
sudo cp $HOME/dotfiles/etc/dnsmasq/*.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/de.blmx.dnsmasq.dev.plist
sudo launchctl load -w /Library/LaunchDaemons/de.blmx.dnsmasq.local.plist

# fuse
brew install fuse4x
sudo /bin/cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.2/Library/Extensions/fuse4x.kext /Library/Extensions
sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x
brew install sshfs

# nodejs
brew install nodejs
curl http://npmjs.org/install.sh | sh

# databases
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

# pandoc
brew install haskell-platform
cabal update
cabal install pandoc

# goodies
brew install fortune 
brew install cowsay

# uptimed
brew install uptimed
sudo cp $HOME/dotfiles/etc/vnstat/de.blmx.uptimed.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/de.blmx.uptimed.plist

# vnstat
brew install vnstat
vnstat -u -i en0
vnstat -u -i en1
sudo cp $HOME/dotfiles/etc/vnstat/de.blmx.vnstatd.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/de.blmx.vnstatd.plist

# locate
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# link apps
mkdir ~/Applications
brew linkapps
