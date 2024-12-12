function __fish_complete_keys_from_ssh_dir
    ls -1 $HOME/.ssh | grep -vE '^config$|^conf\.d$|\.pub$|^known_hosts|\.bak$|\.req$'
end
complete -c keys -f -a "(__fish_complete_keys_from_ssh_dir)"
complete -c keys_week -f -a "(__fish_complete_keys_from_ssh_dir)"
