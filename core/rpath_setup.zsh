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

if [[ -z $2 ]]; then
  echo "Please provide an rpath paramter."
  exit 1
fi

# Print the list of files in the directory
files=($1/*)
if [[ ${#files} -eq 0 ]]; then
  echo "No files found in directory: $1"
else
  echo "Files in directory: $1"
  for file in $files; do
    if [[ $file != *libllmodel.dylib ]]; then
      install_name_tool -add_rpath $2 $file
      echo $file
    fi
  done
fi