#!/bin/sh

# ==================================================
# Install packages
PACKAGES="
biber
curl
ghostscript
git
latexmk
libfile-homedir-perl
libyaml-tiny-perl
make
perl
tex-fmt
texlive-extra-utils
texlive-full
"

"${REPO_SCRIPTS_DIR}/install_packages_cross_platform.sh" \
	"${PACKAGES}"
