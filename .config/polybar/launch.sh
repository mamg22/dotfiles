#!/bin/sh

polybar-msg cmd quit

while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

polybar -r main &
