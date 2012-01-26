# as root don't pront anything
#
if [[ ${EUID} == 0 ]] ; then
    return
fi

test -x "$(type -p setterm)" && {
    setterm -blank 0 -blength 0;
}

BLUE=$'\033[1;34m'

if [[ "$TERM" != "screen" ]]; then
    ## ...
    echo 
    
    ## system information
    echo -e "$BLUE*\033[m \033[1;1muname\033[m"; uname -snrm; echo

    ## uptime (records)
    if [ -f /usr/local/bin/uprecords ]; then
        echo -e "$BLUE*\033[m \033[1;1muptime records\033[m"; uprecords -m 3 -s; echo
    else
        echo -e "$BLUE*\033[m \033[1;1muptime\033[m"; uptime | sed "s/^ //"; echo
    fi
fi

## fortune on every login
echo -e "$BLUE*\033[m \033[1;1mfortune\033[m"; fortune -s | cowsay ; echo

