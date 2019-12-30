#!/bin/sh

[ -f ~/.profile ] && . ~/.profile
[ -f ~/.xprofile ] && . ~/.xprofile

if [ -n "$XSESSION_WM" ]; then
    exec $XSESSION_WM
    exit 0
fi

exec bspwm
