export ZSH_CACHE_DIR="$HOME/.cache/zsh"

if type vivid > /dev/null 2>&1; then
  export LS_COLORS="$(vivid generate tokyonight-night)"
fi

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=20000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

function zsh_history {
  if [[ $# -eq 0 ]]; then
    # if no arguments provided, show full history starting from 1
    builtin fc -l 1
  else
    # otherwise, run `fc -l` with a custom format
    builtin fc -l -"$@"
  fi
}

alias history='zsh_history'

# Pager
export LESS="-MRXF --mouse"
export PAGER="less"

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
_autols () { lsd --color=always --icon=always | head -n 10 }
add-zsh-hook chpwd _autols

zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(rm|rmdir)($| )" ]]
}

# Other Options
# see. man zshoptions
setopt autocd
setopt autopushd
setopt pushdminus
setopt pushdignoredups

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

setopt longlistjobs
setopt interactivecomments

setopt alwaystoend
setopt completeinword
setopt noflowcontrol

function json_post() {
  url=$1
  method=$2
  json=$3
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X ${method} -d ${json} ${url}
}

# wine
# export WINEARCH=win32
# export WINEPREFIX="$HOME/.wineprefixes/base"
# function prefix() {
#   export WINEPREFIX="$HOME/.wineprefixes/$1"
# }

# bq
function bqj() {
  local job_id=$1
  shift
  bq --format=json show -j $job_id | jq $@
}

[ -s ~/.zshrc.local ] && source ~/.zshrc.local

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if type starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# if type aws_completer > /dev/null 2>&1; then
#   complete -C $(which aws_completer) aws
# fi
