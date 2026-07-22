(( ${+commands[zellij]} )) || return

function current_dir() {
  local current_dir=$PWD
  if [[ $current_dir == $HOME ]]; then
    current_dir="~"
  else
    current_dir=${current_dir##*/}
  fi

  echo $current_dir
}

function change_tab_title() {
  local title=$1
  command nohup zellij action rename-tab $title >/dev/null 2>&1
}

function set_tab_to_working_dir() {
  local result=$?
  local title=$(current_dir)
  # uncomment the following to show the exit code after a failed command
  # if [[ $result -gt 0 ]]; then
  #     title="$title [$result]" 
  # fi

  change_tab_title $title
}

function extract_command_name() {
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

function set_tab_to_command_line() {
  local cmd=$(extract_command_name "$2")
  local dir=$(current_dir)
  change_tab_title "${dir} - ${cmd}"
}

if [[ -n $ZELLIJ ]]; then
  add-zsh-hook precmd set_tab_to_working_dir
  add-zsh-hook preexec set_tab_to_command_line
fi
