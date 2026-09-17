#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
janisdd.vscode-edit-csv
mechatroner.rainbow-csv
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
