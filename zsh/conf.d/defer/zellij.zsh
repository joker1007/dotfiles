(( ${+commands[zellij]} )) || return
[[ -n $ZELLIJ ]] || return

# title.zsh の window title 機構に sink として乗り、タブ名を window title に追従させる
function _window_title_set_zellij_tab() {
  command nohup zellij action rename-tab "$1" >/dev/null 2>&1
}

typeset -ga _window_title_sinks
(( ${_window_title_sinks[(Ie)_window_title_set_zellij_tab]} )) || _window_title_sinks+=(_window_title_set_zellij_tab)
