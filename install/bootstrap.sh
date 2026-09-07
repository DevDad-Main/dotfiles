#!/usr/bin/env bash
#
#  bootstrap.sh — one-liner installer for oliverm's dotfiles.
#
#  Run from anywhere (fresh machine, no repo needed):
#
#      curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash
#
#  Pass any installer flags / modes through:
#
#      curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash -s -- update
#      curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash -s -- --dry-run
#
#  It clones the repo to ~/.config/dotfiles (if missing) and hands off to the
#  real installer, forwarding every argument.
#

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/DevDad-Main/dotfiles.git}"
DEST="${DOTFILES_DIR:-$HOME/.config/dotfiles}"

# Use existing clone if present; otherwise clone fresh.
if [ ! -f "$DEST/install/install.sh" ]; then
    if [ -e "$DEST" ] && [ ! -d "$DEST/.git" ]; then
        echo "✗ $DEST exists but isn't the dotfiles repo (and has no installer)." >&2
        echo "  Move it aside or set DOTFILES_DIR to another location, then retry." >&2
        exit 1
    fi
    echo "→ Cloning dotfiles into $DEST …"
    mkdir -p "$(dirname "$DEST")"
    git clone --depth 1 "$REPO_URL" "$DEST" || {
        echo "✗ Clone failed. Check git/network and try again." >&2
        exit 1
    }
fi

exec bash "$DEST/install/install.sh" "$@"