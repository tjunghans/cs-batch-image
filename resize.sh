#!/usr/bin/env bash

source "colors.sh"

function heading() {
  #printf '%s\n\n' "$1"
  echo -e "$1 "
  echo
}

function defdata() {
  echo -e " ${BOLD}$1:${RESET_BOLD} $2"
}

src='/Users/tj/Desktop/source'
dest="/Users/tj/Desktop/resized"
thumb_prefix="tn_"

heading "${BOLD}Resizing${RESET_BOLD}"

defdata "Source" $src
defdata "Destination" $dest
defdata "Thumbnail prefix" $thumb_prefix
echo
echo

if [ -d "$dest" ]; then
  heading "Removing $dest"
  rm -rf "$dest"
fi

heading "Writing new $dest"
mkdir "$dest"


OIFS="$IFS"
IFS=$'\n'
i=0

cd $src
heading "Change to directory: $src"
heading "Resizing images and creating thumbs..."

for img in $(ls *.jpg); do
  (( i++ ))
  printf -v img_counter "%04d" $i
  new_img_name="img$img_counter.jpg"
  convert $src/$img -resize 1600x1600\> $dest/$new_img_name
  printf '%s\n' "Created 1600x1600 $new_img_name" 
  convert $src/$img -resize 120x120\> $dest/$thumb_prefix$new_img_name
  printf '%s\n' "Created 120x120 $thumb_prefix$new_img_name"
  echo 
done

echo -e "${GREEN}Success${NC}"

exit 0
