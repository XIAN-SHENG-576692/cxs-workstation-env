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

mkdir -p "$HOME/.config/fish"

SAFE_ENV_LINE='[ -f "$HOME/.local/codex.env" ] && . "$HOME/.local/codex.env"'
eval "$SAFE_ENV_LINE"
if ! grep -qF "$SAFE_ENV_LINE" ~/.bashrc; then
    echo "$SAFE_ENV_LINE" >> ~/.bashrc
fi
if ! grep -qF "$SAFE_ENV_LINE" ~/.zshrc; then
    echo "$SAFE_ENV_LINE" >> ~/.zshrc
fi
if ! grep -qF "$SAFE_ENV_LINE" ~/.config/fish/config.fish; then
    echo "$SAFE_ENV_LINE" >> ~/.config/fish/config.fish
fi
