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

mkdir -p "$HOME/.config/fish"

SAFE_ENV_LINE='[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"'
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
