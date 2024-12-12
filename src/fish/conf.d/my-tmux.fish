if status is-interactive
    if test -z "$TMUX" && test -z "$VIM" && test -z "$INSIDE_EMACS" && test "$TERM_PROGRAM" != vscode && test "$TERM_PROGRAM" != zed
        tmux new-session
    end
end
