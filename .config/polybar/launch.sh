#!/bin/sh

barname="${1}"

if [ -z "$barname" ]; then
    echo "No bar name provided" >&2
    exit 1
fi

real_pipe_prefix="/tmp/polybar_mqueue"
fake_pipe_prefix="/tmp/polybar-bar"

barpid_pipe="$(realpath "${fake_pipe_prefix}.${barname}")"
barpid="${barpid_pipe#*.}"

if [ -e "$barpid_pipe" ]; then
    polybar-msg -p "$barpid" cmd quit &
    inotifywait -e delete "${real_pipe_prefix}.${barpid}"
fi

polybar -r "$barname" &

ln -fs "${real_pipe_prefix}.$!" "${fake_pipe_prefix}.${barname}"
