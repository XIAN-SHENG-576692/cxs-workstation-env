#!/bin/sh

# ==================================================
# Installation
EXTENSIONS=""

# Dart language support
EXTENSIONS="
${EXTENSIONS}
Dart-Code.dart-code
"

# Flutter support
EXTENSIONS="
${EXTENSIONS}
Dart-Code.flutter
"

# Gradle support for Android projects
EXTENSIONS="
${EXTENSIONS}
vscjava.vscode-gradle
"

for extension in $EXTENSIONS; do
    code --install-extension $extension
done
