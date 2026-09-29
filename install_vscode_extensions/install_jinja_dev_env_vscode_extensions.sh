#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
wholroyd.jinja
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
