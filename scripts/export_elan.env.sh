#!/bin/sh

mkdir -p "$HOME/.elan"

cat << EOF > "$HOME/.elan/ld-library-path.env"
#!/bin/sh
# Dynamically locate the active Lean toolchain's lib directory
if command -v lean &> /dev/null; then
    LIB="\$(lean --print-prefix)/lib"
    case ":\${LD_LIBRARY_PATH}:" in
        *:"\${LIB}":*)
            ;;
        *)
            export LD_LIBRARY_PATH="\${LIB}:\${LD_LIBRARY_PATH}"
            ;;
    esac
fi
EOF

# ==================================================
# Write Shell Configuration Files
mkdir -p "$HOME/.config/fish"

CONFIG_FILES="
$HOME/.bashrc
$HOME/.zshrc
$HOME/.config/fish/config.fish
"

SAFE_ENV_LINE='[ -f "$HOME/.elan/env" ] && . "$HOME/.elan/env"'
eval "$SAFE_ENV_LINE"

for file in $CONFIG_FILES; do
    if [ ! -f "$file" ] || ! grep -qF "$SAFE_ENV_LINE" "$file"; then
        echo "$SAFE_ENV_LINE" >> "$file"
    fi
done

SAFE_ENV_LINE='[ -f "$HOME/.elan/ld-library-path.env" ] && . "$HOME/.elan/ld-library-path.env"'
eval "$SAFE_ENV_LINE"

for file in $CONFIG_FILES; do
    if [ ! -f "$file" ] || ! grep -qF "$SAFE_ENV_LINE" "$file"; then
        echo "$SAFE_ENV_LINE" >> "$file"
    fi
done
