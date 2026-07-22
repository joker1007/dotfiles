(( ${+commands[herdr]} )) || return
[[ -n $HERDR_ENV && -n $HERDR_TAB_ID ]] || return

function _herdr_current_dir() {
  local current_dir=$PWD
  if [[ $current_dir == $HOME ]]; then
    current_dir="~"
  else
    current_dir=${current_dir##*/}
  fi

  echo $current_dir
}

typeset -g _HERDR_LAST_TAB_TITLE=""

function _herdr_change_tab_title() {
  local title=$1
  [[ $title == $_HERDR_LAST_TAB_TITLE ]] && return
  _HERDR_LAST_TAB_TITLE=$title
  command nohup herdr tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>&1
}

function _herdr_set_tab_to_working_dir() {
  _herdr_change_tab_title "$(_herdr_current_dir)"
}

function _herdr_extract_command_name() {
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

function _herdr_set_tab_to_command_line() {
  local cmd=$(_herdr_extract_command_name "$2")
  local dir=$(_herdr_current_dir)
  _herdr_change_tab_title "${dir} - ${cmd}"
}

add-zsh-hook precmd _herdr_set_tab_to_working_dir
add-zsh-hook preexec _herdr_set_tab_to_command_line
