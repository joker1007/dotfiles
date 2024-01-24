#!/bin/bash

name=$(tailscale status --json --peers=false | jq -r .CurrentTailnet.Name | tr -d '\n')

echo "{\"text\": \"tailscale: ${name}\"}"
