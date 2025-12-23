#!/usr/bin/env bash

#
# constants
#
image_size=1500x2500
font_size=100

orientation=6
description[6]="rotate 90°"   # 90° clockwise
description[8]="rotate 270°"  # 90° counter clockwise
inverse[6]=8
IM[8]="left-bottom"

file_base="img/base.jpg"

#
# functions
#
generate() {
  mkdir -p img

  echo "== Create base image $image_size: $file_base =="
  magick -size $image_size xc:lightgray -pointsize $font_size \
      -gravity north -draw 'text 10,10 Top' \
      -gravity south -draw 'text 10,10 Bottom' \
      -gravity west -draw 'text 10,10 Left' \
      -gravity east -draw 'text 10,10 Right' \
      "$file_base"
  echo

  for tag in "IFD0" "XMP-tiff"; do
    echo "== Generate image with $tag:Orientation =="
    file_annotated="img/work-${tag}-annotated.jpg"
    file_inverse="img/work-${tag}-inverse.jpg"
    file_ready="img/img-${tag}-${orientation}.jpg"

    # cleanup: remove intermediate files from previous runs
    rm -f "$file_annotated" "$file_inverse" "$file_ready" || true

    echo "1. Annotate image: $tag:Orientation $orientation / ${description[$orientation]}"
    magick "$file_base" -pointsize $font_size \
      -gravity center -draw "text 0,-$font_size '$tag:Orientation'" \
      -gravity center -draw "text 0,+$font_size '$orientation / ${description[$orientation]}'" \
      "$file_annotated"

    echo "2. Inverse rotate image: ${description[${inverse[$orientation]}]}"
    magick "$file_annotated" -orient "${IM[${inverse[$orientation]}]}" -auto-orient "$file_inverse"

    echo "3. Set tag: $tag:Orientation=$orientation"
    exiftool "$file_inverse" -n -"$tag:Orientation"="$orientation" -o "$file_ready"

    echo "Created: $file_ready"
    exiftool -a -G1 -Orientation -FileName "$file_ready"

    # cleanup
    rm -f "$file_annotated" "$file_inverse" || true

    echo
  done
  # cleanup
  rm -f "$file_base" || true
}

#
# main
#
generate
