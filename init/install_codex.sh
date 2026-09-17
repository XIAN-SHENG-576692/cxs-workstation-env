#!/bin/sh

# ==================================================
# Configuration
SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
REPO_SCRIPTS_DIR="${REPO_ROOT_DIR}/scripts"

# ==================================================
# Install packages
PACKAGES="
curl
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"

# ==================================================
# Install codex
export CODEX_NON_INTERACTIVE=true
curl -fsSL https://chatgpt.com/codex/install.sh | sh

# ==================================================
# Export environment variables
. "${REPO_SCRIPTS_DIR}/export_codex.env.sh"
