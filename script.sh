#!/bin/bash
set -e
TOKEN1=""
response=$(curl -X 'GET' 'https://api.digitalocean.com/v2/account/keys?page=1&per_page=200' -H 'accept: application/json' -H "Authorization: Bearer $TOKEN1" | jq -r '.ssh_keys[] | select(.name == "REBRAIN.SSH.PUB.KEY") | .id')

echo '{ "id": "'${response}'" }'
