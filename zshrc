# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh/custom

HISTFILE=~/.zhistory

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nebirhos"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump battery cp history-substring-search rsync rbenv)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

## custom

bindkey '^p'	history-beginning-search-backward
bindkey '^n'	history-beginning-search-forward

# Alias and functions
alias fullreset='echo "\ec\ec"'
alias h='history'
alias ls='ls -F' la='ls -a' ll='ls -la'
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd pd=popd dirs='dirs -v'
alias vi='vim'
alias nq='nvim-qt'

# enable color support of ls and also add handy aliases
case "${OSTYPE}" in
darwin*)
  alias ls='gls -F --color=auto'
  alias mv='gmv'
  alias rm='grm'
  alias cp='gcp'
  # alias echo='gecho'
  alias tac='gtac'
  alias sed='gsed'
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias gvim='/Applications/MacVim.app/Contents/MacOS/mvim'
  alias gvimdiff='/Applications/MacVim.app/Contents/MacOS/mvimdiff'
  alias firefox-open='open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin'
  ;;
linux*)
  alias open='xdg-open'
  alias ls='ls -F --color=auto'
  ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ra='rails'
alias ralis='rails'
alias s='screen -xR'
alias t='tmux -q has-session && tmux attach-session -d || tmux new-session'
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
alias b='bundle'
alias bu='bundle update'
alias be='bundle exec'
alias bz='bundle exec zeus'
alias bl="bundle list"
alias bo="bundle open"
alias sp='spring'
alias sprk='spring rake'
alias sprs='spring rspec'

# Global aliases
alias -g L="| lv"
alias -g LE="| less"
alias -g G="| grep"
alias -g A="| ag"
alias -g C="| cut"
alias -g S="| sort"
alias -g RD="RAILS_ENV=development"
alias -g RP="RAILS_ENV=production"
alias -g RT="RAILS_ENV=test"
alias -g ST="amanogawa -f '%f%t%d' | column -t -s '	' | peco | awk '{print \$1}'"

# Pager

export LESS="-RXF"
export PAGER="less"

if [ "$PAGER" = "lv" ]; then
    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
    ## -l: 1行が長くと折り返されていても1行として扱う。
    ##     （コピーしたときに余計な改行を入れない。）
    export LV="-c -l"
else
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi


# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _complete _history _match _ignored _prefix

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

# zsh-syntax-highlighting
[ -s $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


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

[ -s ~/.zshrc.github ] && source ~/.zshrc.github

[ -s ~/.zshrc.github ] && source ~/.zshrc.peco

function json_post() {
  url=$1
  method=$2
  json=$3
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X ${method} -d ${json} ${url}
}

# ctags for Ruby
if type rbenv > /dev/null 2>&1; then
  alias rtags="ctags -R --langmap=RUBY:.rb --sort=yes -f ~/rtags ~/.rbenv/versions/`cat ~/.rbenv/version`"
fi

# wine
export WINEARCH=win32
export WINEPREFIX="$HOME/.wineprefixes/base"
function prefix() {
  export WINEPREFIX="$HOME/.wineprefixes/$1"
}

# bq
function bqj() {
  local job_id=$1
  shift
  bq --format=json show -j $job_id | jq $@
}

[ -s ~/.zshrc.local ] && source ~/.zshrc.local

if [ -s ~/.zaw/zaw.zsh ]; then
  source ~/.zaw/zaw.zsh
fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/joker/.gvm/bin/gvm-init.sh" ]] && source "/home/joker/.gvm/bin/gvm-init.sh"

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# rupa/z
if [ -s ~/.zsh/z/z.sh ]; then
  source ~/.zsh/z/z.sh
fi

# added by travis gem
[ -f /Users/joker/.travis/travis.sh ] && source /Users/joker/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
[[ -s /home/joker/google-cloud-sdk/path.zsh.inc ]] && source '/home/joker/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
[[ -s /home/joker/google-cloud-sdk/completion.zsh.inc ]] && source '/home/joker/google-cloud-sdk/completion.zsh.inc'

# OPAM configuration
[[ -s /home/joker/.opam/opam-init/init.zsh ]] && source /home/joker/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

alias all-ruby="docker run --rm -t rubylang/all-ruby /all-ruby/all-ruby"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
