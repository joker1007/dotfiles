alias fullreset='echo "\ec\ec"'
alias h='history'
alias ls='eza --group-directories-first --icons --smart-group --git'
alias ll='ls -lagB'
alias llh='ls -lah'
alias lt='ls --tree'
alias llt='ll --tree'
alias tree='ls --tree'
alias treel='ll --tree'
alias pu=pushd
alias pd=popd
alias nv='nvim'

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
alias si="swayimg"
alias ze="zellij"

# Global aliases
alias -g L="| lv"
alias -g LE="| less"
alias -g BA="| bat"
alias -g G="| grep"
alias -g A="| ag"
alias -g RG="| rg"
alias -g C="| cut"
alias -g S="| sort"
alias -g RD="RAILS_ENV=development"
alias -g RP="RAILS_ENV=production"
alias -g RT="RAILS_ENV=test"

alias all-ruby="docker run --rm -t rubylang/all-ruby /all-ruby/all-ruby"
