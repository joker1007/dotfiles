#!/bin/sh

PWD=`pwd`

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
