#!/bin/sh
# Copyright 2015 Marc-Antoine Ruel. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.

# This script commits changes done by ./generate.sh and pushes it to the
# repositoriy.
# This script assumes 'public/' is a git submodule to the static web site.

set -eu

ROOT="$(dirname $0)"
echo "Going to $ROOT"
cd "$ROOT"

HASH_VALUE="$(git log -1 --format='%h')"
SUBJECT="$(git log -1 --format='%s')"
REMOTE="$(git config --get remote.origin.url)"
# REMOTE can be either git@github.com:user/project or
# https://github.com/user/project.git
# 1. Trim prefix 'https://github.com/'
# 2. Trim prefix 'git@github.com:'
# 3. Trim suffix '.git'
PROJECT="$(echo $REMOTE | sed 's#https://github.com/\(.*\)#\1#' | sed 's#git@github.com:\(.*\)#\1#' | sed 's#\(.*\).git#\1#')"
echo ""
echo "Processing commit $HASH_VALUE for project $PROJECT"
echo "Commit message is $SUBJECT"

echo ""
echo "Going into public/"
echo "Remote is $(git config --get remote.origin.url)"
cd public

if [ "$CI" = "true" ]; then
  # When running on a CI, the author settings are not set, which causes git
  # commit to fail.
  echo ""
  echo "Changing local settings."
  git config user.email "automated@localhost"
  git config user.name "automated"
fi

echo ""
git add -f --all .
# git diff --name-only --no-ext-diff --no-color HEAD
COMMIT_TIME="$(date -Iseconds -u)"
MSG="Updated on $COMMIT_TIME for https://github.com/$PROJECT/commit/$HASH_VALUE\n\n$SUBJECT"

echo ""
echo "Committing with message:"
echo "---"
echo "$MSG"
echo "---"
RET=0
git commit -a -m "$MSG" || RET=$?
if [ $RET -eq 0 ]; then
  echo ""
  echo "Pushing"
  git push origin master
else
  echo "Nothing changed, skipping push"
fi
