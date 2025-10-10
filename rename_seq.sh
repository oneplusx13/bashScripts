#!/bin/bash

# rename all files in folder sequentially

# Check for input folder
if [ -z "$1" ]; then
  echo "Usage: bash $0 /path/to/folder"
  exit 1
fi

# make sure folder is valid
if [ ! -d "$1" ]; then
  echo "Error: '$1' is not a valid directory."
  exit 1
fi

# choose base name
read -p "Enter a base name for all files: " basename

# start counting
count=1


# loop through all files
for file in "$1"/*; do
  # skip wierd files
  [ -f "$file" ] || continue

# find file extension
  extension="${file##*.}"
  if [ "$file" = "$1/$extension" ]; then
    extension=""
  else
    extension=".$extension"
  fi

# new name = basename + number + extension
  newname="${basename}_${count}${extension}"

# Rename files
  mv "$file" "$1/$newname"
  echo "Renamed: $(basename "$file") -> $newname"

# Increment
  count=$((count + 1))
done

# success
echo "All files renamed successfully!"
