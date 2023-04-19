#!/bin/sh

PWD=$(pwd)

set -x

ln -sf ${PWD}/gitconfig ~/.gitconfig
ln -sf ${PWD}/nvim ~/.config/nvim
ln -sf ${PWD}/tmux.conf ~/.tmux.conf
ln -sf ${PWD}/sheldon ~/.config/sheldon
ln -sf ${PWD}/zshrc ~/.zshrc
ln -sf ${PWD}/zsh ~/.zsh
ln -sf ${PWD}/zshenv ~/.zshenv
ln -sf ${PWD}/irbrc ~/.irbrc
ln -sf ${PWD}/gitconfig ~/.gitconfig
ln -sf ${PWD}/tigrc ~/.tigrc
mkdir -p ~/.config/peco
ln -sf ${PWD}/peco_config.json ~/.config/peco/config.json
mkdir -p ~/.tmux/plugins
ln -sf ${PWD}/tpm ~/.tmux/plugins/tpm
ln -sf ${PWD}/i3 ~/.config/i3
ln -sf ${PWD}/i3_sway ~/.config/i3_sway
ln -sf ${PWD}/zellij ~/.config/zellij
