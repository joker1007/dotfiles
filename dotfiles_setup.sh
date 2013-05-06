#!/bin/sh

PWD=`pwd`

echo "Gen Simbolic Link .gitconfig => ~/.gitconfig"
ln -sf ${PWD}/gitconfig ~/.gitconfig
echo "Gen Simbolic Link .vim => ~/.vim"
ln -sf ${PWD}/vim ~/.vim
echo "Gen Simbolic Link .vimrc => ~/.vimrc"
ln -sf ${PWD}/vimrc ~/.vimrc
echo "Gen Simbolic Link .gvimrc => ~/.vimrc"
ln -sf ${PWD}/gvimrc ~/.gvimrc
echo "Gen Simbolic Link .vimperatorrc => ~/.vimperatorrc"
ln -sf ${PWD}/vimperatorrc ~/.vimperatorrc
echo "Gen Simbolic Link .vimperator => ~/.vimperator"
ln -sf ${PWD}/vimperator ~/.vimperator
echo "Gen Simbolic Link .screenrc => ~/.screenrc"
ln -sf ${PWD}/screenrc ~/.screenrc
echo "Gen Simbolic Link .zshrc => ~/.zshrc"
ln -sf ${PWD}/zshrc ~/.zshrc
echo "Gen Simbolic Link .zsh => ~/.zsh"
ln -sf ${PWD}/zsh ~/.zsh
echo "Gen Simbolic Link .zshenv => ~/.zshenv"
ln -sf ${PWD}/zshenv ~/.zshenv
echo "Gen Simbolic Link .zlogin => ~/.zlogin"
ln -sf ${PWD}/zlogin ~/.zlogin
echo "Gen Simbolic Link .irbrc => ~/.irbrc"
ln -sf ${PWD}/irbrc ~/.irbrc
echo "Gen Simbolic Link .tigrc => ~/.tigrc"
ln -sf ${PWD}/tigrc ~/.tigrc
