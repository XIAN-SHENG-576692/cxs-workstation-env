#!/bin/sh

set -euo pipefail

# ==================================================
REQUIRED_CMDS="
curl
"

usage() {
    cat << EOF
Usage: ${0##*/} -p <INSTALL_PATH> [OPTION]...

Purpose:
    This script install Typstyle.

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
# Get latest version
LATEST_VERSION=$( \
    curl -s https://api.github.com/repos/typstyle-rs/typstyle/releases/latest \
    | grep -oP '"tag_name": "\K[^"]*' \
)

# Get host ISA
ISA=$(uname -m)

# Download Typstyle release zip file
curl \
    -L \
    -o "${INSTALL_PATH}/typstyle" \
    "https://github.com/typstyle-rs/typstyle/releases/download/${LATEST_VERSION}/typstyle-${ISA}-unknown-linux-musl"

chmod +x "${INSTALL_PATH}/typstyle"

# ==================================================
cat << EOF
Typstyle installation complete.
Path: ${INSTALL_PATH}
EOF
