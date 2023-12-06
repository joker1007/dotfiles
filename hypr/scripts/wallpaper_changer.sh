#!/bin/bash
#
watch -n 3600 ' swww img -o DP-1 "/home/joker/wallpapers/$(/bin/ls -1 /home/joker/wallpapers | sort -R | tail -1)"' &
watch -n 3600 ' swww img -o DP-2 "/home/joker/wallpapers/$(/bin/ls -1 /home/joker/wallpapers | sort -R | tail -1)"' &
disown
