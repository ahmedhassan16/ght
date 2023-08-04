#!/bin/sh

if [ -z "$webhook_url" ]
then
  echo "Webhook url can not be empty"
  return 1
fi

if [ -z "$webhook_secret" ]
then
  echo "Webhook secret can not be empty"
  return 1
fi

curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $webhook_secret"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  $webhook_url