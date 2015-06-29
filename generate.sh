#!/bin/sh
# Copyright 2015 Marc-Antoine Ruel. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.

# This script generates the static website files into 'public/'.

set -eu

ROOT="$(dirname $0)"
echo "Going to $ROOT"
cd "$ROOT"

if [ -e public/.git ]; then
  # public/ is present and is a git submodule or it was previously checked out.
  # Often the checked out revision is not the right one so forcibly update it to
  # the latest commit.
  echo ""
  echo "Found public/ as a git submodule."
  cd public
  git checkout -f master
  git fetch origin
  git reset --hard origin/master
  cd ..
elif [ -d public ]; then
  # public/ is prenset but is not a git checkout. Maybe the user had run
  # ./serve.sh before. Just delete it.
  rm -rf public
fi

if [ ! -d public ]; then
  REMOTE="$(git config --get remote.origin.url)"
  # REMOTE can be either git@github.com:user/project or
  # https://github.com/user/project.git
  # 1. Trim prefix 'https://github.com/'
  # 2. Trim prefix 'git@github.com:'
  # 3. Trim suffix '.git'
  PROJECT="$(echo $REMOTE | sed 's#https://github.com/\(.*\)#\1#' | sed 's#git@github.com:\(.*\)#\1#' | sed 's#\(.*\).git#\1#')"
  USERNAME="$(echo $PROJECT | cut -f 1 -d '/')"
  # public/ is not present. Check it out if possible. It assumes the
  # repository is named 'USER.github.io'.
  REPO_URL="git@github.com:$USERNAME/$USERNAME.github.io"
  echo ""
  echo "public/ was not found; checking out $REPO_URL."
  git clone "$REPO_URL" public
fi

if [ -d public ]; then
  # Delete everything. hugo will recreate everything needed. This permits
  # getting rid of stale files.
  echo ""
  echo "Resetting public/"
  cd public
  git ls-files -z | xargs -0 --no-run-if-empty rm
  git ls-files -z -o | xargs -0 --no-run-if-empty rm
  cd ..
fi

echo ""
echo "Checking for Hugo presence..."
RET=0
hugo --help > /dev/null 2>&1 || RET=$?
if [ $RET -ne 0 ]; then
  echo "Hugo was not found. Getting Hugo from github.com/spf13/hugo."
  go get github.com/spf13/hugo
else
  echo "Hugo is present"
fi

echo ""
echo "Running Hugo to generate the files"
hugo
