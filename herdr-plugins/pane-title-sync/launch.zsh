#!/usr/bin/env zsh
# [[startup]] フックはワンショットなので、デーモン本体は切り離して起動する
nohup zsh "${0:a:h}/daemon.zsh" >/dev/null 2>&1 &!
exit 0
