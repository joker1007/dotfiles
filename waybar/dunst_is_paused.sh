#!/bin/bash

sleep 0.1
paused=$(dunstctl is-paused)
if [ "$paused" = "true" ]; then
    echo "󰂛 Off"
else
    echo "󰂞 On"
fi
