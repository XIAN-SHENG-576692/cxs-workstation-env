#!/bin/sh

# ==================================================
# Installation
EXTENSIONS="
github.copilot-chat
openai.chatgpt
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
