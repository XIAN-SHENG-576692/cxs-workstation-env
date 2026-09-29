#!/bin/sh

set -euo pipefail

# ==================================================
REQUIRED_CMDS="
cmake
curl
"

usage() {
    cat << EOF
Usage: ${0##*/} -p <INSTALL_PATH> [OPTION]...

Purpose:
    This script install whisper.cpp

References:
    https://github.com/ggml-org/whisper.cpp#quick-start

Prerequisites:
$(printf '    - %s\n' ${REQUIRED_CMDS})

Parameters:
    -p, --path, --install-path
        The installation path (e.g., /usr/local/bin/)

Options:
    -h, --help
        Print help
EOF
    exit 1
}

for cmd in $REQUIRED_CMDS; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: required command '$cmd' not found." >&2
        usage
    fi
done

# ==================================================
# Configure parameters
if [ "$#" -eq 0 ]; then
    usage
fi

INSTALL_PATH=""

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -p|--path|--install-path)
            shift
            INSTALL_PATH=$(cd "$1"; pwd)
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Validate that inputs are not empty
if [ -z "${INSTALL_PATH}" ]; then
    echo "Error: The installation path are required."
    echo ""
    usage
fi

mkdir -p "${INSTALL_PATH}"

# ==================================================
# Install whisper.cpp
# 
# References
# - https://github.com/ggml-org/whisper.cpp#quick-start

# Navigate into the INSTALL_PATH
cd "${INSTALL_PATH}"

# First clone the repository
git clone --filter=tree:0 --depth=1 --no-tags \
https://github.com/ggml-org/whisper.cpp.git

# Navigate into the whisper.cpp directory
cd ./whisper.cpp

# build the project
cmake -B build
cmake --build build -j --config Release
