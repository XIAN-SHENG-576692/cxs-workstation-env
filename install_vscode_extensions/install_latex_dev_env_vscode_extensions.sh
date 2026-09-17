#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
james-yu.latex-workshop
mathematic.vscode-latex
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
