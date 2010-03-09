#!/bin/sh

PWD=`pwd`

echo "Gen Simbolic Link .vim => ~/.vim"
ln -s ${PWD}/.vim ~/
echo "Gen Simbolic Link .vimrc => ~/.vimrc"
ln -s ${PWD}/.vimrc ~/
echo "Gen Simbolic Link .gvimrc => ~/.vimrc"
ln -s ${PWD}/.gvimrc ~/
echo "Gen Simbolic Link .vimperatorrc => ~/.vimperatorrc"
ln -s ${PWD}/.vimperatorrc ~/
echo "Gen Simbolic Link .vimperator => ~/.vimperator"
ln -s ${PWD}/.vimperator ~/
echo "Gen Simbolic Link .screenrc => ~/.screenrc"
ln -s ${PWD}/.screenrc ~/
