#!/bin/sh

# ==================================================
# Install packages
PACKAGES="
build-essential
clang
clang-format
clang-tidy
cmake
gdb
libclang-dev
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"
