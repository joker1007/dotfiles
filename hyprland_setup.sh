#!/bin/sh
# Hyprland を uwsm + greetd(tuigreet) で起動するためのセットアップ

PWD=$(pwd)

set -x

mkdir -p ~/.config
ln -sfn ${PWD}/hypr ~/.config/hypr
ln -sfn ${PWD}/uwsm ~/.config/uwsm

# monitors.lua はマシン固有のため gitignore されている。無ければ空で作成
[ -e ${PWD}/hypr/monitors.lua ] || printf -- '-- マシン固有のモニター設定\n' > ${PWD}/hypr/monitors.lua

sudo install -Dm644 ${PWD}/greetd/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd.service
