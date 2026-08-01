# ターミナルの window title (OSC 2) を precmd/preexec で設定する共通機構。
# multiplexer のタブ名も同じ文字列にしたい場合は、herdr.zsh / zellij.zsh の様に
# `_window_title_sinks` へ関数を追加する。sink は $1 に title を受け取る。

function _title_current_dir() {
  if [[ $PWD == $HOME ]]; then
    print -r -- "~"
  else
    print -r -- ${PWD##*/}
  fi
}

function _title_extract_command_name() {
  local -a words=(${(z)1})
  local cmd=${words[1]}

  if [[ $cmd == sudo ]]; then
    local i=2
    while (( i <= $#words )); do
      case ${words[i]} in
        # 引数を取る sudo のオプションは値ごと読み飛ばす
        -u|-g|-p|-U|-C|-h|-r|-t|-T|--user|--group|--prompt|--other-user|--close-from|--host|--role|--type)
          (( i += 2 )) ;;
        -*|*=*) (( i += 1 )) ;;
        *) break ;;
      esac
    done
    if (( i <= $#words )); then
      cmd="sudo ${words[i]}"
    fi
  fi

  print -r -- $cmd
}

function _window_title_set_osc() {
  printf '\e]2;%s\a' "$1"
}

typeset -g _WINDOW_TITLE_LAST=""
typeset -ga _window_title_sinks
(( ${_window_title_sinks[(Ie)_window_title_set_osc]} )) || _window_title_sinks+=(_window_title_set_osc)

function _window_title_update() {
  local title=$1
  [[ $title == $_WINDOW_TITLE_LAST ]] && return
  _WINDOW_TITLE_LAST=$title
  local sink
  for sink in $_window_title_sinks; do
    $sink "$title"
  done
}

function _window_title_precmd() {
  _window_title_update "$(_title_current_dir)"
}

function _window_title_preexec() {
  _window_title_update "$(_title_current_dir) - $(_title_extract_command_name "$2")"
}

add-zsh-hook precmd _window_title_precmd
add-zsh-hook preexec _window_title_preexec
