#!/bin/bash

MONITOR="${1:-DP-1}"

# 現在のVRR状態を取得
current=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$MONITOR\") | .vrr")

if [[ "$current" == "true" ]]; then
    hyprctl keyword monitor "$MONITOR,preferred,auto,1,bitdepth,10,vrr,0"
    echo "VRR disabled on $MONITOR"
else
    hyprctl keyword monitor "$MONITOR,preferred,auto,1,bitdepth,10,vrr,1"
    echo "VRR enabled on $MONITOR"
fi
