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

# chmod files&directories
function chmod_fd {
	find . -type f -exec chmod $1 {} \;
	find . -type d -exec chmod $2 {} \;
}

# ssh to server and start screen
function sshs {
	ssh $@ -t screen
}

# tail vhost logfiles
function tailwww() {
    if [ ! -z $1 ] ; then
        echo "\ntail -f & grep apache logs for $1...\n"
        tail -f /var/log/apache2/vhosts-${2-'error'}_log | grep -i $1
    else
         tail -f /var/log/apache2/vhosts-error_log
    fi
}

# Create a data URL from an image (works for other file types too, if you tweak the Content-Type afterwards)
function dataurl() {
    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
    local port="${1:-4000}"
    local ip=$(ipconfig getifaddr en1)
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}"
}

# shown only uncommented lines
function uncommented_lines() {
    grep -v '^$' "$1" | grep -vE '^ *(#|;)'
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript
    else # pipe
        python -mjson.tool | pygmentize -l javascript
    fi
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}
