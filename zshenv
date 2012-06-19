#####################################################################
#
#  Sample .zshenv file
#
#  initial setup file for both interactive and noninteractive zsh
#
#####################################################################

limit coredumpsize 0
# Setup command search path
typeset -U path
# (N-/) を付けることで存在しなければ無視してくれる
path=($HOME/bin $HOME/Library/Haskell/bin(N-/) /opt/local/bin(N-/) /opt/local/sbin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) /usr/local/*/bin(N-/) $path /sbin /usr/sbin /usr/*/bin(N-/) /var/*/bin(N-/))

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

if type lv > /dev/null 2>&1; then
  ## lvを優先する。
  export PAGER="lv"
else
  ## lvがなかったらlessを使う。
  export PAGER="less"
fi

if [ "$PAGER" = "lv" ]; then
    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
    ## -l: 1行が長くと折り返されていても1行として扱う。
    ##     （コピーしたときに余計な改行を入れない。）
    export LV="-c -l"
else
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi

# rbenv
if type rbenv > /dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  source ~/.rbenv/completions/rbenv.zsh
fi

[ -s ~/.zshenv.local ] && source ~/.zshenv.local
