#!/bin/bash

set -eux -o pipefail

URL="${1}" # 'https://api-dev.cabd.link/titles'
TOKEN="${2}"

# POST:
 curl -XPOST "$URL" \
 -d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"},{"text": "mushoku1","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
 -H 'Content-Type: application/json' -H "Authorization:${TOKEN}"