#!/bin/zsh

# Check if a directory parameter is provided
if [[ -z $1 ]]; then
  echo "Please provide a directory parameter."
  exit 1
fi

# Check if the directory exists
if [[ ! -d $1 ]]; then
  echo "Directory not found: $1"
  exit 1
fi

# Check if a directory parameter is provided
if [[ -z $2 ]]; then
  echo "Please provide a directory parameter."
  exit 1
fi

# Check if the directory exists
if [[ ! -d $2 ]]; then
  echo "Directory not found: $1"
  exit 1
fi

# Check if a directory parameter is provided
if [[ -z $3 ]]; then
  echo "Please provide a directory parameter."
  exit 1
fi

# Check if the directory exists
if [[ ! -d $3 ]]; then
  echo "Directory not found: $3"
  exit 1
fi

# Print the list of files in the directory
files=($1/*)
if [[ ${#files} -eq 0 ]]; then
  echo "No files found in directory: $1"
else
  echo "Files in directory: $1"
  for file in $files; do
    echo $1/$(basename $file)
    echo $2/$(basename $file)
    echo $3/$(basename $file)
    lipo -create $file -create $2/$(basename $file) -output $3/$(basename $file)
  done
fi