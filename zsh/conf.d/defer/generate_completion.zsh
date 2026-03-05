if type -p kaf &>/dev/null; then
  if [[ ! -e "$ZSH_CACHE_DIR/completions/_kaf" ]]; then
    kaf completion zsh >| "$ZSH_CACHE_DIR/completions/_kaf" &|
  fi
fi

if type -p pueue &>/dev/null; then
  if [[ ! -e "$ZSH_CACHE_DIR/completions/_pueue" ]]; then
    pueue completions zsh >| "$ZSH_CACHE_DIR/completions/_pueue" &|
  fi
fi

if type -p zellij &>/dev/null; then
  if [[ ! -e "$ZSH_CACHE_DIR/completions/_zellij" ]]; then
    zellij setup --generate-completion zsh >| "$ZSH_CACHE_DIR/completions/_zellij" &|
  fi
fi

if type -p asdf &>/dev/null; then
  if [[ ! -e "$ZSH_CACHE_DIR/completions/_asdf" ]]; then
    asdf completion zsh "$plugin" >| "$ZSH_CACHE_DIR/completions/_asdf" &|
  fi
fi
