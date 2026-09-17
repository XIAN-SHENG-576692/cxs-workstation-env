#!/bin/sh

# ==================================================
# Installation
EXTENSIONS=""

EXTENSIONS="
${EXTENSIONS}
eamodio.gitlens
"

# GitHub actions support
EXTENSIONS="
${EXTENSIONS}
github.vscode-github-actions
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
