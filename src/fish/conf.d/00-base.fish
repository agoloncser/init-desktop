fish_vi_key_bindings

fish_add_path /Applications/Emacs.app/Contents/MacOS/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/sbin

set EDITOR vi
set PAGER less
umask 0077
ulimit -n 4096
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
