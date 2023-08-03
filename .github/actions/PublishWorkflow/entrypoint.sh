
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

if [ -z "$destination_branch" ]
then
  echo "Destination branch can not be empty"
  return 1
fi

if [ -z "$commit_message" ]
then
  echo "Commit message can not be empty"
  return 1
fi

if [ -z "$user_email" ]
then
  user_email=$(git log -1 --pretty=format:'%ae')
fi

if [ -z "$user_name" ]
then
  user_name=$(git log -1 --pretty=format:'%an')
fi

echo "$source_files_pattern"
echo "$destination_repo"
echo "$destination_branch"
echo "$commit_message"
echo "$user_email"
echo "$user_name"
# echo "Cloning destination git repository"
# git config --global user.email "$INPUT_USER_EMAIL"
# git config --global user.name "$INPUT_USER_NAME"
# git clone --single-branch --branch $INPUT_DESTINATION_BRANCH "https://x-access-token:$API_TOKEN_GITHUB@$INPUT_GIT_SERVER/$INPUT_DESTINATION_REPO.git" "$CLONE_DIR"

# if [ ! -z "$INPUT_RENAME" ]
# then
#   echo "Setting new filename: ${INPUT_RENAME}"
#   DEST_COPY="$CLONE_DIR/$INPUT_DESTINATION_FOLDER/$INPUT_RENAME"
# else
#   DEST_COPY="$CLONE_DIR/$INPUT_DESTINATION_FOLDER"
# fi

# echo "Copying contents to git repo"
# mkdir -p $CLONE_DIR/$INPUT_DESTINATION_FOLDER
# if [ -z "$INPUT_USE_RSYNC" ]
# then
#   cp -R "$INPUT_SOURCE_FILE" "$DEST_COPY"
# else
#   echo "rsync mode detected"
#   rsync -avrh "$INPUT_SOURCE_FILE" "$DEST_COPY"
# fi

# cd "$CLONE_DIR"

# if [ ! -z "$INPUT_DESTINATION_BRANCH_CREATE" ]
# then
#   echo "Creating new branch: ${INPUT_DESTINATION_BRANCH_CREATE}"
#   git checkout -b "$INPUT_DESTINATION_BRANCH_CREATE"
#   OUTPUT_BRANCH="$INPUT_DESTINATION_BRANCH_CREATE"
# fi

# if [ -z "$INPUT_COMMIT_MESSAGE" ]
# then
#   INPUT_COMMIT_MESSAGE="Update from https://$INPUT_GIT_SERVER/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}"
# fi

# echo "Adding git commit"
# git add .
# if git status | grep -q "Changes to be committed"
# then
#   git commit --message "$INPUT_COMMIT_MESSAGE"
#   echo "Pushing git commit"
#   git push -u origin HEAD:"$OUTPUT_BRANCH"
# else
#   echo "No changes detected"
# fi