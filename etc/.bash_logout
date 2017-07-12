# Clear sudo auth cache
test -x $(which sudo 2> /dev/null) && sudo -k

# Clear terminal screen
[ -x $(type -p clear) ] && clear -q
echo -e "\033[1;33m*\033[m \033[1mgoodbye $USER.\033[m"

# vim:ft=sh
