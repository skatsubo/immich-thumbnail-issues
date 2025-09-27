#!/usr/bin/env bash

dir="img"

install_vips() {
  pkg="libvips-tools"

  echo "[*] Install vips tools"
  apt-get update -qq
  apt-get install -yqq --no-install-recommends $pkg &>/dev/null || echo "apt install error: exit $?"
}

test_vips() {
  echo "[*] Print vips version"
  vips --version
  vips --targets
  ldd "$(which vips)" | grep vips

  echo "[*] Test vips"
  for file in "$dir"/* ; do
    filename="${file#*/}"

    echo "[*] vips header: $filename ..."
    vipsheader "$file" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"

    echo "[*] vips heifload: $filename ..."
    vips heifload "$file"         && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"

    load="/tmp/${filename}.vips"
    echo "[*] vips heifload: $filename -> $load ..."
    vips heifload "$file" "$load" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"

    copy="/tmp/${filename}.vips.copy.jpg"
    echo "[*] vips copy: $filename -> $copy ..."
    vips copy "$file" "$copy" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"

    thumb="/tmp/${filename}.vips.thumb.jpg"
    echo "[*] vipsthumbnail: $filename -> $thumb ..."
    vipsthumbnail "$file" --size 100 -o "$thumb" && echo "[+] Ok: $filename" || echo "[-] Error: exit $?: $filename"
  done
}

install_vips

echo "[*] Use system libs with LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
test_vips

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
echo "[*] Use Immich libs with LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
test_vips
