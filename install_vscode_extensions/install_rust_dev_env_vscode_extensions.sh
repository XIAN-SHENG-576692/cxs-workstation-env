#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
fill-labs.dependi
rust-lang.rust-analyzer
tamasfe.even-better-toml
vadimcn.vscode-lldb
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
