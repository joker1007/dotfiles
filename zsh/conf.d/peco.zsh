# pecoとghqでローカルのリポジトリクローンに飛ぶ
function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^s' peco-src

function peco-git-checkout () {
  local branch=$(git branch -a | peco | tr -d ' ' | sed -e 's/\*//')
  if [ -n "$branch" ]; then
    if [[ "$branch" =~ "remotes/" ]]; then
      local b=$(echo $branch | awk -F'/' '{print $3}')
      BUFFER="git checkout -b ${b} ${branch}"
      zle accept-line
    else
      BUFFER="git checkout ${branch}"
      zle accept-line
    fi
  fi
}
zle -N peco-git-checkout
bindkey '\eb' peco-git-checkout

function peco-git-log() {
  local res
  res=$(git log --all --graph --oneline --decorate=full -n 300 | peco | awk '{print $2}')
  if [ -n "$res" ]; then
    BUFFER="${BUFFER}${res}"
    zle end-of-line
  fi
}
zle -N peco-git-log
bindkey '\el' peco-git-log

function cdgem() {
  query=$1
  local gem_name=$(bundle list | sed -e 's/^ *\* *//g' | peco --query=$query | cut -d \  -f 1)
  if [ -n "$gem_name" ]; then
    local gem_dir=$(bundle show ${gem_name})
    echo "cd to ${gem_dir}"
    cd ${gem_dir}
  fi
}

function swgemfile() {
  local gemfile=$(find . \( -name "Gemfile*" -or -name "*.gemfile" \) -not -name "*.lock" -maxdepth 2 | peco)
  if [ -n "$gemfile" ]; then
    local gemfile_fullpath=$(echo ${gemfile} | ruby -r pathname -ne 'puts Pathname(Dir.pwd).join($_)')
    touch .envrc
    sed -i -e '/BUNDLE_GEMFILE/d' .envrc
    echo "export BUNDLE_GEMFILE=${gemfile_fullpath}" >> .envrc
    direnv allow .
    direnv reload
  else
    sed -i -e '/BUNDLE_GEMFILE/d' .envrc
    direnv allow .
    direnv reload
  fi
}
alias swg=swgemfile

function peco-rake() {
  local taskname="$(rake -W | cut -f 1,2 -d\  | uniq | peco | cut -f 2 -d\  )"

  if [ -n "$taskname" ]; then
      echo "Execute \"rake $taskname\""
      rake $taskname
  fi
}
alias rp=peco-rake

function peco-history() {
  local res tailr
  tailr="tail -r"
  if which "tac" > /dev/null 2>&1; then
    tailr="tac"
  fi
  res=$(fc -l -n 1 | eval $tailr | peco --prompt "HISTORY>")
  if [ -n "$res" ]; then
    BUFFER=$res
    zle end-of-line
  fi
}
zle -N peco-history
bindkey '^r' peco-history

function peco-file() {
  local res
  res=$(find . -name "*${1}*" | grep -v "/\." | peco)
  if [ -n "$res" ]; then
    BUFFER="${BUFFER}${res}"
    zle end-of-line
  fi
}
zle -N peco-file
bindkey '\ef' peco-file

function peco-ps() {
  local res
  res=$(ps aux | peco | awk '{print $2}')
  if [ -n "$res" ]; then
    BUFFER="${BUFFER}${res}"
    zle end-of-line
  fi
}
zle -N peco-ps
bindkey '\ep' peco-ps

function peco-ssh() {
  local res
  res=$(grep "Host " ~/.ssh/config | cut -b 6- | peco)
  if [ -n "$res" ]; then
    BUFFER="ssh ${res}"
    zle end-of-line
  fi
}
zle -N peco-ssh
bindkey '\es' peco-ssh

function peco-ssh-xpanes() {
  local res
  res=$(grep "Host " ~/.ssh/config | cut -b 6- | peco | tr '\n' ' ')
  if [ -n "$res" ]; then
    BUFFER="xpanes --log=~/log --ssh ${res}"
    zle end-of-line
  fi
}
zle -N peco-ssh-xpanes
bindkey '\ex' peco-ssh-xpanes
