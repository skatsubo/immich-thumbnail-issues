#!/usr/bin/env bash

echo "[*] Install vips tools"
apt-get update -qq
apt-get install -yqq --no-install-recommends libvips-tools &>/dev/null || echo "apt install error: exit $?"

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

echo "[*] Print vips info"
vips --version
vips --targets
ldd "$(which vips)" | grep vips

echo "[*] Test vips"

for file in img/* ; do
  filename="${file#*/}"

  thumb="/tmp/${filename}.vips.thumb.jpg"
  echo "[*] vipsthumbnail: $filename -> $thumb ..."
  vipsthumbnail "$file" --size 100 -o "$thumb" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"

  copy="/tmp/${filename}.vips.copy.jpg"
  echo "[*] vips copy: $filename -> $copy ..."
  vips copy "$file" "$copy" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"
done
