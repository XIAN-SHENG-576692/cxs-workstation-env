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

mkdir -p "$HOME/.config/fish"

SAFE_ENV_LINE='[ -f "$HOME/.elan/env" ] && . "$HOME/.elan/env"'
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

SAFE_ENV_LINE='[ -f "$HOME/.elan/ld-library-path.env" ] && . "$HOME/.elan/ld-library-path.env"'
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
