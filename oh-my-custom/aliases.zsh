alias edithosts='sudo vim /etc/hosts'

alias latexmk-watch='latexmk -pdf -pvc'

alias tailapache="multitail /var/log/apache2/access_log /var/log/apache2/error_log"
alias tailvhosts="multitail /var/log/apache2/vhosts*"
alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"'
