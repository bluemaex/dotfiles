#!/bin/sh

#must have
brew install zsh
brew install git
brew install mercurial

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
brew install dnsmsasq
ln -s /usr/local/etc/dnsmasq.conf $HOME/dotfiles/etc/dnsmasq/dnsmasq.conf
sudo cp $HOME/dotfiles/etc/dnsmasq/uk.org.thekelleys.dnsmasq /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq

# fuse
brew install fuse4x
brew install sshfs

# nodejs
brew install nodejs
curl http://npmjs.org/install.sh | sh

# databases
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
brew install couchdb

# pandoc
brew install haskell-platform
cabal update
cabal install pandoc

# goodies
brew install fortune 
brew install cowsay

brew install uptimed

brew install vnstat
vnstat -u -i en0
vnstat -u -i en1

# link apps
brew linksapps
