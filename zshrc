#####################################################################
#
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

###
# Set Shell variable

autoload colors
colors

# CTRL-wでパスの削除ができるように
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' 

# history
HISTSIZE=10000 HISTFILE=~/.zhistory SAVEHIST=10000
#PROMPT='%m{%n}%% '
#RPROMPT='[%~]'

# 補完定義のパスを追加
fpath=(~/.zsh/completion $fpath)

# binding keys
bindkey -e
bindkey '^p'	history-beginning-search-backward
bindkey '^n'	history-beginning-search-forward

# CTRL+zでbgのvimに復帰する
#bindkey -s '^z' '^[q %vim^m'

# ESC+Gでtar xvzf と入力
bindkey -s '^[G' 'tar xvzf '

# ESC+:で"**/*(.)"を入力
bindkey -s '^[:' '**/*(.)'


# LS_COLORS (from CentOS)
unset LS_COLORS
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

setopt prompt_subst
nprom () {
    local rbase=$'%{\e[33m%}[%~]%{\e[m%}' lf=$'\n'
    local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
    local tm=$'[%T]'
    RPROMPT="%9(~||$rbase)"
    local pbase=$'%{\e[36m%}%U%B%n@%m%b%u'" $pct "
    PROMPT="%9(~|$rbase$lf|)$pbase"
    [[ "$TERM" = "screen" ]] && RPROMPT="[%U%~%u]"
}
nprom


# Set shell options
# 日本語の文字化けを防ぐ
setopt print_eight_bit

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
setopt auto_remove_slash

# ディレクトリの絶対パスがセットされた変数は、そのディレクトリの名前として扱う。
setopt auto_name_dirs

# history
setopt extended_history hist_ignore_dups hist_ignore_space share_history inc_append_history

# =command を command のパス名に展開する
setopt equals

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
# setopt extended_glob

# ls -Fと同様に補完候補にタイプ表示
setopt list_types

# 補完候補を詰める
setopt list_packed

# --prefix=/usrなどの=以降を保管
setopt magic_equal_subst

# beep音無効
setopt no_beep

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

# 補完候補表示後、元のプロンプトに戻る
setopt always_last_prompt

setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups

# C-s, C-qを無効にする
setopt no_flow_control

# cd時に自動でpushd
setopt auto_pushd

# TABで補完候補を切り替える
setopt auto_menu

# Alias and functions
alias fullreset='echo "\ec\ec"'
h () 		{history $* | less}
alias ls='ls -F' la='ls -a' ll='ls -la'
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd pd=popd dirs='dirs -v'
alias vi='vim'

# enable color support of ls and also add handy aliases
case "${OSTYPE}" in
darwin*)
  alias ls='gls -F --color=auto'
  alias mv='gmv'
  alias rm='grm'
  alias cp='gcp'
  alias eche='gecho'
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias gvim='/Applications/MacVim.app/Contents/MacOS/mvim'
  alias gvimdiff='/Applications/MacVim.app/Contents/MacOS/mvimdiff'
  alias firefox-open='open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin'
  ;;
linux*)
  alias ls='ls -F --color=auto'
  ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ra='rails'
alias ralis='rails'
alias s='screen -xR'
alias g='git'
alias st='git status -sb'
alias ad='git add'
alias d='git diff'
alias dc='git diff --cached'
alias ft='git fetch --prune'
alias l='git lgraph'
alias rb='git rebase'
alias rbi='git rebase -i'
alias psh='git psh'
alias gst='git status -sb'
alias co='git checkout'
alias ci='git commit'
alias be='bundle exec'
alias bz='bundle exec zeus'
alias sp='spring'

# Global aliases
alias -g L="| lv"
alias -g LE="| less"
alias -g G="| grep"
alias -g C="| cut"
alias -g S="| sort"
alias -g RP="RAILS_ENV=production"
alias -g RT="RAILS_ENV=test"


# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 補完有効化
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

# 補完キャッシュ
zstyle ':completion:*' use-cache true

# 補完メニューをカーソル等で選択できるようにする
zstyle ':completion:*' menu select=2

# 補完の大文字・小文字を区別しない。が、大文字を入力したときは区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo時も$PATH内のコマンドを補完する
zstyle ':completion:*:sudo:*' command-path ${(s.:.)PATH}

# process補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# % zmv '(*).jpeg' '$1.jpg'
# % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# % zmv '(*)' '${(L)1}; # 大文字→小文字
# % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
autoload zmv
autoload zargs

# コマンドラインを$EDITORで編集
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# cdしたら自動的にlsを行う
autoload -Uz add-zsh-hook
_autols () { ls }
add-zsh-hook chpwd _autols

# 最後に打ったコマンドをscreenのウィンドウタイトルに
if [ "$SCREEN" = "true" ]; then
    _screen_chpwd () { echo -n "_`dirs`\\" }
    add-zsh-hook chpwd _screen_chpwd
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2 )); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    _screen_chpwd
fi

# vcs_infoとrvmで利用しているrubyを表示する
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-" 
  zstyle ':vcs_info:git:*' formats '(%s)-[%b]%c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a]%c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"


    # for rvm
    [ -s $HOME/.rvm/scripts/rvm ] && psvar[2]=`rvm-prompt i v p g s`

    # for rbenv
    [ -s $HOME/.rbenv/shims/ruby ] && psvar[2]=`rbenv version-name`
}
add-zsh-hook precmd _update_vcs_info_msg

VCS_PROMPT="%1(v|%F{green} %1v%f|)"
RUBY_PROMPT="%2(v| %U%B%F{magenta}(%2v)%f%b%u|)"

RPROMPT="$RUBY_PROMPT$VCS_PROMPT $RPROMPT"

# Puttyタイトルバー用設定
function _update_titlebar() {
  case "${TERM}" in
    kterm*|xterm*)
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    ;;
    xterm-256color|screen*)
      echo -ne "\033P\033]0;${USER}@${HOST%%.*}:${PWD}\007\033\\"
    ;;
  esac
}

add-zsh-hook precmd _update_titlebar

# auto-fu.zsh
unsetopt sh_word_split
source ~/.zsh/auto-fu.zsh/auto-fu.zsh
zle-line-init () {auto-fu-init;}; zle -N zle-line-init

zstyle ':completion:*' completer _oldlist _complete _match _ignored _history
zstyle ':auto-fu:var' autoable-function/skipwords "('|$'|\")*" "^((??)##)"
zstyle ':auto-fu:highlight' completion bold,underline

# hub
if type hub > /dev/null 2>&1; then
  function git() {
    hub "$@"
  }
fi

# git rebase -i
function grbi() {
  if [ "$1" -gt 0 ]; then
    git rebase -i "HEAD~${1}"
  else
    echo "Using: grbi n\n  (n is number greater then 0)"
  fi
}

# ctags for Ruby
alias rtags="ctags -R --langmap=RUBY:.rb --sort=yes -f ~/rtags ~/.rbenv/versions/`cat ~/.rbenv/version`"

# rvmの読み込み
[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm

[ -s ~/.zshrc.local ] && source ~/.zshrc.local

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/joker/.gvm/bin/gvm-init.sh" ]] && source "/home/joker/.gvm/bin/gvm-init.sh"
