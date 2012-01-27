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
