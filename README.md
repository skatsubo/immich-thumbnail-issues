# Immich thumbnail issues
- [HEIC image thumbnail generation failure #22436](#heic-image-thumbnail-generation-failure-22436)
  - [How to](#how-to)
  - [Example output](#example-output)
- [v1.142.0 immich\_server exited with code 139 #21883](#v11420-immich_server-exited-with-code-139-21883)
  - [How to](#how-to-1)
  - [Example output](#example-output-1)

## HEIC image thumbnail generation failure #22436

Github issue: https://github.com/immich-app/immich/issues/22436.

Purpose: to narrow down the bug and to reproduce it directly using `sharp`, `libvips`, `libheif`.

### How to

1. Clone / download the repo.
2. (Optional) Add your samples to `./issue-22436/img`. There is 1 HEIC already.
3. Run from the repo root directory:
```sh
IMMICH=ghcr.io/immich-app/immich-server:v1.143.1
docker run --rm -v ./issue-22436:/test --entrypoint bash "$IMMICH" /test/all.sh
```

### Example output

I cannot reproduce the issue on my system: the script did not error out with "unsupported image format" from sharp or "not a known file format" from libvips.

<details><summary>Output from my system</summary>

```sh
IMMICH=ghcr.io/immich-app/immich-server:v1.143.1
docker run --rm -v ./issue-22436:/test --entrypoint bash "$IMMICH" /test/all.sh

[*] Check sharp
[*] Test sharp operations in directory: img
[*] toBuffer: IMG_9628.HEIC ...
[+] Ok: IMG_9628.HEIC: 36578304 bytes, 3024x4032x3

[*] Check heif
[*] Install heif tools
[*] Use system libs with LD_LIBRARY_PATH=/usr/lib/jellyfin-ffmpeg/lib:/usr/lib/wsl/lib:
[*] Print heif version
1.19.8
libheif: 1.19.8
plugin path: /usr/lib/aarch64-linux-gnu/libheif/plugins
	libheif.so.1 => /lib/aarch64-linux-gnu/libheif.so.1 (0x0000ffff83ae0000)
[*] Test heif
[*] heif-info: IMG_9628.HEIC ...
MIME type: image/heic
main brand: heic
compatible brands: mif1, MiHE, MiPr, miaf, MiHB, heic

image: 3024x4032 (id=49), primary
  tiles: 6x8, tile size: 512x512
  colorspace: YCbCr, 4:2:0
  bit depth: 8
  thumbnail: 240x320
  color profile: prof
  alpha channel: no 
  depth channel: no
metadata:
  Exif: 2792 bytes
transformations:
  angle (ccw): 270
region annotations:
  none
properties:
[+] Ok: IMG_9628.HEIC
[*] Use Immich libs with LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/jellyfin-ffmpeg/lib:/usr/lib/wsl/lib:
[*] Print heif version
1.19.8
libheif: 1.20.2
plugin path: plugins are disabled
	libheif.so.1 => /usr/local/lib/libheif.so.1 (0x0000ffff84c00000)
[*] Test heif
[*] heif-info: IMG_9628.HEIC ...
MIME type: image/heic
main brand: heic
compatible brands: mif1, MiHE, MiPr, miaf, MiHB, heic

image: 3024x4032 (id=49), primary
  tiles: 6x8, tile size: 512x512
  colorspace: YCbCr, 4:2:0
  bit depth: 8
  thumbnail: 240x320
  color profile: prof
  alpha channel: no 
  depth channel: no
metadata:
  Exif: 2792 bytes
transformations:
  angle (ccw): 270
region annotations:
  none
properties:
[+] Ok: IMG_9628.HEIC

[*] Check vips
[*] Install vips tools
[*] Use system libs with LD_LIBRARY_PATH=/usr/lib/jellyfin-ffmpeg/lib:/usr/lib/wsl/lib:
[*] Print vips version
vips-8.16.1
builtin targets:   SVE2_128 SVE_256 SVE2 SVE NEON_BF16 NEON NEON_WITHOUT_AES
supported targets: NEON NEON_WITHOUT_AES
	libvips.so.42 => /lib/aarch64-linux-gnu/libvips.so.42 (0x0000ffffaf270000)
[*] Test vips
[*] vips header: IMG_9628.HEIC ...
img/IMG_9628.HEIC: 3024x4032 uchar, 3 bands, srgb, heifload
[+] Ok: IMG_9628.HEIC
[*] vips heifload: IMG_9628.HEIC ...
heifload: too few arguments
[-] Error: exit 1: IMG_9628.HEIC
[*] vips heifload: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips ...
[+] Ok: IMG_9628.HEIC
[*] vips copy: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips.copy.jpg ...
[+] Ok: IMG_9628.HEIC
[*] vipsthumbnail: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips.thumb.jpg ...
[+] Ok: IMG_9628.HEIC
[*] Use Immich libs with LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/jellyfin-ffmpeg/lib:/usr/lib/wsl/lib:
[*] Print vips version
vips-8.17.1
builtin targets:   SVE2_128 SVE_256 SVE2 SVE NEON_BF16 NEON NEON_WITHOUT_AES
supported targets: NEON NEON_WITHOUT_AES
	libvips.so.42 => /usr/local/lib/libvips.so.42 (0x0000ffff933c0000)
[*] Test vips
[*] vips header: IMG_9628.HEIC ...
img/IMG_9628.HEIC: 3024x4032 uchar, 3 bands, srgb, heifload
[+] Ok: IMG_9628.HEIC
[*] vips heifload: IMG_9628.HEIC ...
img/IMG_9628.HEIC: bad seek to 846905
img/IMG_9628.HEIC: bad seek to 846879
img/IMG_9628.HEIC: bad seek to 846875
img/IMG_9628.HEIC: bad seek to 846874
heifload: too few arguments
[-] Error: exit 1: IMG_9628.HEIC
[*] vips heifload: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips ...
[+] Ok: IMG_9628.HEIC
[*] vips copy: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips.copy.jpg ...
[+] Ok: IMG_9628.HEIC
[*] vipsthumbnail: IMG_9628.HEIC -> /tmp/IMG_9628.HEIC.vips.thumb.jpg ...
[+] Ok: IMG_9628.HEIC

[*] List files
-rw-r--r-- 1 root root 529704 Sep 27 12:10 /tmp/IMG_9628.HEIC.vips.copy.jpg
-rw-r--r-- 1 root root   6537 Sep 27 12:10 /tmp/IMG_9628.HEIC.vips.thumb.jpg

.:
total 16
-rw-r--r-- 1 root root  297 Sep 27 12:01 all.sh
-rw-r--r-- 1 root root  772 Sep 27 11:59 heif.sh
drwxr-xr-x 1 root root   96 Sep 27 07:00 img
-rw-r--r-- 1 root root  656 Sep 27 11:09 sharp.js
-rw-r--r-- 1 root root 1529 Sep 27 12:10 vips.sh

img:
total 828
-rw-rw-rw- 1 root root 846873 Sep 26 20:35 IMG_9628.HEIC
```
</details>

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
