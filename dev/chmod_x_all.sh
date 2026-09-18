#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)

find "${REPO_ROOT_DIR}" -type f -name "*.sh" -exec chmod +x {} +
