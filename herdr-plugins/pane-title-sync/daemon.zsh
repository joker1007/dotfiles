#!/usr/bin/env zsh
# 各 pane の OSC 由来 terminal_title を pane border のラベルへ反映し続けるデーモン。
# ユーザーが手動で付けたラベル (自分が設定した値と一致しないもの) には触らない。
# herdr server が止まったら (api snapshot が失敗したら) 自動終了する。

emulate -L zsh
setopt pipe_fail

herdr_bin=${HERDR_BIN_PATH:-herdr}
state_dir=${HERDR_PLUGIN_STATE_DIR:-${HERDR_PLUGIN_CONFIG_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/herdr-pane-title-sync}}
interval=${PANE_TITLE_SYNC_INTERVAL:-2}
# タブは zsh の read で IFS 空白扱いされ空フィールドが潰れるので、区切りは US (0x1f)
sep=$'\x1f'

mkdir -p $state_dir
pidfile=$state_dir/daemon.pid
statefile=$state_dir/labels.usv # pane_id <US> 自分が最後に設定したラベル

if [[ -f $pidfile ]] && kill -0 "$(<$pidfile)" 2>/dev/null; then
  exit 0
fi
print $$ > $pidfile

# 再起動時に「自分が付けたラベル」の記憶を復元する
typeset -A ours
if [[ -f $statefile ]]; then
  while IFS=$sep read -r pane_id label; do
    [[ -n $pane_id ]] && ours[$pane_id]=$label
  done < $statefile
fi

function persist_state() {
  local pane_id tmp=$statefile.tmp
  : > $tmp
  for pane_id in ${(k)ours}; do
    print -r -- "${pane_id}${sep}${ours[$pane_id]}" >> $tmp
  done
  mv $tmp $statefile
}

while :; do
  snapshot=$($herdr_bin api snapshot 2>/dev/null) || exit 0

  typeset -A seen
  seen=()
  changed=0

  while IFS=$sep read -r pane_id label title; do
    [[ -n $pane_id ]] || continue
    seen[$pane_id]=1
    [[ -n $title ]] || continue
    # 手動ラベルが付いている (自分が設定した値ではない) pane はユーザー優先
    if [[ -n $label && $label != ${ours[$pane_id]:-} ]]; then
      continue
    fi
    if [[ $title != $label ]]; then
      if $herdr_bin pane rename $pane_id "$title" >/dev/null 2>&1; then
        ours[$pane_id]=$title
        changed=1
      fi
    fi
  done < <(print -r -- $snapshot | jq -r '
    .result.snapshot.panes[]
    | [.pane_id, (.label // ""), (.terminal_title_stripped // "")]
    | join("\u001f")')

  # 閉じられた pane の記憶を掃除する
  for pane_id in ${(k)ours}; do
    if [[ -z ${seen[$pane_id]:-} ]]; then
      unset "ours[$pane_id]"
      changed=1
    fi
  done

  (( changed )) && persist_state

  sleep $interval
done
