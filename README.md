# Immich thumbnail issues
- [v1.142.0 immich\_server exited with code 139 #21883](#v11420-immich_server-exited-with-code-139-21883)
  - [How to](#how-to)
  - [Example output](#example-output)

## v1.142.0 immich_server exited with code 139 #21883

Github issue: https://github.com/immich-app/immich/issues/21883.

Purpose: to narrow down the bug and to reproduce it directly using `sharp` and `libvips`.

### How to

1. Clone / download the repo.
2. (Optional) Add your samples to `./issue-21883/img`. There are 2 SVGs already.
3. Run from the repo root directory:
```sh
IMMICH=ghcr.io/immich-app/immich-server:v1.142.1
docker run --rm -ti -v ./issue-21883:/test --entrypoint bash "$IMMICH" /test/all.sh
```

### Example output

I cannot reproduce the issue on my system, so to make the output more interesting I added a corrupted file.

```sh
[*] Check sharp
[*] Test sharp resize in directory: img
[*] Resize: ShiSHcat_hi_purchased.svg -> /tmp/ShiSHcat_hi_purchased.svg.sharp.resize.jpg ...
[+] Ok: ShiSHcat_hi_purchased.svg
[*] Resize: cor rup ted.png -> /tmp/cor rup ted.png.sharp.resize.jpg ...
[-] Error: cor rup ted.png: Error: Input file contains unsupported image format
    at Sharp.toFile (/usr/src/app/server/node_modules/.pnpm/sharp@0.34.3/node_modules/sharp/lib/output.js:90:19)
    at /test/sharp.js:15:88
[*] Resize: eth-pajo_minimal.svg -> /tmp/eth-pajo_minimal.svg.sharp.resize.jpg ...
[+] Ok: eth-pajo_minimal.svg

[*] Check vips
[*] Install vips tools
[*] Print vips info
vips-8.17.1
builtin targets:   SVE2_128 SVE_256 SVE2 SVE NEON_BF16 NEON NEON_WITHOUT_AES
supported targets: NEON NEON_WITHOUT_AES
	libvips.so.42 => /usr/local/lib/libvips.so.42 (0x0000ffffac920000)
[*] Test vips
[*] vipsthumbnail: ShiSHcat_hi_purchased.svg -> /tmp/ShiSHcat_hi_purchased.svg.vips.thumb.jpg ...
[+] Ok: ShiSHcat_hi_purchased.svg
[*] vips copy: ShiSHcat_hi_purchased.svg -> /tmp/ShiSHcat_hi_purchased.svg.vips.copy.jpg ...
[+] Ok: ShiSHcat_hi_purchased.svg
[*] vipsthumbnail: cor rup ted.png -> /tmp/cor rup ted.png.vips.thumb.jpg ...
vipsthumbnail: unable to thumbnail img/cor rup ted.png
VipsForeignLoad: "img/cor rup ted.png" is not a known file format
[-] Error: exit 255: cor rup ted.png
[*] vips copy: cor rup ted.png -> /tmp/cor rup ted.png.vips.copy.jpg ...
VipsForeignLoad: "img/cor rup ted.png" is not a known file format
[-] Error: exit 1: cor rup ted.png
[*] vipsthumbnail: eth-pajo_minimal.svg -> /tmp/eth-pajo_minimal.svg.vips.thumb.jpg ...
[+] Ok: eth-pajo_minimal.svg
[*] vips copy: eth-pajo_minimal.svg -> /tmp/eth-pajo_minimal.svg.vips.copy.jpg ...
[+] Ok: eth-pajo_minimal.svg

[*] List files
-rw-r--r-- 1 root root 2071 Sep 21 13:43 /tmp/ShiSHcat_hi_purchased.svg.sharp.resize.jpg
-rw-r--r-- 1 root root 1008 Sep 21 13:43 /tmp/ShiSHcat_hi_purchased.svg.vips.copy.jpg
-rw-r--r-- 1 root root 2549 Sep 21 13:43 /tmp/ShiSHcat_hi_purchased.svg.vips.thumb.jpg
-rw-r--r-- 1 root root  266 Sep 21 13:43 /tmp/eth-pajo_minimal.svg.sharp.resize.jpg
-rw-r--r-- 1 root root 3451 Sep 21 13:43 /tmp/eth-pajo_minimal.svg.vips.copy.jpg
-rw-r--r-- 1 root root  923 Sep 21 13:43 /tmp/eth-pajo_minimal.svg.vips.thumb.jpg

.:
total 12
-rw-r--r-- 1 root root 269 Sep 21 13:28 all.sh
drwxr-xr-x 1 root root 160 Sep 21 13:26 img
-rw-r--r-- 1 root root 678 Sep 21 13:23 sharp.js
-rw-r--r-- 1 root root 795 Sep 21 13:43 vips.sh

img:
total 20
-rw-r--r-- 1 root root 10130 Sep 19 13:39  ShiSHcat_hi_purchased.svg
-rw-r--r-- 1 root root     4 Sep 21 12:13 'cor rup ted.png'
-rw-r--r-- 1 root root   189 Sep 19 11:02  eth-pajo_minimal.svg
```
