#!/usr/bin/env bash
#
#  install.sh — beautiful, interactive installer for oliverm's dotfiles.
#
#  Fastest way (fresh machine, no repo needed):
#
#      curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash -s -- --help
#
#  Modes:
#    ./install/install.sh            → full first-time install (asks questions)
#    ./install/install.sh update     → git pull + regenerate configs only
#    ./install/install.sh --dry-run  → show what would happen, change nothing
#    ./install/install.sh --minimal  → install shell + editors only, no prompt
#
#  Requires: an Arch-based distro, sudo, and an internet connection.
#  Self-contained: uses only bash + awk + coreutils (no external CLI).
#

set -Eeuo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# Discover script location (works when invoked from anywhere / via symlink)
# ─────────────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPT_DIR
export DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# ─────────────────────────────────────────────────────────────────────────────
# Load libraries
# ─────────────────────────────────────────────────────────────────────────────
# shellcheck source=lib/ui.sh
. "$SCRIPT_DIR/lib/ui.sh"
# shellcheck source=packages.sh
. "$SCRIPT_DIR/packages.sh"
# shellcheck source=setup.sh
. "$SCRIPT_DIR/setup.sh"

# ─────────────────────────────────────────────────────────────────────────────
# Global switches
# ─────────────────────────────────────────────────────────────────────────────
DRY_RUN="${DRY_RUN:-0}"
MINIMAL="${MINIMAL:-0}"
INSTALL_AUR="${INSTALL_AUR:-1}"

SELECTED_GROUPS=()      # groups the user chose this run

# ─────────────────────────────────────────────────────────────────────────────
# AUR helper detection / install
# ─────────────────────────────────────────────────────────────────────────────
aur_helper() {
    if command -v yay >/dev/null 2>&1; then echo yay; return; fi
    if command -v paru >/dev/null 2>&1; then echo paru; return; fi
    echo ""
}

ensure_aur_helper() {
    if [ -n "$(aur_helper)" ]; then return 0; fi
    if ! command -v git >/dev/null 2>&1; then
        err "git not installed — can't build AUR helper."
        return 1
    fi
    if confirm "No AUR helper found (yay/paru). Install 'paru' now? (needed for several packages)" "y"; then
        status "Building paru (this can take a few minutes)…"
        local tmp
        tmp="$(mktemp -d)"
        git clone --depth 1 https://aur.archlinux.org/paru.git "$tmp/paru" >/dev/null 2>&1
        (cd "$tmp/paru" && makepkg -si --noconfirm) >/dev/null 2>&1
        rm -rf "$tmp"
        if command -v paru >/dev/null 2>&1; then ok "paru installed"; return 0; fi
        err "paru build failed — falling back to pacman-only."
        return 1
    fi
    warn "Skipping AUR helper — only official packages will be installed."
    return 1
}

# ─────────────────────────────────────────────────────────────────────────────
# Install a list of packages with a single live progress bar.
#   install_pac <group> <package...>
#
# pacman hides its animated progress when piped, but still prints
# "package (n/m) downloading" lines, which we use to drive the bar.
# If nothing parseable arrives we always finish at 100%.
# ─────────────────────────────────────────────────────────────────────────────
install_pac() {
    local group="$1"; shift
    [ "$#" -gt 0 ] || return 0
    local frac=0 n d rest rc=0

    info "Installing [$(bold "${GROUP_TITLES[$group]:-$group}")]: $*"

    # coproc lets us stream pacman's stdout *and* capture its real exit code.
    coproc PROG {
        set +e
        sudo pacman -S --noconfirm --needed "$@"
        # Sentinel carrying the real return code, so the pipe never masks it.
        printf '__RC__%s\n' "$?"
    }
    local prog_pid=$!

    while IFS= read -r line <&"${PROG[0]}"; do
        case "$line" in
            __RC__*) rc="${line#__RC__}"; break ;;
            \(*/*\))
                # Trim "(1/3)" -> n=1, d=3
                rest="$line"
                rest="${rest#*(}"
                n="${rest%%/*}"
                rest="${rest#*/}"
                d="${rest%)}"
                if [ "${d:-0}" -gt 0 ] 2>/dev/null; then
                    frac="$(awk -v n="$n" -v d="$d" 'BEGIN{ printf "%.3f", n/d }')"
                    progress "$frac" "$group"
                fi
                ;;
        esac
    done

    wait "$prog_pid" 2>/dev/null || true
    progress 1 "$group"
    progress_done

    if [ "$rc" -ne 0 ]; then
        err "pacman failed for group '$group' (exit $rc)."
        return 1
    fi
    ok "${GROUP_TITLES[$group]:-$group} installed."
}

# Install AUR packages via the detected helper
install_aur() {
    local group="$1"; shift
    [ "$#" -gt 0 ] || return 0
    local helper
    helper="$(aur_helper)"
    info "Installing [$(bold "${GROUP_TITLES[$group]:-$group}")] via ${helper}: $*"
    if [ "$helper" = "yay" ]; then
        yay -S --noconfirm --needed "$@" >/dev/null 2>&1 &
    else
        paru -S --noconfirm --needed "$@" >/dev/null 2>&1 &
    fi
    local pid=$!
    # Indeterminate pulse while the AUR helper builds.
    local f=0.0
    local dir=1
    while kill -0 "$pid" 2>/dev/null; do
        f="$(awk -v f="$f" -v dir="$dir" 'BEGIN{ f += 0.05*dir; if (f>=1){f=0.97; dir=-1} if (f<=0){f=0.03; dir=1} printf "%.3f", f }')"
        progress "$f" "AUR: $group"
        sleep 0.12
    done
    if wait "$pid"; then
        progress 1 "AUR: $group"
        progress_done
        ok "${GROUP_TITLES[$group]:-$group} (AUR) installed."
    else
        progress_done
        err "AUR install failed for group '$group'."
        return 1
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Question flow — choose component groups
# ─────────────────────────────────────────────────────────────────────────────
choose_groups() {
    local order=(core terminals editors filemgrs desktop wayland browsers media fonts utils devtools emacs gaming)
    echo
    sub "Components" "pick what you actually need — answer y/n for each group"
    echo
    local chosen=()
    local name def
    for name in "${order[@]}"; do
        def="${GROUP_DEFAULT[$name]}"
        printf '  %s %s %s\n' \
            "$(bold "$(purple '▸')")" \
            "$(bold "$(cyan "$name")")" \
            "$(grey "· ${GROUP_DESC[$name]}")"
        if confirm "${GROUP_TITLES[$name]}?" "$([ "$def" = "on" ] && echo y || echo n)"; then
            chosen+=("$name")
        fi
    done
    SELECTED_GROUPS=("${chosen[@]}")
}

# ─────────────────────────────────────────────────────────────────────────────
# Install all selected groups
# ─────────────────────────────────────────────────────────────────────────────
install_selected() {
    section "Installing packages"
    local group
    for group in "${SELECTED_GROUPS[@]}"; do
        local p acp=() aau=()
        # pacman packages
        local list="${PAC[$group]}"
        for p in ${list}; do
            pacman -Q "$p" >/dev/null 2>&1 || acp+=("$p")
        done
        # AUR packages
        if [ "$INSTALL_AUR" = "1" ]; then
            list="${AUR[$group]}"
            for p in ${list}; do
                pacman -Q "$p" >/dev/null 2>&1 || aau+=("$p")
            done
        fi
        if [ "${#acp[@]}" -gt 0 ] || [ "${#aau[@]}" -gt 0 ]; then
            if [ "${#acp[@]}" -gt 0 ]; then
                install_pac "$group" "${acp[@]}"
            fi
            if [ "${#aau[@]}" -gt 0 ]; then
                install_aur "$group" "${aau[@]}"
            fi
        else
            ok "$(bold "${GROUP_TITLES[$group]}") already satisfied"
        fi
    done
}

# ─────────────────────────────────────────────────────────────────────────────
# Post-install toggles that drive setup.sh steps
# ─────────────────────────────────────────────────────────────────────────────
ask_components() {
    echo
    sub "Post-install" "extra tooling to set up"

    if [ "$MINIMAL" = "1" ]; then
        # --minimal: skip the heavy / interactive extras
        INSTALL_ZSH=1
        INSTALL_TMUX=0
        INSTALL_NVIM=0
        INSTALL_DOOM=0
        INSTALL_RIDER2EMACS=0
        INSTALL_DOTNET=0
        INSTALL_NVM=0
        return 0
    fi

    INSTALL_ZSH=1
    INSTALL_TMUX=1
    INSTALL_NVIM=1
    INSTALL_DOOM=1
    INSTALL_RIDER2EMACS=1
    INSTALL_DOTNET=1
    INSTALL_NVM=1
}

# ─────────────────────────────────────────────────────────────────────────────
# Update mode — refresh configs from git
# ─────────────────────────────────────────────────────────────────────────────
update_configs() {
    section "Updating dotfiles"
    cd "$DOTFILES_DIR"
    if [ -d .git ]; then
        info "Pulling latest from origin…"
        if git pull --ff-only 2>&1; then
            ok "git pull complete"
        else
            warn "git pull had issues — continuing anyway"
        fi
    else
        warn "No .git dir — skipping pull"
    fi
    # Re-create symlinks to pick up any new dotdirs
    setup_symlinks
    run_generate
    section "Done — configs updated"
    ok "Configs refreshed. i3 users:  i3-msg restart  to apply immediately."
}

# ─────────────────────────────────────────────────────────────────────────────
# The big install flow
# ─────────────────────────────────────────────────────────────────────────────
do_install() {
    # Banner
    section "oliverm · dotfiles installer"

    info "Detected: $(. /etc/os-release && echo "$PRETTY_NAME")  ·  shell: $SHELL  ·  repo: $DOTFILES_DIR"

    if ! command -v pacman >/dev/null 2>&1; then
        err "pacman not found. This installer targets Arch-based distros."
        exit 1
    fi

    # Sanity checks
    if [ "$(id -u)" = "0" ]; then
        warn "Running as root — sudo prompts skipped. Some steps may fail."
    fi
    if ! is_tty && [ "$MINIMAL" != "1" ]; then
        warn "No TTY detected — running in minimal (non-interactive) mode."
        MINIMAL=1
    fi

    # AUR helper (flag)
    if [ "$INSTALL_AUR" = "1" ] && [ -z "$(aur_helper)" ] && is_tty; then
        ensure_aur_helper
    fi

    # If this looks like an existing setup, suggest update mode
    if [ -d "$DOTFILES_DIR/.git" ] && [ -L "$HOME/.config/nvim" ] && confirm "Existing setup detected — update instead of fresh install?" "n"; then
        update_configs
        return 0
    fi

    # Component selection
    if [ "$MINIMAL" = "1" ]; then
        SELECTED_GROUPS=(core terminals editors filemgrs fonts)
        INSTALL_AUR=0
    else
        choose_groups
    fi
    ask_components

    printf '\n'
    sub "Selection" "the following will be installed"
    local rank=1
    for group in "${SELECTED_GROUPS[@]}"; do
        printf '  %2s · %-12s %s\n' "$rank" "$(cyan "${GROUP_TITLES[$group]}")" "$(grey "${GROUP_DESC[$group]}")"
        rank=$((rank+1))
    done

    if [ "$DRY_RUN" = "1" ]; then
        printf '\n%s\n' "$(yellow 'DRY-RUN — no changes made. Would have installed:')"
        return 0
    fi

    if ! confirm "Proceed with installation?" "y"; then
        err "Aborted by user."
        exit 0
    fi

    # Pre-flight: refresh keyrings + package databases
    # (fixes the dreaded pgp signature issues on fresh installs)
    if confirm "Refresh pacman keyring & package databases first (recommended)?" "y"; then
        sudo pacman-key --init
        sudo pacman-key --populate archlinux
        status "Updating package databases…"
        sudo pacman -Syy >/dev/null 2>&1
        ok "package databases updated"
    fi

    install_selected

    # Post-install steps
    setup_symlinks
    setup_zsh
    setup_tmux
    setup_nvim
    setup_doom
    setup_rider2emacs
    setup_dotnet_tools
    setup_nvm
    run_generate
    enable_services

    print_summary
}

# ─────────────────────────────────────────────────────────────────────────────
# CLI parsing
# ─────────────────────────────────────────────────────────────────────────────
usage() {
    printf '%s\n' \
        "oliverm · dotfiles installer" \
        "" \
        "Usage:  ./install/install.sh [options] [mode]" \
        "" \
        "Modes:" \
        "  (default)          Full first-time install (asks questions)" \
        "  update             Git pull + regenerate configs only" \
        "" \
        "Options:" \
        "  --minimal          Non-interactive: core shell + editors, no AUR" \
        "  --dry-run          Show what would be installed, change nothing" \
        "  --no-aur           Skip AUR packages entirely" \
        "  -h, --help         This help"
}

main() {
    local mode="install"
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --minimal)   MINIMAL=1 ;;
            --dry-run)   DRY_RUN=1 ;;
            --no-aur)    INSTALL_AUR=0 ;;
            -h|--help)   usage; exit 0 ;;
            install)     mode="install" ;;
            update)      mode="update" ;;
            *)           err "Unknown argument: $1"; usage; exit 1 ;;
        esac
        shift
    done

    case "$mode" in
        install) do_install ;;
        update)  update_configs ;;
        *)       err "Unknown mode: $mode"; usage; exit 1 ;;
    esac
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    main "$@"
fi