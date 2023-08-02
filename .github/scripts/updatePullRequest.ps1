$url = "https://github.mathworks.com/api/v3"
$repo_owner = "ahmedh"
$repo_name = "testHistory"
$headers = @{
    # "Authorization": "Bearer MY_OAUTH_TOKEN",
    "Authorization"= "token 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"
    'Accept'= 'application/vnd.github+json'
}

# Get pull request number
$commit_hash = "1ef49e4c07c9aee3c7564a46c2b85157ccb3f81b"
$response = Invoke-WebRequest -Uri "$url/repos/$repo_owner/$repo_name/commits/$commit_hash/pulls" -Headers $headers
$PRNumber = (ConvertFrom-Json $response.Content).number[0]

$commentResponse = Invoke-WebRequest -Method Post -Uri "$url/repos/$repo_owner/$repo_name/issues/$PRNumber/comments" -Headers $headers `
                -Body '{"body":"![GitFlow](https://github.mathworks.com/storage/user/2830/files/14480597-724d-46f1-ad64-f16b0e1abb93)"}'
(ConvertFrom-Json $response.Content)[0]


curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  http(s)://HOSTNAME/api/v3/repos/OWNER/REPO/pulls/PULL_NUMBER/comments \
  -d '{"body":"Great stuff!","commit_id":"6dcb09b5b57875f334f61aebed695e2e4193db5e","path":"file1.txt","start_line":1,"start_side":"RIGHT","line":2,"side":"RIGHT"}'