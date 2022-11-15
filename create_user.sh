#!/bin/bash

set -eux -o pipefail

# create_user.sh "gs8auftjq2r2rkmqosma8jptl" "us-east-1_JGJmTDqQH" "api-admin" "Api0-admin"

#assign credentials to variables
CLIENT_ID="${1}" #<put your client id here>
USER_POOL_ID="${2}" #<put your user pool id here>
USERNAME="${3}" #<put a username>
PASSWORD="${4}" #<put a password>

#sign-up user:
aws cognito-idp sign-up \
 --client-id ${CLIENT_ID} \
 --username ${USERNAME} \
 --password ${PASSWORD}

#confirm user:
aws cognito-idp admin-confirm-sign-up  \
  --user-pool-id ${USER_POOL_ID} \
  --username ${USERNAME}