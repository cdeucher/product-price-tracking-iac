#!/bin/bash

set -eux -o pipefail

# get_token.sh "gs8auftjq2r2rkmqosma8jptl" "api-admin1" "Api0-admin"

#assign credentials to variables
CLIENT_ID="${1}" #<put your client id here>
USERNAME="${2}" #<put a username>
PASSWORD="${3}" #<put a password>

#authenticate and get token
aws cognito-idp initiate-auth \
     --client-id ${CLIENT_ID} \
     --auth-flow USER_PASSWORD_AUTH \
     --auth-parameters USERNAME=${USERNAME},PASSWORD=${PASSWORD} \
     --query 'AuthenticationResult.IdToken' \
     --output text