bindkey -e

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=20000

# User configuration

export PATH=$HOME/bin:$PATH

bindkey '^p'	history-beginning-search-backward
bindkey '^n'	history-beginning-search-forward

# Pager
export LESS="-MRXF --mouse"
export PAGER="less"

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

function json_post() {
  url=$1
  method=$2
  json=$3
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X ${method} -d ${json} ${url}
}

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

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/joker/.gvm/bin/gvm-init.sh" ]] && source "/home/joker/.gvm/bin/gvm-init.sh"

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if type zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  export _ZO_ECHO=1
fi

if type starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
elif type cargo > /dev/null 2>&1; then
  echo "install starship"
  cargo install starship
fi

if type aws_completer > /dev/null 2>&1; then
  complete -C $(which aws_completer) aws
fi

# OPAM configuration
[[ -s /home/joker/.opam/opam-init/init.zsh ]] && source /home/joker/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joker/.sdkman"
[[ -s "/home/joker/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joker/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joker/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joker/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joker/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/joker/google-cloud-sdk/completion.zsh.inc'; fi
