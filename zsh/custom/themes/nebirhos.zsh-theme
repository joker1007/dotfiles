# Based on robbyrussell's theme, with host and rvm indicators. Example:
# @host ➜ currentdir rvm:(rubyversion@gemset) git:(branchname)

if type ruby > /dev/null 2>&1; then
  local colornum_r=`ruby -r digest/sha1 -e "puts Digest::SHA1.hexdigest('$(hostname)-r').to_i(16) % 255"`
  local colornum_g=`ruby -r digest/sha1 -e "puts Digest::SHA1.hexdigest('$(hostname)-g').to_i(16) % 255"`
  local colornum_b=`ruby -r digest/sha1 -e "puts Digest::SHA1.hexdigest('$(hostname)-b').to_i(16) % 255"`
  local HOSTCOLOR="[01;38;2;${colornum_r};${colornum_g};${colornum_b}m"
else
  local HOSTCOLOR=$fg_bold[yellow]
fi

# Get the current ruby version in use with RVM:
if [ -e ~/.rvm/bin/rvm-prompt ]; then
    RUBY_PROMPT_="%{$fg_bold[blue]%}rvm:(%{$fg[green]%}\$(~/.rvm/bin/rvm-prompt s i v g)%{$fg_bold[blue]%})%{$reset_color%} "
else
  if which rbenv &> /dev/null; then
    RUBY_PROMPT_="%{$fg_bold[blue]%}rbenv:(%{$fg[green]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$fg_bold[blue]%})%{$reset_color%} "
  fi
fi

if type ruby > /dev/null 2>&1; then
  BUNDLE_GEMFILE_PROMPT_="%{$fg_bold[blue]%}gemfile:(%{$fg[green]%}\$(echo \$BUNDLE_GEMFILE)%{$fg_bold[blue]%})%{$reset_color%} "
fi

# Get the host name (first 4 chars)
HOST_PROMPT_="%{$HOSTCOLOR%}%n@%m %{$fg_bold[cyan]%}%c "
GIT_PROMPT="%{$fg_bold[blue]%}\$(git_prompt_info)\$(git_prompt_status)%{$fg_bold[blue]%} % %{$reset_color%}"
TIME_PROMPT="[%T]"
PROMPT="$HOST_PROMPT_$RUBY_PROMPT_$BUNDLE_GEMFILE_PROMPT_${GIT_PROMPT}$TIME_PROMPT
%# "

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
