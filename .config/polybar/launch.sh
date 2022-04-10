#!/bin/sh

set -x

barname="${1}"
# Optionally kill old known bar instance
oldbar_pid="${2}"

if [ -z "$barname" ]; then
    echo "No bar name provided" >&2
    exit 1
fi

#real_pipe_prefix="/tmp/polybar_mqueue"
#fake_pipe_prefix="/tmp/polybar-bar"
#
#barpid_pipe="$(realpath "${fake_pipe_prefix}.${barname}")"
#barpid="${barpid_pipe#*.}"
#real_barpid_pipe="${real_pipe_prefix}.${barpid}"
#
#if [ -e "$barpid_pipe" ]; then
#    polybar-msg -p "$barpid" cmd quit >/dev/null 2>&1 &
#    [ -e "$real_barpid_pipe" ] && inotifywait -e delete "$real_barpid_pipe"
#fi

if [ -n "${oldbar_pid}" ]; then
    polybar-msg -p "${oldbar_pid}" cmd quit >/dev/null 2>&1 &
fi

polybar -r "$barname" >/dev/null &

polybar_pid="$!"

echo "${polybar_pid}"

exit 0

#ln -fs "${real_pipe_prefix}.${polybar_pid}" "${fake_pipe_prefix}.${barname}"
