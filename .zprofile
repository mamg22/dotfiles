[ -f ~/.profile ] && . ~/.profile

# Only start X automatically if vt1 and not nested shell (tmux or similar)
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 && $SHLVL -eq 1 ]]; then
    ~/bin/start-graphical-session
fi

