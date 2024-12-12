# The dumb filename is required to load this function last

function _my_fish_greeting
    echo $TMUX_PANE $TMUX (date +"%FT%T")
    if type -q fortune
        echo
        fortune
        echo
    end
    type -q gpg && gpg -K | grep '^sec'
    ssh-add -l
    if [ -x "$HOME/.local/bin/ca-ssh-warn-local-certificates.sh" ]
        $HOME/.local/bin/ca-ssh-warn-local-certificates.sh
    end
end
function fish_greeting
    if type lolcat 1>/dev/null 2>/dev/null
        _my_fish_greeting | lolcat
    else
        _my_fish_greeting
    end
end
