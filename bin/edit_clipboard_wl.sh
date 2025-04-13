#!/bin/bash

set -eo pipefail

tmpfile=$(mktemp -q /tmp/edit_clipboard.XXXXXX)
ctime1=$(stat -c "%Y" $tmpfile)
empty=

usage() {
  echo -e "Usage: $0 [-e] [-t TERMINAL_CMD]\n\t-e\t\topen empty buffer \n\t-t TERMINAL_CMD\topen with terminal" 1>&2
  exit 1
}

while getopts t:eh OPT
do
  case $OPT in
    e) empty=true
      ;;
    t) TERMCMD=$OPTARG
      ;;
    h) usage
      ;;
    ?) usage
      ;;
  esac
done

atexit() {
  [[ -f ${tmpfile} ]] && rm -f ${tmpfile}
}

trap atexit EXIT

if [[ -z "$empty" ]]; then
  wl-paste -n >$tmpfile
fi

if [ -n "${UWSM_FINALIZE_VARNAMES}" ]; then
  UWSM_PREFIX="uwsm app -- "
fi

if [[ -z "${TERMCMD}" ]]; then
  zsh -c "${UWSM_PREFIX}${EDITOR} $tmpfile"
else
  zsh -c "${UWSM_PREFIX}${TERMCMD} ${EDITOR} $tmpfile"
fi

result=$(< $tmpfile)
ctime2=$(stat -c "%Y" $tmpfile)

if [[ -n "$result" ]] && [[ $ctime2 -gt $ctime1 ]]; then
  echo -n "$result" | wl-copy -n
  echo -n "$result" | wl-copy -n -p
fi
