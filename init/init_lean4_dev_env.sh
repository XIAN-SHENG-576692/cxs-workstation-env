#!/bin/sh

# ==================================================
# Configuration
SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
REPO_SCRIPTS_DIR="${REPO_ROOT_DIR}/scripts"

# ==================================================
# Install packages
PACKAGES=""

# Fix 
# - curl: (77) error setting certificate file
# - fatal: unable to access 'https://example.com': Problem with the SSL CA cert (path? access rights?)
PACKAGES="
${PACKAGES}
ca-certificates
"

# For fetch https://elan.lean-lang.org/elan-init.sh
PACKAGES="
${PACKAGES}
curl
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"

# ==================================================
# Install elan
curl \
    --proto '=https' \
    --tlsv1.2 https://elan.lean-lang.org/elan-init.sh \
    -sSf \
    | sh -s -- -y

# ==================================================
# Export environment variables
. "${REPO_SCRIPTS_DIR}/export_elan.env.sh"
