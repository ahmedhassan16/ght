#!/bin/sh

if [ -z "$destination_repo" ]
then
  echo "Destination repository can not be empty"
  return 1
fi

if [ -z "$destination_branch" ]
then
  destination_branch="workflows/$GITHUB_SHA/$GITHUB_RUN_ID"
fi

if [ -z "$user_email" ]
then
  user_email=$(git log -1 --pretty=format:'%ae')
fi

if [ -z "$user_name" ]
then
  user_name=$(git log -1 --pretty=format:'%an')
fi

if [ -z "$api_token" ]
then
  api_token="$API_TOKEN_GITHUB"
fi

echo "Cloning destination git repository"
git config --global user.email "$user_email"
git config --global user.name "$user_name"

CLONE_DIR=$(mktemp -d)
git clone --single-branch "https://x-access-token:$api_token@github.com/$destination_repo.git" "$CLONE_DIR"

cd "$CLONE_DIR"
git push origin --delete "$destination_branch"