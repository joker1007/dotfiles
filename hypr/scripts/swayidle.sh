#!/bin/sh

exec swayidle -w \
  lock 'swaylock -eFfk -c 000000' \
  timeout 3600 'swaylock -eFfk -c 000000' \
  timeout 4000 'hyprctl dispatch dpms off' \
  resume 'hyprctl dispatch dpms on' \
  before-sleep 'swaylock -eFfk -c 000000' \

# exec swayidle -w \
#   timeout 3600 'swaylock -eFfk -c 000000' \
#   before-sleep 'swaylock -eFfk -c 000000'
