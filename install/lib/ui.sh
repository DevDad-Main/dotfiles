#!/usr/bin/env bash
# ui.sh — colors, progress bars, prompts and layout helpers for the installer.
# Sourced by install.sh. No shebang / no execution; this file is a library.

# ─────────────────────────────────────────────────────────────────────────────
# ANSI colour + style helpers
# ─────────────────────────────────────────────────────────────────────────────
_RESET=$'\033[0m'
_BOLD=$'\033[1m'
_DIM=$'\033[2m'
_ITALIC=$'\033[3m'
_UNDER=$'\033[4m'
_BLINK=$'\033[5m'

# Foreground
_FG_RED=$'\033[38;5;203m'
_FG_GREEN=$'\033[38;5;114m'
_FG_YELLOW=$'\033[38;5;228m'
_FG_BLUE=$'\033[38;5;117m'
_FG_PURPLE=$'\033[38;5;177m'
_FG_CYAN=$'\033[38;5;81m'
_FG_WHITE=$'\033[38;5;255m'
_FG_GREY=$'\033[38;5;245m'
_FG_ORANGE=$'\033[38;5;215m'
_FG_PINK=$'\033[38;5;212m'

# On-colour background chips
_BG_GOOD=$'\033[48;5;22m'
_BG_WARN=$'\033[48;5;94m'
_BG_BAD=$'\033[48;5;52m'
_BG_INFO=$'\033[48;5;24m'
_BG_TITLE=$'\033[48;5;23m'

# Fancy glyphs (only used when the terminal can print them)
_GLYPH_OK="✓"
_GLYPH_WARN="⚠"
_GLYPH_ERR="✗"
_GLYPH_INFO="ℹ"
_GLYPH_QUE="?"
_GLYPH_ARROW="→"

# Detect TTY / colour support
if [ ! -t 1 ] || [ -n "${NO_COLOR:-}" ]; then
    _USE_COLOR=0
else
    _USE_COLOR=1
fi

_ui_render() { printf '%s' "$1"; }

# Reset a line (used by the progress bar to rewrite in place).
_ui_clear_line() {
    printf '\r\033[K'
}

# ─────────────────────────────────────────────────────────────────────────────
# Small colour wrappers that respect NO_COLOR / non-TTY output.
# ─────────────────────────────────────────────────────────────────────────────
col() {   # col <colorcode> <text>
    if [ "$_USE_COLOR" = "1" ]; then
        printf '%s%s%s' "$1" "$2" "$_RESET"
    else
        printf '%s' "$2"
    fi
}

bold()   { col "$_BOLD"   "$1"; }
red()    { col "$_FG_RED"    "$1"; }
green()  { col "$_FG_GREEN"  "$1"; }
yellow() { col "$_FG_YELLOW" "$1"; }
blue()   { col "$_FG_BLUE"   "$1"; }
purple() { col "$_FG_PURPLE" "$1"; }
cyan()   { col "$_FG_CYAN"   "$1"; }
grey()   { col "$_FG_GREY"   "$1"; }
white()  { col "$_FG_WHITE"  "$1"; }
orange() { col "$_FG_ORANGE" "$1"; }
pink()   { col "$_FG_PINK"   "$1"; }

# ─────────────────────────────────────────────────────────────────────────────
# Clean section/state chips
# ─────────────────────────────────────────────────────────────────────────────
chip() { # chip <colour> <label> <text...>
    local c="$1"; shift
    local label="$1"; shift
    printf '%s %s %s %s' "$(col "$c" "$_GLYPH_ARROW")" "$(bold "$(col "$c" "[$label]")")" "$(grey '·')" "$(col "$_FG_WHITE" "$*")"
    printf '\n'
}

info()    { chip "$_FG_BLUE"   "info" "$@"; }
ok()      { chip "$_FG_GREEN"  " ok " "$@"; }
warn()    { chip "$_FG_YELLOW" " warn" "$@"; }
err()     { chip "$_FG_RED"    "err " "$@"; }
status()  { chip "$_FG_CYAN"   "  · " "$@"; }

# ─────────────────────────────────────────────────────────────────────────────
# Headers and rules
# ─────────────────────────────────────────────────────────────────────────────
separator() {
    printf '%s\n' "$(grey '─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ─── ───')"
}

section() { # section <title>   — big "boxed" section header
    local title="$1"
    local width=58
    local dash_left=$(( (width - ${#title}) / 2 ))
    local dash_right=$(( width - ${#title} - dash_left ))
    local l r i
    l=""; r=""
    for (( i=0; i<dash_left; i++ ));  do l+="─"; done
    for (( i=0; i<dash_right; i++ )); do r+="─"; done
    printf '\n'
    printf '%s\n' "$(grey "${l}") $(bold "$(col "$_BG_TITLE" " ${title} ")") $(grey "${r}")"
    printf '\n'
}

# Simple one-liner sub-header within a section
sub() { printf '%s %s\n' "$(bold "$(cyan "$1")")" "$(grey "$2")"; }

# ─────────────────────────────────────────────────────────────────────────────
# Handmade progress bar — draws a live bar to the current line.
#   progress <fraction 0..1> <label>
#
# The bar is drawn from blocks:  ▓▓▓▓░░░░░░  47%
# It rewrites single line so a loop can animate it.
# ─────────────────────────────────────────────────────────────────────────────

_bar_width=30
_last_progress=""
_bar_dirty=1

progress() {
    local frac="$1"
    local label="$2"
    local filled
    local i
    local pct

    # Normalise frac to 0..1
    frac="$(awk -v f="$frac" 'BEGIN{ if(f<0)f=0; if(f>1)f=1; print f }')"

    pct="$(awk -v f="$frac" 'BEGIN{ printf "%3d", f*100 }')"
    filled="$(awk -v f="$frac" -v w="$_bar_width" 'BEGIN{ printf "%d", f*w }')"

    local bar=""
    for (( i=0; i<filled; i++ ));  do bar+="▓"; done
    for (( i=filled; i<_bar_width; i++ )); do bar+="░"; done

    # Only redraw if the % changed (visual smoothing when called quickly)
    if [ "$pct" != "$_last_progress" ]; then
        _last_progress="$pct"
        _ui_clear_line
        if [ -n "$label" ]; then
            printf '%s %s %s %s%%%s' \
                "$(bold "$(purple '▌')")" \
                "$bar" \
                "$(grey '▐')" \
                "$pct" \
                "$(grey "  $label")"
        else
            printf '%s %s %s %s%%%s' \
                "$(bold "$(purple '▌')")" \
                "$bar" \
                "$(grey '▐')" \
                "$pct"
        fi
        _bar_dirty=1
    fi
}

# End the progress bar and move to a fresh line.
progress_done() {
    _ui_clear_line
    _last_progress=""
    printf '\n'
}

# ─────────────────────────────────────────────────────────────────────────────
# Spinner for when we don't know how long something takes.
# ─────────────────────────────────────────────────────────────────────────────
_spinner_pid=""
_spinner_chars=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)

spinner_start() { # spinner_start <message>
    if [ -z "$_spinner_pid" ]; then
        {
            local i=0
            while true; do
                if [ "$_USE_COLOR" = "1" ]; then
                    printf '\r%s %s' "$(cyan "${_spinner_chars[i]}")" "$1"
                else
                    printf '\r%s …' "$1"
                fi
                i=$(( (i + 1) % ${#_spinner_chars[@]} ))
                sleep 0.1
            done
        } &
        _spinner_pid=$!
        disown 2>/dev/null || true
    fi
}

spinner_stop() {
    if [ -n "$_spinner_pid" ]; then
        kill "$_spinner_pid" 2>/dev/null
        wait "$_spinner_pid" 2>/dev/null
        _spinner_pid=""
        _ui_clear_line
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Interactive helpers (TTY only — they fall back to safe defaults otherwise)
# ─────────────────────────────────────────────────────────────────────────────
is_tty() { [ -t 0 ] && [ -t 1 ]; }

# confirm <question>  -> returns 0 (yes) or 1 (no). Optional default via $2 (y/n)
confirm() {
    local q="$1"
    local def="${2:-y}"
    if ! is_tty; then
        [ "$def" = "y" ] && return 0 || return 1
    fi
    local prompt
    if [ "$def" = "y" ]; then
        prompt="[Y/n]"
    else
        prompt="[y/N]"
    fi
    while true; do
        printf '%s %s %s ' "$(bold "$(purple '➤')")" "$(white "$q")" "$(grey "$prompt")"
        local ans
        read -r ans </dev/tty
        ans="${ans:-$def}"
        case "$ans" in
            [yY]|[yY][eE][sS]) return 0 ;;
            [nN]|[nN][oO])     return 1 ;;
            *) printf '%s\n' "$(yellow 'Please answer yes or no.')" ;;
        esac
    done
}

# prompt <question> -> echoes the trimmed answer (read from tty)
prompt_text() {
    if ! is_tty; then
        printf 'n/a\n'
        return
    fi
    printf '%s %s ' "$(bold "$(purple '➤')")" "$(white "$1")"
    local ans
    read -r ans </dev/tty
    printf '%s\n' "${ans:-n/a}"
}

# pick <question> <comma,separated,options> -> echoes chosen value (1-indexed choice)
# Renders a numbered menu. Non-TTY falls back to first option.
pick() {
    local q="$1"
    IFS=',' read -r -a opts <<< "$2"
    if ! is_tty; then
        printf '%s\n' "${opts[0]}"
        return
    fi
local num i count
    num="$(bold "$(white "$q")")"
    printf '\n%s\n' "$num"
    for i in "${!opts[@]}"; do
        num="$(purple "$((i+1))")"
        num="$(bold "$num")"
        printf '  %s %s %s\n' "$num" "$(grey '·')" "$(cyan "${opts[$i]}")"
    done
    count="${#opts[@]}"
    while true; do
        printf '%s ' "$(bold "$(purple '➤ choose')")"
        local ans
        read -r ans </dev/tty
        if [[ "$ans" =~ ^[0-9]+$ ]] && [ "$ans" -ge 1 ] && [ "$ans" -le "$count" ]; then
            printf '%s\n' "${opts[$((ans-1))]}"
            return
        fi
        printf '%s\n' "$(yellow "Enter a number between 1 and $count.")"
    done
}
