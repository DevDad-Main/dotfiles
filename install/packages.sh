#!/usr/bin/env bash
# packages.sh — package groups (pacman official + AUR via yay/paru).
# Sourced by install.sh. Each group is an associative array of "package:designation".

# ─────────────────────────────────────────────────────────────────────────────
# Group metadata: name shown in the menu + short description
# ─────────────────────────────────────────────────────────────────────────────
declare -A GROUP_TITLES
declare -A GROUP_DESC
declare -A GROUP_DEFAULT      # "on"/"off" — whether it's pre-ticked in the menu

GROUP_TITLES[core]="Core shell & tools"
GROUP_DESC[core]="zsh, starship, tmux, nvim, git, fzf, ripgrep, bat, fd, lazygit"
GROUP_DEFAULT[core]="on"

GROUP_TITLES[desktop]="i3 desktop (X11)"
GROUP_DESC[desktop]="i3-wm, picom, rofi, dunst, i3status-rust, feh, redshift, brightnessctl, screenshots"
GROUP_DEFAULT[desktop]="on"

GROUP_TITLES[wayland]="Hyprland (Wayland)"
GROUP_DESC[wayland]="hyprland, hyprlock, hypridle, hyprshot, wl-clipboard, cliphist, fuzzel, wlogout"
GROUP_DEFAULT[wayland]="off"

GROUP_TITLES[terminals]="Terminals"
GROUP_DESC[terminals]="kitty + foot (fallback used by Hyprland)"
GROUP_DEFAULT[terminals]="on"

GROUP_TITLES[editors]="Code editors"
GROUP_DESC[editors]="neovim, emacs, zed (needs AUR). nvim is always included in core."
GROUP_DEFAULT[editors]="on"

GROUP_TITLES[browsers]="Browsers"
GROUP_DESC[browsers]="qutebrowser + firefox (zen-browser available via AUR)"
GROUP_DEFAULT[browsers]="on"

GROUP_TITLES[filemgrs]="File managers"
GROUP_DESC[filemgrs]="yazi (TUI) + thunar (X11 GUI)"
GROUP_DEFAULT[filemgrs]="on"

GROUP_TITLES[media]="Audio / video / recording"
GROUP_DESC[media]="pulseaudio, pavucontrol, playerctl, gpu-screen-recorder (AUR), maim, xclip"
GROUP_DEFAULT[media]="on"

GROUP_TITLES[devtools]="Dev toolchains"
GROUP_DESC[devtools]="node, npm, python, go, rust, .NET 8, docker, jdk, clang, lldb"
GROUP_DEFAULT[devtools]="off"

GROUP_TITLES[fonts]="Nerd Fonts"
GROUP_DESC[fonts]="JetBrains Mono, Iosevka, Victor Mono, Terminess, Fira Code (AUR)"
GROUP_DEFAULT[fonts]="on"

GROUP_TITLES[utils]="Utility apps"
GROUP_DESC[utils]="fastfetch, btop, wiremix, bluetui, impala, iwd, xautolock, xcolor, power-profiles-daemon"
GROUP_DEFAULT[utils]="on"

GROUP_TITLES[emacs]="Doom Emacs dependencies"
GROUP_DESC[emacs]="Doom's dependencies: git, ripgrep, fd, emacs, sqlite, xclip (installed separately)"
GROUP_DEFAULT[emacs]="off"

GROUP_TITLES[gaming]="Gaming"
GROUP_DESC[gaming]="gamescope, steam, lutris, mangohud (optional, ~2.5 GB)"
GROUP_DEFAULT[gaming]="off"

# ─────────────────────────────────────────────────────────────────────────────
# Official repo (pacman) packages, per group
# ─────────────────────────────────────────────────────────────────────────────
declare -A PAC
PAC[core]="base-devel zsh starship tmux neovim git fzf ripgrep bat fd lazygit tmux-plugin-manager"
PAC[desktop]="i3-wm i3status-rust rofi picom dunst feh redshift brightnessctl xorg-server xorg-xinit xorg-xrandr xorg-xset xorg-setxkbmap libnotify maim xclip xautolock i3lock slop"
PAC[wayland]="hyprland hyprlock hypridle hyprshot wl-clipboard cliphist fuzzel wlogout hyprpicker grim slurp xdg-desktop-portal-hyprland"
PAC[terminals]="kitty foot"
PAC[editors]="neovim emacs"
PAC[browsers]="qutebrowser firefox"
PAC[filemgrs]="yazi thunar"
PAC[media]="pulseaudio pavucontrol playerctl wiremix bluetui maim xclip gpu-screen-recorder"
PAC[devtools]="nodejs npm python python-pip go rust cargo dotnet-sdk jdk-openjdk docker docker-compose clang lldb lld gcc"
PAC[gaming]="gamescope steam lutris mangohud"
PAC[utils]="fastfetch btop wiremix bluetui impala iwd xautolock xcolor power-profiles-daemon gnome-keyring"
PAC[fonts]="ttf-jetbrains-mono-nerd ttf-iosevka-nerd ttf-victor-mono-nerd ttf-fira-code ttf-font-awesome"

# ─────────────────────────────────────────────────────────────────────────────
# AUR packages (installed via yay/paru), per group
# ─────────────────────────────────────────────────────────────────────────────
declare -A AUR
AUR[desktop]="xcolor"
AUR[terminals]=""
AUR[wayland]="cliphist wlogout fuzzel hyprshot hyprpicker bibata-cursor-theme"
AUR[editors]="zed"
AUR[browsers]="zen-browser-bin"
AUR[media]="gpu-screen-recorder"
AUR[fonts]="ttf-victor-mono-nerd ttf-monaspaceneon-nerd"
AUR[utils]="xautolock"
AUR[emacs]=""
AUR[gaming]="mangohud"

# ─────────────────────────────────────────────────────────────────────────────
# Misc / optional extras (pip, npm, cargo, dotnet global tools) — postinstall
# ─────────────────────────────────────────────────────────────────────────────
declare -A EXTRAS
EXTRAS[core]=""
EXTRAS[desktop]=""
EXTRAS[devtools]=""
EXTRAS[emacs]="csharpier shader-ls"