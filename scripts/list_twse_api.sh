#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

API_BASE_URL="https://openapi.twse.com.tw/v1"
REQUIRED_CMDS="
bash
curl
jq
xargs
"

# Usage help function
usage() {
    cat << EOF
Usage: ${0##*/}
    List tpex API with ${API_BASE_URL}

Prerequisites:
$(printf '    - %s\n' ${REQUIRED_CMDS})
EOF
    exit 1
}

for cmd in $REQUIRED_CMDS; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: required command '$cmd' not found." >&2
        usage
    fi
done

API_ROUTE_ARRAY=$(curl https://openapi.twse.com.tw/v1/swagger.json \
    | jq -r '.paths | keys[]')

printf "%s\n" "${API_ROUTE_ARRAY[@]}" \
    | xargs -I {} echo "${API_BASE_URL}{}"
