#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
myriad-dreamin.tinymist
tomoki1207.pdf
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
