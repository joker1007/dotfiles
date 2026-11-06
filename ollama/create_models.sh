#!/usr/bin/env bash
# このディレクトリの Modelfile.<name> をすべて ollama に登録する
set -euo pipefail
cd "$(dirname "$0")"
for f in Modelfile.*; do
  name="${f#Modelfile.}"
  echo "==> ollama create $name"
  ollama create "$name" -f "$f"
done
