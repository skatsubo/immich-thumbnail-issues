#!/usr/bin/env bash

script_dir=$(dirname "$0")
cd "$script_dir"

echo "[*] Check sharp"
export NODE_PATH=/usr/src/app/server/node_modules
node sharp.js

echo ; echo "[*] Check heif"
bash heif.sh

echo ; echo "[*] Check vips"
bash vips.sh

# ls
echo ; echo "[*] List files"
ls -l . img /tmp/*.jpg
