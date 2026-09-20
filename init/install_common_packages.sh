#!/bin/sh

# ==================================================
# SCRIPT_DIR
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# ==================================================
# Configuration
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
REPO_SCRIPTS_DIR="${REPO_ROOT_DIR}/scripts"

# ==================================================
# Install packages
PACKAGES=""

# GitHub
PACKAGES="
${PACKAGES}
git
gh
"

# Editors
PACKAGES="
${PACKAGES}
neovim
vim
"

# Others
PACKAGES="
${PACKAGES}
dos2unix
less
lsof
procps
psmisc
sudo
tree
unzip
util-linux
util-linux-extra
zip
"

# xz
PACKAGES="
${PACKAGES}
xz
xz-utils
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"
