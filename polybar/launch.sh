#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
polybar main 2>&1 | tee -a /tmp/polybar-main.log & disown
polybar sub 2>&1 | tee -a /tmp/polybar-sub.log & disown

echo "Bars launched..."
