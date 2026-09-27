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
PACKAGES=$(find "${SCRIPT_DIR}" -maxdepth 1 -type f -name "init_c_dev_env_packages_*.txt" -exec grep -hEv '^#|^$' {} + | xargs)

# --------------------------------------------------
"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
    "${PACKAGES}"

# ==================================================
# Install opam packages
opam init -a -y --disable-sandboxing
eval $(opam env)

opam switch create ocaml-base-compiler

# Install Frama-C
# Prerequisites:
# - autoconf
# - graphviz
# - pkgconf / pkg-config / pkgconf-pkg-config
# - zlib / zlib1g-dev / zlib-devel
opam install frama-c -y --assume-depexts
