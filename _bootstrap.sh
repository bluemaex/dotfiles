# determine location of the dotfile directory
_DOTFILE_DIR="$( cd -P "$( dirname "$0" )" && pwd )"

# get file list
_DOTFILES=`ls | grep -v -F -f $_DOTFILE_DIR/_bootstrap.exclude`

# and finally loop over the file list
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


