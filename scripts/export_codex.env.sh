#!/bin/sh

mkdir -p "$HOME/.local"

cat << EOF > "$HOME/.local/codex.env"
#!/bin/sh
# codex shell setup
# affix colons on either side of \$PATH to simplify matching
case ":\${PATH}:" in
    *:"\$HOME/.local/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="\$HOME/.local/bin:\$PATH"
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

SAFE_ENV_LINE='[ -f "$HOME/.local/codex.env" ] && . "$HOME/.local/codex.env"'
eval "$SAFE_ENV_LINE"

for file in $CONFIG_FILES; do
    if [ ! -f "$file" ] || ! grep -qF "$SAFE_ENV_LINE" "$file"; then
        echo "$SAFE_ENV_LINE" >> "$file"
    fi
done
