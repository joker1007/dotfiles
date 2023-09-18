#!/bin/sh

swayidle -w \
  timeout 3600 'swaylock -eFfk -c 000000' \
  timeout 7200 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
  before-sleep 'swaylock -eFfk -c 000000'