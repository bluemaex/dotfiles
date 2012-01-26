function extract() {
    unset REMOVE_ARCHIVE
    
    if test "$1" = "-r"; then
        REMOVE=1
        shift
    fi
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tar.xz) tar xvJf $1;;
      *.tar.lzma) tar --lzma -xvf $1;;
      *.bz2) bunzip $1;;
      *.rar) unrar x $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *) echo "'$1' cannot be extracted via >extract<";;
    esac

    if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
        echo removing "$1";
        /bin/rm "$1";
    fi

  else
    echo "'$1' is not a valid file"
  fi
}

psgrep() {
  if [ ! -z $1 ] ; then
    echo "Grepping for processes matching $1..."
    ps aux | grep -i $1 | grep -v grep
  else
    echo "!! Need name to grep for"
  fi
}

lsofgrep() {
  if [ ! -z $1 ] ; then
    echo "Grepping for open files matching $1..."
    lsof | grep -i $1 | grep -v grep
  else
    echo "!! Need name to grep for"
  fi
}

histgrep() {
  if [ ! -z $1 ] ; then
    echo "Grepping history for $1..."
    cat ~/.bash_history | grep -i $1 | grep -v grep
  else
    echo "!! Need name to grep for"
  fi
}

function chmod_fd {
	find . -type f -exec chmod $1 {} \;
	find . -type d -exec chmod $2 {} \;
}

function sshs {
	ssh $@ -t screen
}
