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

if [ -z "$workflow_file" ]
then
   echo "Workflow file can not be empty"
  return 1
fi

if [ -z "$api_token" ]
then
  api_token="$API_TOKEN_GITHUB"
fi

curl \
-X POST \
-H "Accept: application/vnd.github.v3+json" \
-H "Authorization: token $api_token" \
"https://api.github.com/repos/$destination_repo/actions/workflows/$workflow_file/dispatches" \
-d '{"ref":"$destination_branch"}'

sleep 10

 workflow_run_id=$(curl -s -H "Authorization: token $api_token" \
  "https://api.github.com/repos/$destination_repo/actions/runs?branch=$destination_branch"  | jq -r '.workflow_runs[0].id')

# workflow_run_id=$(workflow_last_run_id)
# while [ $workflow_run_id -eq $workflow_last_run_id ]
# do
 
#   echo "Waiting workflow ..."
 
#   counter=$((counter + 1))  
# done

workflow_run_url="https://github.com/ahmedhassan16/artifacts/actions/runs/$workflow_run_id"
echo "URL of the most recent workflow run: $workflow_run_url"