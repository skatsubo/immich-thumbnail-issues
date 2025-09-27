#!/usr/bin/env bash

dir="img"

install_heif() {
  pkg="libheif-examples"

  echo "[*] Install heif tools"
  apt-get update -qq
  apt-get install -yqq --no-install-recommends $pkg &>/dev/null || echo "apt install error: exit $?"
}

test_heif() {
  echo "[*] Print heif version"
  heif-info -v
  ldd "$(which heif-info)" | grep heif

  echo "[*] Test heif"
  for file in "$dir"/* ; do
    filename="${file#*/}"
    echo "[*] heif-info: $filename ..."
    heif-info "$file" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"
  done
}

install_heif

echo "[*] Use system libs with LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
test_heif

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
echo "[*] Use Immich libs with LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
test_heif
