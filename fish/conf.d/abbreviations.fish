# Regular abbreviations
abbr -a h history
abbr -a lt 'ls --tree'
abbr -a llt 'll --tree'
abbr -a tree 'ls --tree'
abbr -a treel 'll --tree'
abbr -a pu pushd
abbr -a pd popd
abbr -a nv nvim

abbr -a ra rails
abbr -a ralis rails
abbr -a tx 'tmux -q has-session && tmux attach-session -d || tmux new-session'

# Git
abbr -a g git
abbr -a st 'git status -sb'
abbr -a gst 'git status -sb'
abbr -a ad 'git add'
abbr -a d 'git diff'
abbr -a dc 'git diff --cached'
abbr -a ft 'git fetch --prune'
abbr -a l 'git lgraph'
abbr -a rb 'git rebase'
abbr -a rbi 'git rebase -i'
abbr -a psh 'git psh'
abbr -a co 'git checkout'
abbr -a ci 'git commit'
abbr -a lz lazygit

# Bundle
abbr -a b bundle
abbr -a bu 'bundle update'
abbr -a be 'bundle exec'
abbr -a bz 'bundle exec zeus'
abbr -a bl 'bundle list'
abbr -a bo 'bundle open'

# Spring
abbr -a sp spring
abbr -a sprk 'spring rake'
abbr -a sprs 'spring rspec'

# Docker
abbr -a dbuild 'docker build -t (basename (pwd)) .'

# Tools
abbr -a yd youtube-dl
abbr -a n neovide
abbr -a o xdg-open
abbr -a si swayimg
abbr -a ze zellij

# Pueue / yt-dlp
abbr -a pa 'pueue add -- yt-dlp --netrc'
abbr -a py 'pueue add -w /mnt/bacchus_data5 -- yt-dlp --netrc'
abbr -a pyy 'pueue add -w /mnt/bacchus_data5/youtube_swimware -- yt-dlp'

# Global abbreviations (expand anywhere in the command line)
abbr -a --position anywhere L '| lv'
abbr -a --position anywhere LE '| less'
abbr -a --position anywhere BA '| bat'
abbr -a --position anywhere G '| grep'
abbr -a --position anywhere A '| ag'
abbr -a --position anywhere RG '| rg'
abbr -a --position anywhere C '| cut'
abbr -a --position anywhere S '| sort'
abbr -a --position anywhere RD 'RAILS_ENV=development'
abbr -a --position anywhere RP 'RAILS_ENV=production'
abbr -a --position anywhere RT 'RAILS_ENV=test'
