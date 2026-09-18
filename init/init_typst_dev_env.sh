#!/bin/sh

# ==================================================
usage() {
    cat << EOF
Usage: ${0##*/} -p <INSTALL_PATH> [OPTION]...

Purpose:
    This script install Typst and Typstyle.

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
# Configuration
SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
REPO_SCRIPTS_DIR="${REPO_ROOT_DIR}/scripts"

# ==================================================
# Install packages
PACKAGES=""

PACKAGES="
${PACKAGES}
curl
tar
"

# xz
PACKAGES="
${PACKAGES}
xz
xz-utils
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"

# ==================================================
# Install typst and typstyle
OLD_ARGS="$@"
set -- -p "${INSTALL_PATH}"
. "${REPO_SCRIPTS_DIR}/install_typst.sh"
set -- -p "${INSTALL_PATH}"
. "${REPO_SCRIPTS_DIR}/install_typstyle.sh"
eval "set -- $OLD_ARGS"
