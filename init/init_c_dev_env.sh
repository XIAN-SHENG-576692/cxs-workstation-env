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

# common
PACKAGES="
${PACKAGES}
autoconf
build-essential
clang
clang-format
clang-tidy
cmake
gcc
gdb
graphviz
libclang-dev
make
opam
"

# gmp
PACKAGES="
${PACKAGES}
gmp
gmp-devel
libgmp-dev
"

# pkgconf
PACKAGES="
${PACKAGES}
pkg-config
pkgconf-pkg-config
"

# zlib
PACKAGES="
${PACKAGES}
zlib1g-dev
zlib-devel
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
    "${PACKAGES}"

# ==================================================
# Install opam packages
opam init -a -y --disable-sandboxing
eval $(opam env)

opam switch create ocaml-base-compiler

# Install Frama-C
opam install frama-c -y --assume-depexts
