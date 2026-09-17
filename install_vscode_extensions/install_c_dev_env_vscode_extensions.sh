#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
ms-vscode.cpptools
ms-vscode.cpptools-extension-pack
ms-vscode.cmake-tools
ms-vscode.makefile-tools
formulahendry.code-runner
usernamehw.errorlens
cschlosser.doxdocgen
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
