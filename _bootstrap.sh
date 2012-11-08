echo "#### creating symlinks"
_DOTFILE_DIR="$( cd -P "$( dirname "$0" )" && pwd )"
_DOTFILES=`ls | grep -v -F -f $_DOTFILE_DIR/_bootstrap.exclude`

for _DOTFILE in $_DOTFILES
do
  if [ -f ${HOME}/.${_DOTFILE} ]
  then
    echo "moving existing file ${HOME}/.${_DOTFILE} to ${HOME}/.${_DOTFILE}.old"
    mv ${HOME}/.${_DOTFILE} ${HOME}/.${_DOTFILE}.old
  fi

  ln -s ${_DOTFILE_DIR}/${_DOTFILE} ${HOME}/.${_DOTFILE}
  echo "creating symlink for ${_DOTFILE}"
done

echo "#### installing homebrew & packages"
sh ${_DOTFILE_DIR}/etc/homebrew/packages.sh

echo "#### initialising submodules"
git submodule init
git submodule update

echo "#### running .osx settings stuff"
sh ${_DOTFILE_DIR}/_osx.sh

echo "#### installing janus"
cd $HOME/.vim
rake

echo "#### creating host specific zsh startup files"
cp ${_DOTFILE_DIR}/oh-my-custom/hosts/example.path.zsh-template ${_DOTFILE_DIR}/oh-my-custom/hosts/${HOST}.path.zsh
cp ${_DOTFILE_DIR}/oh-my-custom/hosts/example.zsh-template ${_DOTFILE_DIR}/oh-my-custom/hosts/${HOST}.zsh
