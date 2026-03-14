#!/bin/bash

amdgpu_top -J -s 5000 | jq --unbuffered -c '{text: (.devices[0].VRAM["Total VRAM Usage"].value | tostring)}'
