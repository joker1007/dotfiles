function __add_generated_completion() {
  local cmd="$1"
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_${cmd}" ]]; then
    typeset -g -A _comps
    autoload -Uz _${cmd}
    _comps[${cmd}]=_${cmd}
  fi
}

if type -p kaf &>/dev/null; then
  kaf completion zsh >| "$ZSH_CACHE_DIR/completions/_kaf" &|
  add_generated_completion "kaf"
fi

if type -p pueue &>/dev/null; then
  pueue completions zsh >| "$ZSH_CACHE_DIR/completions/_pueue" &|
  add_generated_completion "pueue"
fi

if type -p zellij &>/dev/null; then
  zellij setup --generate-completion zsh >| "$ZSH_CACHE_DIR/completions/_zellij" &|
  add_generated_completion "zellij"
fi

if type -p asdf &>/dev/null; then
  asdf completion zsh "$plugin" >| "$ZSH_CACHE_DIR/completions/_asdf" &|
  add_generated_completion "asdf"
fi
