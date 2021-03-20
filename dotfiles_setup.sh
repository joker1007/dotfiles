#!/bin/sh

PWD=`pwd`

set -x

ln -sf ${PWD}/gitconfig ~/.gitconfig
ln -sf ${PWD}/vim ~/.vim
ln -sf ${PWD}/vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf ${PWD}/vimrc ~/.config/nvim/init.vim
ln -sf ${PWD}/gvimrc ~/.gvimrc
ln -sf ${PWD}/gvimrc ~/.config/nvim/ginit.vim
ln -sf ${PWD}/vimperatorrc ~/.vimperatorrc
ln -sf ${PWD}/vimperator ~/.vimperator
ln -sf ${PWD}/screenrc ~/.screenrc
ln -sf ${PWD}/tmux.conf ~/.tmux.conf
ln -sf ${PWD}/zshrc ~/.zshrc
ln -sf ${PWD}/zshrc.github ~/.zshrc.github
ln -sf ${PWD}/zshrc.peco ~/.zshrc.peco
ln -sf ${PWD}/zsh ~/.zsh
ln -sf ${PWD}/zshenv ~/.zshenv
ln -sf ${PWD}/zlogin ~/.zlogin
ln -sf ${PWD}/oh-my-zsh ~/.oh-my-zsh
ln -sf ${PWD}/zaw ~/.zaw
ln -sf ${PWD}/irbrc ~/.irbrc
ln -sf ${PWD}/gitconfig ~/.gitconfig
ln -sf ${PWD}/tigrc ~/.tigrc
mkdir -p ~/.config/peco
ln -sf ${PWD}/peco_config.json ~/.config/peco/config.json
mkdir -p ~/.tmux/plugins
ln -sf ${PWD}/tpm ~/.tmux/plugins/tpm
ln -sf ${PWD}/i3 ~/.config/i3
ln -sf ${PWD}/i3_sway ~/.config/i3_sway
