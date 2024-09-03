#!/bin/bash
#d
# Tag a repo on existing branch
# $ tag_repo.sh <reponame> <tagname>
# reponame is w.r.t to this script

# Arguments check
if [ $# -ne 2 ]; then
  echo "Usage: $0 <reponame> <tagname>"
  exit 1
fi

reponame=$1
tagname=$2
pattern="^v[0-9].[0-9].[0-9]$"

# Check tagname convention
if ! [[ $tagname =~ $pattern ]]; then
    echo "Tag convention not followed"
    exit 1
fi

root_dir=`pwd`
# Check of the branch has moved at all
cd $root_dir/$reponame
latest_tag=`git describe --tags --abbrev=0`
if [[ -z $(git diff $latest_tag) ]]; then
   echo "No changes on this branch. Tag not created" 1>&2;
   exit 1
fi

# Create tag
cd $root_dir/$reponame
git tag $tagname
