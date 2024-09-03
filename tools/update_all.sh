#!/bin/bash
# Script to pull the latest of all repos listed in a file on the existing
# branch. If there are local changes, this script will exit with warning.
# Usage:
# $ update_all.sh <repos file>

# Arguments check
if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename_list>"
  exit 1
fi

filenames=$1
root_dir=`pwd`

# Check for any changed files before pulling
changed=0
while IFS= read -r filename; do
    cd $root_dir/$filename
    if [[ $(git status -s) ]]; then
        echo "There are changed files in $filename"
	changed=1
    fi
done < "$filenames"
if [[ $changed -ne 0 ]];then
    exit 1
fi

# Git pull
cd $root_dir
while IFS= read -r filename; do
    cd $root_dir/$filename
    echo $filename
    git pull
done < $filenames
