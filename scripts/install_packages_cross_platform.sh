#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 [Package_1 Package_2 ...]"
    exit 1
fi

PACKAGES=$@

if [ -x "$(command -v apt-get)" ]; then
    echo "System: Debian/Ubuntu series"
    export DEBIAN_FRONTEND=noninteractive
    
    apt-get update
    
    # Pre-filter valid packages locally using apt-cache for bulk installation
    VALID_PKGS=""
    for pkg in $PACKAGES; do
        if apt-cache show "$pkg" >/dev/null 2>&1; then
            VALID_PKGS="$VALID_PKGS $pkg"
        else
            echo "Warning: Package '$pkg' not found, skipping."
        fi
    done

    if [ -n "$VALID_PKGS" ]; then
        apt-get install -y --no-install-recommends $VALID_PKGS
    fi
    
    # Cleanup: remove cache and temporary lists to save space
    apt-get clean
    rm -rf /var/lib/apt/lists/*

elif [ -x "$(command -v apk)" ]; then
    echo "System: Alpine series"
    
    # Pre-filter valid packages locally before installing
    VALID_PKGS=""
    for pkg in $PACKAGES; do
        if apk info -e "$pkg" >/dev/null 2>&1 || apk search -e "$pkg" | grep -q "^$pkg$"; then
            VALID_PKGS="$VALID_PKGS $pkg"
        else
            echo "Warning: Package '$pkg' not found, skipping."
        fi
    done

    if [ -n "$VALID_PKGS" ]; then
        apk add --no-cache $VALID_PKGS
    fi

elif [ -x "$(command -v dnf)" ]; then
    echo "System: RHEL/Fedora series (dnf)"
    # Allow dnf to skip missing packages using --setopt=strict=0
    dnf install -y --setopt=strict=0 $PACKAGES
    dnf clean all

elif [ -x "$(command -v yum)" ]; then
    echo "System: RHEL/CentOS series (yum)"
    # Allow yum to skip missing packages using --setopt=strict=0
    yum install -y --setopt=strict=0 $PACKAGES
    yum clean all

else
    echo "Error: Unsupported package manager"
    exit 1
fi
