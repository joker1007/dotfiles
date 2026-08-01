(( ${+commands[herdr]} )) || return
[[ -n $HERDR_ENV && -n $HERDR_TAB_ID ]] || return

# title.zsh の window title 機構に sink として乗り、タブ名を window title に追従させる
function _window_title_set_herdr_tab() {
  command nohup herdr tab rename "$HERDR_TAB_ID" "$1" >/dev/null 2>&1
}

typeset -ga _window_title_sinks
(( ${_window_title_sinks[(Ie)_window_title_set_herdr_tab]} )) || _window_title_sinks+=(_window_title_set_herdr_tab)

# 実行中のコマンドが OSC で更新し続ける title (emerge の進捗表示や nvim など) は
# preexec/precmd では拾えないので、コマンド実行中だけ自 pane の terminal_title を
# ポーリングしてタブ名に追従させる。herdr は pane への OSC 出力を terminal_title
# として追跡しているため、それを読むだけでよい。
typeset -g _HERDR_TITLE_WATCHER_PID=""
typeset -g _HERDR_TITLE_WATCH_INTERVAL=2

function _herdr_title_watcher_loop() {
  local last="" title
  while :; do
    sleep $_HERDR_TITLE_WATCH_INTERVAL
    title=$(command herdr pane get "$HERDR_PANE_ID" 2>/dev/null | command jq -r '.result.pane.terminal_title_stripped // empty') || return
    [[ -z $title || $title == $last ]] && continue
    last=$title
    command herdr tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>&1
  done
}

function _herdr_title_watcher_start() {
  _herdr_title_watcher_stop
  _herdr_title_watcher_loop &!
  _HERDR_TITLE_WATCHER_PID=$!
}

function _herdr_title_watcher_stop() {
  if [[ -n $_HERDR_TITLE_WATCHER_PID ]]; then
    kill $_HERDR_TITLE_WATCHER_PID 2>/dev/null
    _HERDR_TITLE_WATCHER_PID=""
  fi
}

if (( ${+commands[jq]} )); then
  add-zsh-hook preexec _herdr_title_watcher_start
  add-zsh-hook precmd _herdr_title_watcher_stop
fi
