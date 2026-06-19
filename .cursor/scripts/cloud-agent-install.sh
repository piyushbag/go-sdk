#!/usr/bin/env bash
set -euo pipefail

GIT_USER_NAME="${GIT_USER_NAME:-Piyush Jagadish Bag}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-piyushbag4@gmail.com}"

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global commit.gpgsign false

if [ -n "${CURSOR_GH_PAT:-}" ]; then
  echo "$CURSOR_GH_PAT" | gh auth login --with-token
fi

if command -v go >/dev/null 2>&1; then
  go mod download
fi

echo "Cloud agent git identity: $GIT_USER_NAME <$GIT_USER_EMAIL>"
if gh auth status >/dev/null 2>&1; then
  gh auth status
else
  echo "Tip: add CURSOR_GH_PAT in the Cloud Agents dashboard for gh pr/issue access."
fi
