#!/usr/bin/env bash

# This script fetches a JWT from the HawklingAPI app using the test username and password.

USERNAME=admin
PASSWORD=adminpassword
URL=http://localhost:8000/login/

response=$(curl --silent --location --request POST "${URL}" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"username\": \"${USERNAME}\",
    \"password\": \"${PASSWORD}\"
  }")

echo "${response}" | jq .access -r
