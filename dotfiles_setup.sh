#!/bin/sh

PWD=`pwd`

echo "Gen Simbolic Link .gitconfig => ~/.gitconfig"
ln -sf ${PWD}/gitconfig ~/.gitconfig
echo "Gen Simbolic Link .vim => ~/.vim"
ln -sf ${PWD}/vim ~/.vim
echo "Gen Simbolic Link .vimrc => ~/.vimrc"
ln -sf ${PWD}/vimrc ~/.vimrc
echo "Gen Simbolic Link .vimrc => ~/.config/nvim/init.vim"
mkdir -p ~/.config/nvim
ln -sf ${PWD}/vimrc ~/.config/nvim/init.vim
echo "Gen Simbolic Link .gvimrc => ~/.vimrc"
ln -sf ${PWD}/gvimrc ~/.gvimrc
echo "Gen Simbolic Link .vimperatorrc => ~/.vimperatorrc"
ln -sf ${PWD}/vimperatorrc ~/.vimperatorrc
echo "Gen Simbolic Link .vimperator => ~/.vimperator"
ln -sf ${PWD}/vimperator ~/.vimperator
echo "Gen Simbolic Link .screenrc => ~/.screenrc"
ln -sf ${PWD}/screenrc ~/.screenrc
echo "Gen Simbolic Link tmux.conf => ~/.tmux.conf"
ln -sf ${PWD}/tmux.conf ~/.tmux.conf
echo "Gen Simbolic Link .zshrc => ~/.zshrc"
ln -sf ${PWD}/zshrc ~/.zshrc
echo "Gen Simbolic Link .zshrc.github => ~/.zshrc.github"
ln -sf ${PWD}/zshrc.github ~/.zshrc.github
echo "Gen Simbolic Link .zshrc.peco => ~/.zshrc.peco"
ln -sf ${PWD}/zshrc.peco ~/.zshrc.peco
echo "Gen Simbolic Link .zsh => ~/.zsh"
ln -sf ${PWD}/zsh ~/.zsh
echo "Gen Simbolic Link .zshenv => ~/.zshenv"
ln -sf ${PWD}/zshenv ~/.zshenv
echo "Gen Simbolic Link .zlogin => ~/.zlogin"
ln -sf ${PWD}/zlogin ~/.zlogin
echo "Gen Simbolic Link oh-my-zsh => ~/.oh-my-zsh"
ln -sf ${PWD}/oh-my-zsh ~/.oh-my-zsh
echo "Gen Simbolic Link zaw => ~/.zaw"
ln -sf ${PWD}/zaw ~/.zaw
echo "Gen Simbolic Link .irbrc => ~/.irbrc"
ln -sf ${PWD}/irbrc ~/.irbrc
echo "Gen Simbolic Link .gitconfig => ~/.gitconfig"
ln -sf ${PWD}/gitconfig ~/.gitconfig
echo "Gen Simbolic Link .tigrc => ~/.tigrc"
ln -sf ${PWD}/tigrc ~/.tigrc
echo "Gen Simbolic Link peco_config.json => ~/.config/peco/config.json"
mkdir -p ~/.config/peco
ln -sf ${PWD}/peco_config.json ~/.config/peco/config.json
mkdir -p ~/.tmux/plugins
ln -sf ${PWD}/tpm ~/.tmux/plugins/tpm
