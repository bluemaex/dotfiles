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
    cat ~/.zsh_history | grep -i $1 | grep -v grep
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

function tailwww() {
    if [ ! -z $1 ] ; then
        echo "\ntail -f & grep apache logs for $1...\n"
        tail -f /var/log/apache2/vhosts-${2-'error'}_log | grep -i $1
    else
         tail -f /var/log/apache2/vhosts-error_log
    fi
}
