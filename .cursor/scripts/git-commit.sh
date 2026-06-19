#!/usr/bin/env bash
set -euo pipefail

GIT_USER_NAME="${GIT_USER_NAME:-Piyush Jagadish Bag}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-piyushbag4@gmail.com}"

export GIT_COMMITTER_NAME="$GIT_USER_NAME"
export GIT_COMMITTER_EMAIL="$GIT_USER_EMAIL"

exec git -c commit.gpgsign=false commit --no-verify \
  --author="$GIT_USER_NAME <$GIT_USER_EMAIL>" \
  "$@"
