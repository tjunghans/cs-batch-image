#!/usr/bin/env bash

source "colors.sh"

# Helpers
function heading() {
  echo -e "$1 "
  echo
}

function defdata() {
  echo -e " ${BOLD}$1:${RESET_BOLD} $2"
}

function showHelp() {
  echo "$(cat help.txt)"
}

# Defaults and options
dryRun=false
src=
dest=
thumb_prefix="tn_"
timestamp=$(date +%s)

# Command line options
while [ "$1" != "" ]; do
  case $1 in
    -s | --source )       shift
                          src=$1
                          ;;
    -d | --dest )         shift
                          dest=$1
                          ;;
    -t | --thumb-prefix ) shift
                          thumb_prefix=$1
                          ;;
    --dry )               dryRun=true
                          ;;
    -h | --help )         showHelp 
                          exit
                          ;;
    * )                   showHelp
                          exit 1
  esac
  shift
done

if [[ -z "$src" ]]; then
  echo -e "${RED}Please provide --source and the path to the images${NC}" 
  exit 1
fi

if [[ -z "$dest" ]]; then
  dest="$src/resized-$timestamp"
fi

heading "${BOLD}Resizing${RESET_BOLD}"

if [ "$dryRun" = true ]; then
  echo "dry run"
  echo
fi

defdata "Source" $src
defdata "Destination" $dest
defdata "Thumbnail prefix" $thumb_prefix
echo
echo

if [ -d "$dest" ]; then
  heading "Removing $dest"
  if [ "$dryRun" = false ]; then
    rm -rf "$dest"
  fi
fi

heading "Writing new $dest"
if [ "$dryRun" = false ]; then
  mkdir "$dest"
fi


OIFS="$IFS"
IFS=$'\n'
i=0

cd $src
heading "Change to directory: $src"
heading "Resizing images and creating thumbs..."

for img in $(ls | grep -i '\.jpg$'); do
  (( i++ ))
  printf -v img_counter "%04d" $i
  new_img_name="img$img_counter.jpg"
  if [ "$dryRun" = false ]; then
    convert $src/$img -resize 1600x1600\> $dest/$new_img_name
  fi
  printf '%s\n' "Created 1600x1600 $new_img_name" 
  if [ "$dryRun" = false ]; then
    convert $src/$img -resize 120x120\> $dest/$thumb_prefix$new_img_name
  fi
  printf '%s\n' "Created 120x120 $thumb_prefix$new_img_name"
  echo 
done

echo -e "${GREEN}Success${NC}"

exit 0
