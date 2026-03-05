# Do nothing if op is not installed
(( ${+commands[op]} )) || return

if [[ ! -e "$ZSH_CACHE_DIR/completions/_op" ]]; then
  op completion zsh >| "$ZSH_CACHE_DIR/completions/_op" &|
fi


if [ -f ~/.config/op/plugins.sh ]; then
  source ~/.config/op/plugins.sh
fi
