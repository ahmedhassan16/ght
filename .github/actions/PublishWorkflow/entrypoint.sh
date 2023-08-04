#!/bin/sh

set -e
set -x

if [ -z "$source_files_pattern" ]
then
  echo "Source file pattern can not be empty"
  return 1
fi

if [ -z "$destination_repo" ]
then
  echo "Destination repository can not be empty"
  return 1
fi

if [ -z "$commit_message" ]
then
  echo "Commit message can not be empty"
  return 1
fi

if [ -z "$destination_branch" ]
then
  destination_branch="workflows/$GITHUB_SHA"
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

WORKING_DIR=$(pwd)
cd "$CLONE_DIR"

echo "Ensure destination branch: ${destination_branch}"
git -C ${adjSandboxPath} fetch --all
if git rev-parse --verify "$destination_branch" >/dev/null 2>&1; then
    echo "Branch '$destination_branch' exists."
    git checkout -b "$destination_branch"
else
    echo "Branch '$destination_branch' does not exist."
    echo "Creating new branch: ${destination_branch}"
    git checkout -b "$destination_branch"
fi

cd "$WORKING_DIR"
echo "Copying file pattern to git repo"
mkdir -p "$CLONE_DIR/.github/workflows"
cp "$source_files_pattern" "$CLONE_DIR/.github/workflows"

echo "Adding git commit"
cd "$CLONE_DIR"
git add .
git add -u
if git status | grep -q "Changes to be committed"
then
  git commit --message "$commit_message"
  echo "Pushing git commit"
  git push -u origin HEAD:"$destination_branch"
else
  echo "No changes detected"
fi