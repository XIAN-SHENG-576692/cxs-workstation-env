#!/bin/sh

REQUIRED_CMDS="
dart
find
"

# Usage help function
usage() {
    cat << EOF
Usage: ${0##*/} <directory>
    Run the following commands in all subdirectories under <directory>.
    - cd <subdirectory>
    - dart run build_runner clean
    - dart run build_runner build

Prerequisites:
$(printf '    - %s\n' ${REQUIRED_CMDS})
EOF
    exit 1
}

for cmd in $REQUIRED_CMDS; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: required command '$cmd' not found." >&2
        usage
    fi
done

if [ "$#" -ne 1 ]; then
    usage
fi

# Configuration
INPUT_DIR=$1

cd "${INPUT_DIR}" || {
    echo "Error: Unable to access ${INPUT_DIR}"
    exit 1
}

for dir in $(find ${PWD} -type d -name "pubspec.yaml"); do
    cd "${dir}/.." \
    && dart run build_runner clean \
    && dart run build_runner build
done
