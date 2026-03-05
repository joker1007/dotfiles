alias fullreset='echo "\ec\ec"'
abbr h='history'
alias ls='eza --group-directories-first --icons --smart-group --git'
alias ll='ls -lagB'
alias llh='ls -lah'
abbr lt='ls --tree'
abbr llt='ll --tree'
abbr tree='ls --tree'
abbr treel='ll --tree'
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}
abbr pu=pushd
abbr pd=popd
abbr nv='nvim'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

abbr ra='rails'
abbr ralis='rails'
abbr tx='tmux -q has-session && tmux attach-session -d || tmux new-session'
abbr g='git'
abbr st='git status -sb'
abbr ad='git add'
abbr d='git diff'
abbr dc='git diff --cached'
abbr ft='git fetch --prune'
abbr l='git lgraph'
abbr rb='git rebase'
abbr rbi='git rebase -i'
abbr psh='git psh'
abbr gst='git status -sb'
abbr co='git checkout'
abbr ci='git commit'
abbr lz='lazygit'
abbr b='bundle'
abbr bu='bundle update'
alias be='bundle exec'
abbr be='bundle exec'
abbr bz='bundle exec zeus'
abbr bl="bundle list"
abbr bo="bundle open"
abbr sp='spring'
abbr sprk='spring rake'
abbr sprs='spring rspec'
abbr dbuild='docker build -t $(basename $(pwd)) .'
abbr yd="youtube-dl"
abbr n="neovide"
abbr o="xdg-open"
abbr si="swayimg"
abbr ze="zellij"

# Global aliases
abbr -g L="| lv"
abbr -g LE="| less"
abbr -g BA="| bat"
abbr -g G="| grep"
abbr -g A="| ag"
abbr -g RG="| rg"
abbr -g C="| cut"
abbr -g S="| sort"
abbr -g RD="RAILS_ENV=development"
abbr -g RP="RAILS_ENV=production"
abbr -g RT="RAILS_ENV=test"

alias all-ruby="docker run --rm -t rubylang/all-ruby /all-ruby/all-ruby"

# ctags for Ruby
if type rbenv > /dev/null 2>&1; then
  alias rtags="ctags -R --langmap=RUBY:.rb --sort=yes -f ~/rtags ~/.rbenv/versions/`cat ~/.rbenv/version`"
fi

eval $(abbr export-alias)
