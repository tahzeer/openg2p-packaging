#!/bin/bash
# Script to create commit in bulk a list of repos using a single command. Create a "repos.txt" file as given in the sample in this folder.

# Clone all repos with the branch name
# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <reponame_list> <branch_name>"
  exit 1
fi

# Input file containing the list of filenames
reponame_list=$1
root_dir=`pwd`
# Read each line (filename) from the file
while IFS= read -r filename; do
  cd ${root_dir}/${filename}
  #git add .
  #git commit -m "Version updated"
  git push origin $2
  echo "Committed: ${filename}"
done < "$reponame_list"
