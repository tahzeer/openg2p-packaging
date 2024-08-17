#!/bin/bash
# Script to clone a list of repos using a single command. Create a "repos.txt" file as given in the sample in this folder.

branch="17.0-1.2"

# Clone all repos with the branch name
# Check if the correct number of arguments are provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename_list>"
  exit 1
fi

# Input file containing the list of filenames
filename_list=$1

# Prefix to add to each filename
prefix=https://github.com/openg2p/

# Read each line (filename) from the file
while IFS= read -r filename; do
  # Add the prefix to the filename
  new_filename="${prefix}${filename}"
  
  # Create the file (or update its timestamp) using touch
  git clone -b "$branch" "$new_filename"
  
  echo "Cloned: $new_filename"
done < "$filename_list"

