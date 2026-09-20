#!/bin/sh

mkdir -p "$HOME/.cargo"

cat << EOF > "$HOME/.cargo/env"
#!/bin/sh
# rustup shell setup
# affix colons on either side of \$PATH to simplify matching
case ":\${PATH}:" in
    *:"\$HOME/.cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="\$HOME/.cargo/bin:\$PATH"
        ;;
esac
EOF

# ==================================================
# Write Shell Configuration Files
mkdir -p "$HOME/.config/fish"

CONFIG_FILES="
$HOME/.bashrc
$HOME/.zshrc
$HOME/.config/fish/config.fish
"

SAFE_ENV_LINE='[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"'
eval "$SAFE_ENV_LINE"

for file in $CONFIG_FILES; do
    if [ ! -f "$file" ] || ! grep -qF "$SAFE_ENV_LINE" "$file"; then
        echo "$SAFE_ENV_LINE" >> "$file"
    fi
done
