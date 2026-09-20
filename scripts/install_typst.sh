#!/bin/sh

set -euo pipefail

# ==================================================
REQUIRED_CMDS="
curl
tar
xz
"

usage() {
    cat << EOF
Usage: ${0##*/} -p <INSTALL_PATH> [OPTION]...

Purpose:
    This script install Typst.

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
# Get latest version
LATEST_VERSION=$( \
    curl -s https://api.github.com/repos/typst/typst/releases/latest \
    | grep -oP '"tag_name": "\K[^"]*' \
)

# Get host ISA
ISA=$(uname -m)

# ==================================================
# TMP_DIR
# 1. Define the cleanup function
cleanup() {
    # Ensure TMP_DIR is set and the directory actually exists before removal
    if [ -n "${TMP_DIR:-}" ] && [ -d "${TMP_DIR}" ]; then
        echo "Clearing the temporary directory..."
        rm -rf "${TMP_DIR}"
        echo "Temporary directory cleanup completed."
    fi
}

# 2. Register trap for the EXIT signal
# Trapping EXIT ensures execution on normal exit, script errors, or system signals
trap cleanup EXIT

# 3. Safely create a temporary directory
TMP_DIR="$(mktemp -d)"
echo "Created temporary directory at: ${TMP_DIR}"

# ==================================================
cd "${TMP_DIR}"

# Download Typst release zip file
curl \
    -L \
    -o "typst.tar.xz" \
    "https://github.com/typst/typst/releases/download/${LATEST_VERSION}/typst-${ISA}-unknown-linux-musl.tar.xz"

# Extract Typst
tar \
    -xf "typst.tar.xz"

mv \
    "typst-${ISA}-unknown-linux-musl/typst" \
    "${INSTALL_PATH}"

# Clear temporary archives
rm \
    -rf "${TMP_DIR}"

# ==================================================
cat << EOF
Typst installation complete.
Path: ${INSTALL_PATH}
EOF
