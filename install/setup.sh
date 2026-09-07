#!/usr/bin/env bash
# setup.sh — structure, symlinks, generation, and post-install steps.
# Sourced by install.sh. Depends on ui.sh + packages.sh being loaded.

# Where this dotfiles repo lives
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.config/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ─────────────────────────────────────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────────────────────────────────────
backup_path() {
    # Move an existing (non-symlink, non-dotfiles) path aside before we symlink
    # over it. Skips anything that already points into the dotfiles repo.
    local target="$1"
    [ -L "$target" ] && return 0
    [ -e "$target" ] || return 0
    [ "$(readlink -f "$target" 2>/dev/null || true)" = "$(readlink -f "$DOTFILES_DIR" 2>/dev/null || true)" ] && return 0
    local rel
    rel="$(realpath --relative-to="$HOME" "$target" 2>/dev/null)" || rel="$(basename "$target")"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    if mv "$target" "$BACKUP_DIR/$rel" 2>/dev/null; then
        warn "Moved existing $target → $BACKUP_DIR/$rel"
    fi
}

# safe_link <source> <dest>  — backs up dest, then creates the symlink
safe_link() {
    local src="$(realpath "$1" 2>/dev/null || echo "$1")"
    local dest="$2"
    local parent
    parent="$(dirname "$dest")"
    mkdir -p "$parent"
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        status "symlink ok: $dest"
        return 0
    fi
    # Back up a real file/dir we'd be replacing
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        backup_path "$dest"
    fi
    ln -sfnT "$src" "$dest" 2>/dev/null || return 1
    ok "linked $dest → $src"
}

is_installed() { command -v "$1" >/dev/null 2>&1; }

# ─────────────────────────────────────────────────────────────────────────────
# 1. Create the symlink map, then apply it
# ─────────────────────────────────────────────────────────────────────────────
setup_symlinks() {
    local links=(
        # app          source dir                          dest dir
        "cascade-menu|$DOTFILES_DIR/cascade-menu|$HOME/.config/cascade-menu"
        "dunst|$DOTFILES_DIR/dunst|$HOME/.config/dunst"
        "fastfetch|$DOTFILES_DIR/fastfetch|$HOME/.config/fastfetch"
        "hypr|$DOTFILES_DIR/hypr|$HOME/.config/hypr"
        "i3|$DOTFILES_DIR/i3|$HOME/.config/i3"
        "i3status-rust|$DOTFILES_DIR/i3status-rust|$HOME/.config/i3status-rust"
        "kitty|$DOTFILES_DIR/kitty|$HOME/.config/kitty"
        "nvim|$DOTFILES_DIR/nvim|$HOME/.config/nvim"
        "picom|$DOTFILES_DIR/picom|$HOME/.config/picom"
        "qutebrowser|$DOTFILES_DIR/qutebrowser|$HOME/.config/qutebrowser"
        "rofi|$DOTFILES_DIR/rofi|$HOME/.config/rofi"
        "starship|$DOTFILES_DIR/starship|$HOME/.config/starship"
        "tmux|$DOTFILES_DIR/tmux|$HOME/.config/tmux"
        "yazi|$DOTFILES_DIR/yazi|$HOME/.config/yazi"
        "zed|$DOTFILES_DIR/zed|$HOME/.config/zed"
        "zen|$DOTFILES_DIR/zen|$HOME/.config/zen"
        "dadmacs|$DOTFILES_DIR/dadmacs|$HOME/.config/dadmacs"
        "doom|$DOTFILES_DIR/.doom.d|$HOME/.doom.d"
        "doom-v3|$DOTFILES_DIR/.doom.d|$HOME/.config/doom"
        "zshrc|$DOTFILES_DIR/.zshrc|$HOME/.zshrc"
    )
    local entry name src dest
    section "Linking configuration"
    for entry in "${links[@]}"; do
        IFS='|' read -r name src dest <<< "$entry"
        if [ ! -e "$src" ]; then
            status "skip $name (no source $src)"
            continue
        fi
        safe_link "$src" "$dest"
    done
    # cascade-menu needs its binary on PATH (the .zshrc adds ~/.local/bin)
    mkdir -p "$HOME/.local/bin"
    ln -sfn "$DOTFILES_DIR/cascade-menu/cascade-menu" "$HOME/.local/bin/cascade-menu" 2>/dev/null || true
}

# ─────────────────────────────────────────────────────────────────────────────
# 2. Oh My Zsh + plugins
# ─────────────────────────────────────────────────────────────────────────────
setup_zsh() {
    [ "$INSTALL_ZSH" = "1" ] || return 0
    section "Zsh / Oh My Zsh"
    if [ -d "$HOME/.oh-my-zsh" ]; then
        ok "Oh My Zsh already installed"
    else
        if confirm "Install Oh My Zsh?" "y"; then
            info "Downloading Oh My Zsh…"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        else
            return 1
        fi
    fi

    # Plugins
    mkdir -p "$ZSH_CUSTOM/plugins"
    local plugins=(
        "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
        "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
        "fast-syntax-highlighting|https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
        "fzf-tab|https://github.com/Aloxaf/fzf-tab.git"
    )
    local name url
    for plugin in "${plugins[@]}"; do
        IFS='|' read -r name url <<< "$plugin"
        if [ -d "$ZSH_CUSTOM/plugins/$name" ]; then
            ok "$name already installed"
        else
            status "cloning $name…"
            git clone --depth 1 "$url" "$ZSH_CUSTOM/plugins/$name" >/dev/null 2>&1 && ok "installed $name"
        fi
    done

    # Set zsh as the default shell
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        if is_installed chsh && [ ! "$(command -v zsh)" = "" ]; then
            warn "Setting default shell to zsh (may prompt for password)"
            chsh -s "$(command -v zsh)"
        fi
    else
        ok "zsh is already the default shell"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 3. TMUX + TPM
# ─────────────────────────────────────────────────────────────────────────────
setup_tmux() {
    [ "$INSTALL_TMUX" = "1" ] || return 0
    section "Tmux + TPM"
    mkdir -p "$HOME/.tmux/plugins"
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        ok "TPM already installed"
    else
        info "Cloning Tmux Plugin Manager…"
        git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" >/dev/null 2>&1 && ok "TPM installed"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 4. Neovim bootstrap — lazy.nvim fetch plugins on first open
# ─────────────────────────────────────────────────────────────────────────────
setup_nvim() {
    [ "$INSTALL_NVIM" = "1" ] || return 0
    section "Neovim"
    if [ -d "$HOME/.local/share/nvim/lazy" ]; then
        ok "lazy.nvim plugins already installed"
    else
        info "First run of nvim will fetch all plugins. Do this now?"
        if confirm "Run a headless nvim :Lazy sync?" "y"; then
            nvim --headless "+Lazy! sync" +qa 2>&1 | tail -5
            ok "lazy.nvim synced"
        fi
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 5. Doom Emacs
# ─────────────────────────────────────────────────────────────────────────────
setup_doom() {
    [ "$INSTALL_DOOM" = "1" ] || return 0
    section "Doom Emacs"
    local emacs_bin
    emacs_bin="$(command -v emacs)"
    if [ -z "$emacs_bin" ]; then
        warn "emacs not installed — skipping Doom"
        return 0
    fi
    # Point Doom at our config (the symlinked ~/.config/doom → dotfiles/.doom.d)
    export DOOMDIR="$HOME/.config/doom"

    if [ -d "$HOME/.config/emacs/.git" ] && [ -f "$HOME/.config/emacs/bin/doom" ]; then
        ok "Doom already installed"
        if confirm "Run doom sync to apply these configs?" "y"; then
            "$HOME/.config/emacs/bin/doom" sync
        fi
        return 0
    fi
    info "Installing Doom Emacs (deps: git, ripgrep, fd, emacs)"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs" >/dev/null 2>&1
    if [ -d "$HOME/.config/doom" ]; then
        "$HOME/.config/emacs/bin/doom" install
    else
        warn "Doom config dir missing — run  doom install  manually."
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 6. rider2emacs (cargo) + CSharpier (.NET tools)
# ─────────────────────────────────────────────────────────────────────────────
setup_rider2emacs() {
    [ "$INSTALL_RIDER2EMACS" = "1" ] || return 0
    section "rider2emacs (cargo)"
    if is_installed cargo; then
        info "cargo install rider2emacs (patched fork)…"
        (cd "$DOTFILES_DIR/rider2emacs" && cargo install --path . --force) >/dev/null 2>&1 && ok "rider2emacs installed"
    else
        warn "rust/cargo not installed — skipping"
    fi
}

setup_dotnet_tools() {
    [ "$INSTALL_DOTNET" = "1" ] || return 0
    section ".NET global tools"
    if is_installed dotnet; then
        info "Installing CSharpier…"
        dotnet tool install -g csharpier 2>&1 | tail -2
    else
        warn ".NET not installed — skipping"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 7. NVM
# ─────────────────────────────────────────────────────────────────────────────
setup_nvm() {
    [ "$INSTALL_NVM" = "1" ] || return 0
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        ok "NVM already installed"
        return 0
    fi
    section "NVM (Node Version Manager)"
    info "Installing NVM…"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

# ─────────────────────────────────────────────────────────────────────────────
# 8. Config generation (i3/generate.sh) + final refresh
# ─────────────────────────────────────────────────────────────────────────────
run_generate() {
    section "Generating configs (i3 / i3status-rust / rofi / dunst / picom / kitty / emacs)"
    if [ -x "$DOTFILES_DIR/i3/generate.sh" ]; then
        bash "$DOTFILES_DIR/i3/generate.sh" && ok "configs generated"
    else
        err "generate.sh not found — is the repo cloned correctly?"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 9. Enable services
# ─────────────────────────────────────────────────────────────────────────────
enable_services() {
    section "Enabling system services"
    local services=(
        "NetworkManager"
        "gpu-screen-recorder@user"  # user socket, harmless if missing
    )
    # Only run if systemd is present
    if pidof systemd >/dev/null 2>&1; then
        if confirm "Enable NetworkManager + iwd for impala WiFi?" "y"; then
            sudo systemctl enable --now NetworkManager 2>/dev/null || true
            sudo systemctl enable --now iwd 2>/dev/null || true
            # Point NetworkManager at the iwd backend so impala works
            printf '[device]\nwifi.backend=iwd\n' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null
            sudo systemctl disable --now wpa_supplicant 2>/dev/null || true
            sudo systemctl restart NetworkManager 2>/dev/null || true
            ok "NetworkManager + iwd configured"
        fi
    else
        warn "systemd not running — skipping service setup"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# 10. Summary / final message
# ─────────────────────────────────────────────────────────────────────────────
print_summary() {
    section "All done"
    ok "Your dotfiles are set up."
    printf '\n'
    printf '  %s %s\n' "$(green '→')" "$(bold 'Next steps:')"
    printf '    %s %s\n' "$(grey '·')" "Log out and back in (or start a new shell) for zsh changes."
    printf '    %s %s\n' "$(grey '·')" "${EDITOR:-nvim} opened once to install Neovim plugins."
    printf '    %s %s\n' "$(grey '·')" "Run  ~/.config/dotfiles/install/install.sh update  after writing new machine config."
    printf '    %s %s\n' "$(grey '·')" "If you installed the i3 desktop: start it with  startx  or select it in your DM."
    printf '\n'
    if [ -d "$BACKUP_DIR" ]; then
        printf '  %s %s\n' "$(yellow '→')" "$(bold 'Backed up:') $BACKUP_DIR"
    fi
}