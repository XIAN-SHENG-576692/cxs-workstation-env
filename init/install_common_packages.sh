#!/bin/sh

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
