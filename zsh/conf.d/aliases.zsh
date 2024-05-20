alias fullreset='echo "\ec\ec"'
alias h='history'
alias ls=lsd
alias ll='ls -la'
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd pd=popd dirs='dirs -v'
alias vi='nvim'
alias vim='nvim'
alias nq='nvim-qt'

# enable color support of ls and also add handy aliases
case "${OSTYPE}" in
darwin*)
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
  ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ra='rails'
alias ralis='rails'
alias tx='tmux -q has-session && tmux attach-session -d || tmux new-session'
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
alias lz='lazygit'
alias b='bundle'
alias bu='bundle update'
alias be='bundle exec'
alias bz='bundle exec zeus'
alias bl="bundle list"
alias bo="bundle open"
alias sp='spring'
alias sprk='spring rake'
alias sprs='spring rspec'
alias dbuild='docker build -t $(basename $(pwd)) .'
alias yd="youtube-dl"
alias n="neovide"
alias o="xdg-open"

# Global aliases
alias -g L="| lv"
alias -g LE="| less"
alias -g BA="| bat"
alias -g G="| grep"
alias -g A="| ag"
alias -g C="| cut"
alias -g S="| sort"
alias -g RD="RAILS_ENV=development"
alias -g RP="RAILS_ENV=production"
alias -g RT="RAILS_ENV=test"
alias -g ST="amanogawa -f '%f%t%d' | column -t -s '	' | peco | awk '{print \$1}'"

alias all-ruby="docker run --rm -t rubylang/all-ruby /all-ruby/all-ruby"

# ctags for Ruby
if type rbenv > /dev/null 2>&1; then
  alias rtags="ctags -R --langmap=RUBY:.rb --sort=yes -f ~/rtags ~/.rbenv/versions/`cat ~/.rbenv/version`"
fi
