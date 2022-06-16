#####################################################################
#
#  Sample .zshenv file
#
#  initial setup file for both interactive and noninteractive zsh
#
#####################################################################

limit coredumpsize 0
# Setup command search path
typeset -U path PATH
# (N-/) を付けることで存在しなければ無視してくれる
path=(
  $HOME/.rbenv/bin(N-/)
  $HOME/.rbenv/shims(N-/)
  # $HOME/.pyenv/bin(N-/)
  # $HOME/.pyenv/shims(N-/)
  $HOME/.nodebrew/current/bin(N-/)
  $HOME/.cargo/bin(N-/)
  # $HOME/.nodenv/bin(N-/)
  # $HOME/.nodenv/shims(N-/)
  $HOME/.sdkman/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.embulk/bin(N-/)
  $HOME/bin
  $HOME/gocode/bin
  $HOME/Library/Haskell/bin(N-/)
  $HOME/.cabal/bin(N-/)
  /Applications/MacVim.app/Contents/MacOS(N-/)
  /usr/local/share/git-core/contrib/diff-highlight(N-/)
  /usr/local/sbin(N-/)
  /usr/local/bin(N-/)
  /usr/local/*/bin(N-/)
  /usr/local/share/npm/bin(N-/)
  /sbin
  /usr/sbin
  $path
  /opt/*/bin(N-/)
  /opt/*/sbin(N-/)
  /usr/*/bin(N-/)
  /var/*/bin(N-/)
)

# リモートから起動するコマンド用の環境変数を設定(必要なら)
export RSYNC_RSH=ssh
export CVS_RSH=ssh

# 言語設定
if [ -f /etc/profile.d/lang.sh ]; then
  source /etc/profile.d/lang.sh
fi

# MANPATH
typeset -U manpath
manpath=(
  # MacPorts用
  /opt/local/share/man(N-/)
  # Solaris用
  /opt/csw/share/man(N-/)
  /usr/sfw/share/man(N-/)
  # システム用
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

# rbenv
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
  source ~/.rbenv/completions/rbenv.zsh
fi

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# if type pyenv > /dev/null 2>&1; then
  # eval "$(pyenv init -)"
  # source ~/.pyenv/completions/pyenv.zsh
# fi

# # nodenv
# if type nodenv > /dev/null 2>&1; then
  # eval "$(nodenv init -)"
  # source ~/.nodenv/completions/nodenv.zsh
# fi

# golang
export GOPATH=~/gocode

export GITHUB_API_ENDPOINT="https://api.github.com"

[ -s ~/dotfiles/nnn.env.sh ] && source ~/dotfiles/nnn.env.sh

[ -s ~/.zshenv.local ] && source ~/.zshenv.local
