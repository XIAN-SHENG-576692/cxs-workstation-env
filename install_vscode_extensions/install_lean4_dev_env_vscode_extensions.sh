#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
leanprover.lean4
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
