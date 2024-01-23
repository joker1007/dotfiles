#!/bin/sh

SWAYLOCK="swaylock -eFfk -c 000000"

# swaylock-effects
# SWAYLOCK="swaylock -eFfk --screenshots --clock --indicator --effect-scale 0.5 --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 0.5"

exec swayidle -w \
  lock "${SWAYLOCK}" \
  timeout 3600 "${SWAYLOCK}" \
  timeout 4000 'hyprctl dispatch dpms off' \
  resume 'hyprctl dispatch dpms on' \
  before-sleep "${SWAYLOCK}" \
