#!/bin/bash

id=$(pw-dump Node | jq -r 'map({id: .id, class: .info.props["media.class"], desc: .info.props["node.description"]} | select(.desc != null)) | sort_by(.class, .desc) | .[] | [.id, .class, .desc] | @tsv' | wofi -di | cut -f 1)

if [ -n "$id" ]; then
  echo "Setting default to $id"
  wpctl set-default $id
fi
