#!/bin/bash

text=$(cat /tmp/current_lyrics.txt | sed -z 's/\n/\\n/g')

printf '{"text": "%s", "tooltip": "%s"}' "$text" "$text"
