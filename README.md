# Dotfiles

> Personal configuration files for a productive development environment on Arch Linux with i3.

<details>
<summary>🖼️ Previews</summary>

### Neovim

![Nvim Tree](previews/nvim-tree.png)

**Nvim Tree** — File explorer with modern icons, git integration, and project browsing.

![Nvim Tree Preview with Telescope](previews/nvim-tree-previews.png)

**File Preview** — Integrated file preview powered by Telescope for quick content inspection.

![Full LSP Support](previews/full-lsp-support-for-all-languages.png)

**LSP Support** — Full language server protocol integration across all languages with diagnostics, completion, and code actions.

![Pounce Jumping](previews/pounce-better-jumping.png)

**Pounce** — Lightning-fast buffer navigation with semantic matching for precise cursor movement.

![Telescope Keymaps](previews/telescope-search-keymaps.png)

**Telescope** — Fuzzy-find everything: keymaps, buffers, files, and more with extensible pickers.

![FZF with Frecency](previews/fff-fuzzy-file-finder-with-frecency.png)

**Frecency-based Fuzzy Finder** — Smart file search that learns your frequent and recent files.

</details>

## Overview

Configurations for Neovim (multiple variants), Tmux, Hyprland (Wayland compositor), Yazi file manager, Zsh, Starship, Fastfetch, Zed editor, and more.

## Features

### Neovim Configurations

- **nvim** — Main configuration with lazy.nvim, treesitter, telescope, nvim-tree
- **neovim** — Alternative config with lazy.nvim, fzf-lua, mini.files, nvim-tree
- **neovim-nvchad** — NvChad-based configuration

### Desktop Environment

- **i3** — X11 tiling window manager with theme system (Gruvbox Dark / Catppuccin Mocha / Tokyo Night), `$mod+drag` to move/resize windows, audio output switching (`$mod+o`), WiFi manager (`$mod+n`, impala), Caps Lock remapped to Ctrl (`setxkbmap -option ctrl:swapcaps`), smart window grouping (`$mod+Ctrl+y`), popup dialogs in fullscreen (`popup_during_fullscreen smart`), auto-toggle back to previous workspace (`workspace_auto_back_and_forth`), automatic floating for Firefox PiP, mpv, and Save As dialogs, and screen dim/lock management (`$mod+Shift+Escape`)
- **Picom** — Compositor with `dual_kawase` blur for glass effect on transparent windows (Kitty, Emacs), fading toggleable via `PICOM_FADING` in config.local
- **i3status-rust** — Configurable status bar with CPU, memory, disk, network, sound, battery, power profile, and clock blocks — all themed per active theme. The network block auto-detects the active interface (WiFi or Ethernet); left-click it to open the impala WiFi manager
- **cascade-menu** — Keyboard-driven cascading (Miller-column) menu for launching apps and commands. `$mod+m` or click the 󰇄 bar icon. Each column floats with a stair-step offset. Navigate with `j/k/h/l`, execute with `Enter`, close with `q`/`Escape`. Full customization below.
- **Rofi** — App launcher and keybind help (`$mod+/`) — themed per active theme
- **Emacs** — Theme auto-switches to match the current i3 theme (custom monochrome / gruber-darker / catppuccin / doom-one)
- **Wallpapers** — Per-theme wallpapers in `i3/themes/`
- **Redshift** — Auto-starts with i3 for night light (6500K→4500K). Runs via geolocation hardcoded in `i3/config.base`; adjust with `pgrep -a redshift` to verify it's active.

<details>
<summary>📋 cascade-menu — Miller-column launcher</summary>

A keyboard-driven cascading menu for i3. Each column is its own floating window; navigate with `j/k/h/l`, execute with `Enter`, close with `q`/`Escape`. Opens/closes via `$mod+m` (toggle) or the 󰇄 bar icon.

```bash
# Dependencies (Arch)
sudo pacman -S python python-gobject gtk3

# Symlink config directory
ln -sf ~/.config/dotfiles/cascade-menu ~/.config/cascade-menu

# Symlink binary (so $mod+m keybinding can find it)
mkdir -p ~/.local/bin
ln -sf ~/.config/dotfiles/cascade-menu/cascade-menu ~/.local/bin/cascade-menu
```

#### Customization

All configs live under `~/.config/cascade-menu/`.

**`config.toml`** — Appearance, behavior, position, and keybindings:

| Section | Key | Default | Description |
|---|---|---|---|
| `appearance` | `theme` | `"gruvbox-dark"` | Theme name from `themes/*.toml` |
| `appearance` | `font_size` | 18 | Font size in px (matches 9pt at 144 DPI) |
| `appearance` | `max_menu_height` | 50 | Max rows before scrolling (×20px) |
| `appearance` | `opacity` | 1.0 | Window opacity (0.0–1.0) |
| `appearance` | `border_style` | `"sharp"` | `"sharp"` or `"rounded"` |
| `behavior` | `close_on_focus_lost` | true | Close when clicking outside |
| `behavior` | `editor_cmd` | auto | Editor for `$EDITOR` menu commands (auto-detected from `$VISUAL`/`$EDITOR`) |
| `position` | `offset_x` | 8 | Left margin from screen edge (px) |
| `position` | `offset_y` | 0 | Top margin below bar (px) |
| `position` | `bar_height` | 20 | Height of your i3bar (for initial positioning) |
| `keybindings` | `close` | `["Escape", "q"]` | Keys to close menu |
| `keybindings` | `up` | `["k", "Up"]` | Move selection up |
| `keybindings` | `down` | `["j", "Down"]` | Move selection down |
| `keybindings` | `back` | `["h", "Left"]` | Close current column / go back |
| `keybindings` | `forward` | `["l", "Right"]` | Open submenu / execute |
| `keybindings` | `execute` | `["Return", "KP_Enter"]` | Execute selected item |

**`menu.toml`** — Define your menu items (TOML array of tables):

```toml
[[menu]]
label = "My Apps"
icon = "\uf0043"  # optional Nerd Font glyph

[[menu.children]]
label = "Firefox"
command = ["firefox"]

[[menu.children]]
label = "Scripts"
icon = "\uf0749"

[[menu.children.children]]
label = "Update system"
command = ["kitty", "-e", "sudo pacman -Syu"]

[[menu.children.children]]
label = "Backup"
shell = true
command = ["rsync -av ~/Documents /mnt/backup/"]
```

Item fields:
- `label` — Display text
- `icon` — Nerd Font glyph (optional)
- `command` — Program to run (`["cmd", "--arg"]`)
- `shell` — If `true`, run through `sh -c`
- `children` — Sub-items (makes the entry expandable)
- `disabled` — If `true`, greyed out
- `separator` — If `true`, draws a visual divider
- `heading` — If `true`, bold section label

**`$EDITOR` placeholder:** Menu commands starting with `$EDITOR` are expanded to the editor configured in `config.toml` (or auto-detected):
```toml
command = ["$EDITOR", "/path/to/file"]
```

**`themes/*.toml`** — Color palettes, one file per theme:

```toml
background = "#1c1f20"
foreground = "#ebdbb2"
selected_bg = "#d79921"
selected_fg = "#1c1f20"
font_family = "Iosevka Nerd Font"
font_size = 18
```

#### Keybinding reference

| Key | Action |
|---|---|
| `j` / `Down` | Move down |
| `k` / `Up` | Move up |
| `l` / `Right` | Open submenu / execute |
| `h` / `Left` | Go back / close column |
| `Enter` | Execute selected item |
| `g` | Jump to first item |
| `G` | Jump to last item |
| `q` / `Escape` | Close menu |

All keys are overridable in `config.toml` → `[keybindings]`.
</details>

### Shell & Tools

- **Zsh** — Oh My Zsh with plugins (autosuggestions, syntax highlighting, fzf-tab)
- **Starship** — Cross-shell prompt
- **Fastfetch** — System information tool
- **Tmux** — Terminal multiplexer with plugins
- **Yazi** — Modern file manager with custom plugins
- **Zed** — Editor configuration
- **Toggle Record** — Screen recording toggle script

## Requirements

- Arch Linux (recommended) or other Linux distribution
- Terminal with true color and undercurl support (kitty, wezterm, alacritty)
- Nerd Font v3.0+
- Neovim >= 0.9.0 (for Neovim configs)

### Installation

```bash
# Clone the repository
git clone https://github.com/DevDad-Main/dotfiles.git ~/.config/dotfiles
```

### Shell Setup

<details>
<summary>Zsh Configuration</summary>

```bash
# Install Zsh and Oh My Zsh
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# Symlink dotfiles config and set as default shell
ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
chsh -s /usr/bin/zsh
```

</details>

<details>
<summary>i3 Window Manager</summary>

A keyboard-driven i3 config with a theme system (Gruvbox Dark, Catppuccin Mocha, Tokyo Night), vim-style navigation, rofi launcher, and picom compositor with blur.

### Theme System

Switch themes on the fly with `$mod+Shift+t` (rofi picker). Each theme sets i3 colors, i3status-rust bar colors, Kitty terminal theme, wallpaper, and window borders.

Themes are stored in `i3/themes/` as shell files:

| File | Theme |
|---|---|
| `gruvbox-dark` | Gruvbox Dark — warm earthy tones |
| `catppuccin-mocha` | Catppuccin Mocha — cool mauve/yellow accents |
| `tokyo-night` | Tokyo Night — deep blue/night palette |
| `monochrome` | Monochrome — charcoal greys with subtle silver accents |

### Installation

```bash
sudo pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xset i3-wm i3status-rust rofi kitty picom dunst feh brightnessctl playerctl bluetui impala iwd haruna gwenview maim slop xclip i3lock wiremix power-profiles-daemon

# AUR
yay -S xautolock
```

### Backup

``` bash
mkdir -p ~/config-backup
cp -r ~/.config ~/config-backup/
cp -r ~/.local ~/config-backup/
```

### Symlink

```bash
ln -sf ~/.config/dotfiles/i3 ~/.config/i3
ln -sf ~/.config/dotfiles/rofi ~/.config/rofi
ln -sf ~/.config/dotfiles/i3status-rust ~/.config/i3status-rust
mkdir -p ~/.config/picom
ln -sf ~/.config/dotfiles/picom/picom.conf ~/.config/picom/picom.conf

# Generate configs from templates + local overrides
~/.config/dotfiles/i3/generate.sh
```

> All configs (i3, i3status-rust, rofi) are **generated** from template files with `@@VAR@@` placeholders. After pulling git updates, re-run `generate.sh` to apply changes.
>
> **Per-machine overrides:** Machine-specific settings go in `~/.config/dotfiles/i3/config.local` (gitignored). Run `generate.sh` then `i3-msg restart` after editing. For example, set `EDITOR_CMD` to change the `$mod+c` code editor — GUI apps run directly (`emacs`, `code`, `code-oss`, `zeditor`), terminal editors need a terminal (`"kitty -e nvim"`); pin the network interface with `NET_DEVICE=eth0`.
>
> **Audio notes:** Your TV may only support stereo LPCM over HDMI. Use `Super+o` (wiremix) or the rofi audio switcher to select `output:hdmi-stereo` instead of `hdmi-surround` if you get no sound.
>
> **ALSA mixer:** Speaker/Headphone outputs are automatically unmuted on i3 start. If audio cuts out after switching profiles, run `amixer -c 0 sset 'Speaker' unmute 87%`.

### Networking (WiFi / Ethernet)

The i3status-rust `net` block **auto-detects the active interface** — the one on the default route — so it works for both WiFi and Ethernet with no per-machine config, and follows changes live. It shows the SSID + signal strength on WiFi, or the interface name on Ethernet (with the matching icon). To pin a specific interface, set `NET_DEVICE=eth0` in `i3/config.local` (defaults to `auto`).

**WiFi manager (impala):** press `$mod+n` or **left-click the network block** in the bar to open [impala](https://github.com/pythops/impala), a TUI WiFi manager. impala talks to `iwd`, so NetworkManager must use the iwd backend. Run these one at a time (each is a single command):

```bash
sudo pacman -S impala iwd

# Point NetworkManager at the iwd backend
printf '[device]\nwifi.backend=iwd\n' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf

# Stop wpa_supplicant fighting iwd for the device, and make iwd persistent
sudo systemctl disable --now wpa_supplicant
sudo systemctl enable --now iwd

# Apply the backend switch (WiFi will drop briefly here)
sudo systemctl restart NetworkManager
```

> **Both steps matter.** If you only deploy the config without disabling `wpa_supplicant`, both supplicants fight over the wireless device and impala fails with "Operation failed" / shows no networks.

After the restart, WiFi drops and should auto-reconnect (NetworkManager keeps your saved password and hands it to iwd). If it doesn't come back on its own, open impala (`$mod+n`) and connect once — iwd remembers it afterwards. Verify the switch with:

```bash
nmcli -t -f DEVICE,TYPE,STATE dev | grep wifi   # want: wlan0:wifi:connected
systemctl is-active wpa_supplicant iwd          # want: inactive  active
```

Optionally mask wpa_supplicant so nothing can re-activate it: `sudo systemctl mask wpa_supplicant`.

NetworkManager keeps managing your saved connections — it just drives `iwd` instead of `wpa_supplicant`. Revert by deleting `/etc/NetworkManager/conf.d/wifi_backend.conf`, running `sudo systemctl unmask --now wpa_supplicant` (if you masked it), and restarting NetworkManager.

### Keybindings

| Key | Action |
|---|---|---|
| `Super+Enter` | Terminal |
| `Super+Space` | Rofi app launcher (spotlight-style) |
| `Super+d` | Rofi app launcher |
| `Super+Shift+d` | Command runner |
| `Super+Shift+Return` | File manager (thunar) |
| `Super+m` | Cascading menu (cascade-menu) |
| `Super+q` | Kill window |
| `Super+h/j/k/l` | Focus left/down/up/right |
| `Super+Shift+h/j/k/l` | Move window |
| `Super+1-0` | Switch workspace (press again to toggle back) |
| `Super+Shift+1-0` | Move window to workspace |
| `Super+Ctrl+Shift+1-0` | Move container to workspace + follow |
| `Super+y` | Toggle split direction |
| `Super+Ctrl+y` | Smart toggle — group window + neighbor into nested split |
| `Super+Shift+y` | Reset all to horizontal split |
| `Super+s` | Stacking layout |
| `Super+w` | Tabbed layout |
| `Super+Shift+Space` | Toggle floating |
| `Super+f` | Toggle fullscreen |
| `Super+grave` | Focus parent |
| `Super+r` | Resize mode (h/j/k/l) |
| `Super+Shift+r` | Restart i3 |
| `Super+Shift+e` | Exit i3 |
| `Super+Ctrl+q` | Power menu (shutdown/reboot/lock/etc) |
| `Super+Shift+b` | Toggle bar on/off |
| `Super+b` | Bluetooth manager (bluetui TUI) |
| `Super+n` | WiFi manager (impala TUI) |
| `Super+g` | Git (lazygit) |
| `Super+c` | Code editor (configurable via `EDITOR_CMD`, default emacs) |
| `Super+o` | Audio output switcher (wiremix TUI) |
| `Super+Escape` | Lock screen immediately |
| `Super+Shift+Escape` | Screen dim/lock menu (rofi) |
| `Super+Slash` | Keybind help (floating Kitty + fzf search) |
| `Super+Left Click` | Move window (drag) |
| `Super+Right Click` | Resize window (drag) |
| `Super+Shift+t` | Theme picker (rofi) |
| `Super+Shift+c` | Color picker (xcolor) |
| `Super+Ctrl+equal` | Increase bar font size |
| `Super+Ctrl+minus` | Decrease bar font size |
| `Super+minus` | Move to scratchpad |
| `Super+equal` | Show scratchpad |
| `Super+Shift+s` | Region screenshot (clipboard) |
| `Super+Print` | Fullscreen screenshot (clipboard) |
| `Print` | Fullscreen screenshot (file) |
| Volume keys | Volume up/down/mute |
| Brightness keys | Brightness up/down |
| Media keys | Play/Pause/Next/Prev |

### Syncing to another machine

```bash
cd ~/.config/dotfiles && git pull
bash i3/generate.sh
killall picom; picom -b --config ~/.config/dotfiles/picom/picom.conf
i3-msg restart
```

> `generate.sh` handles all generated configs: i3, i3status-rust, rofi, kitty theme, picom, and Emacs theme. Just make sure symlinks exist first (see [Symlinks](#symlinks)). If you have local overrides in `i3/config.local`, they won't be overwritten by `git pull` (it's gitignored).
>
> **After a pull that adds features:** install any new packages (see the i3 `pacman -S` install list above — e.g. `impala iwd` were added for the WiFi manager). Optional extras have their own setup: the [Networking section](#networking-wifi--ethernet) covers switching NetworkManager to the iwd backend for impala.
>
> **Per-machine settings are not synced** — `i3/config.local` is gitignored, so each machine keeps its own. Defaults kick in when it's absent: `$mod+c` opens `emacs` and the network block auto-detects the interface. Override per machine by setting `EDITOR_CMD` (code editor) or `NET_DEVICE` (pin a specific interface) there.

### Gaming

Steam games run well on i3 using [gamescope](https://github.com/ValveSoftware/gamescope) as a compatibility layer. Gamescope creates an isolated compositor that handles fullscreen, VRR, and HDR properly regardless of the WM.

**Global launch option** (Steam → Settings → Compatibility → Launch Options):

```
gamescope -f -- %command%
```

**Per-game** (Right-click game → Properties → Launch Options):

```
gamescope -W 2560 -H 1440 -r 144 -- %command%
```

Flags:
- `-f` — Fullscreen
- `-W` / `-H` — Resolution width/height
- `-r` — Refresh rate
- `--adaptive-sync` — Enable VRR (if supported)

### Reverting back to previous DE/WM config.

``` bash
cp -r ~/config-backup/.config/* ~/.config/
cp -r ~/config-backup/.local/* ~/.local/
```

</details>

### Using this config with end4's Hyprdots

```bash
# Replace end4's hypr config with my custom overrides
mv ~/.config/hypr ~/.config/hypr.bak && ln -s ~/.config/dotfiles/hypr ~/.config/hypr
```

### Symlinks

<details>
<summary>Create Configuration Symlinks</summary>

```bash
# Create symlinks for each configuration
ln -sf ~/.config/dotfiles/nvim ~/.config/nvim
ln -sf ~/.config/dotfiles/tmux ~/.config/tmux
ln -sf ~/.config/dotfiles/yazi ~/.config/yazi
ln -sf ~/.config/dotfiles/hypr ~/.config/hypr
ln -sf ~/.config/dotfiles/starship ~/.config/starship
ln -sf ~/.config/dotfiles/fastfetch ~/.config/fastfetch
ln -sf ~/.config/dotfiles/zed ~/.config/zed
ln -sf ~/.config/dotfiles/i3 ~/.config/i3
ln -sf ~/.config/dotfiles/rofi ~/.config/rofi
ln -sf ~/.config/dotfiles/i3status-rust ~/.config/i3status-rust
mkdir -p ~/.config/picom
ln -sf ~/.config/dotfiles/picom/picom.conf ~/.config/picom/picom.conf

# Generate configs from templates + local overrides
~/.config/dotfiles/i3/generate.sh
```

> After pulling git updates, re-run `generate.sh` to apply any template changes.

</details>

### Screen Tearing

If you see screen tearing with i3 + picom, run the helper script:

```bash
~/.config/i3/scripts/apply-nvidia-tearfree.sh
```

This adds `ForceFullCompositionPipeline = "on"` to the NVIDIA driver config, fixing tearing at the driver level. It's safe on any machine — the config only matches NVIDIA GPUs. Log out and back in after running.

Picom also has `vsync = true` enabled by default as a second layer.

## Project Structure

```
dotfiles/
├── nvim/                 # Main Neovim configuration
├── neovim/               # Alternative Neovim configuration
├── neovim-nvchad/        # NvChad-based Neovim config
├── i3/                   # i3 window manager config
│   ├── config.base       #   Template config (tracked)
│   ├── config.local      #   Per-machine overrides (gitignored)
│   ├── config            #   Generated config (gitignored)
│   ├── generate.sh       #   Merges base + local → all configs
│   ├── bar_font.sh       #   Change bar font size (Ctrl+=/-)
│   ├── keyhelp.sh        #   Keybind help window (Mod+/)
│   ├── theme-picker.sh   #   Rofi theme switcher (Mod+Shift+t)
│   ├── themes/           #   Theme files (colors, wallpaper, kitty theme)
│   │   ├── gruvbox-dark
│   │   ├── catppuccin-mocha
│   │   ├── tokyo-night
│   │   └── monochrome
│   ├── bar_font.sh       #   Binds Ctrl+=/- to change bar font
│   ├── powermenu.sh      #   Shutdown/reboot/lock/suspend menu
│   ├── powerprofile.sh   #   CPU power profile switcher
│   └── scripts/
│       ├── screen-lock-menu.sh  #   Rofi dim/lock timeout selector
│       ├── dim-then-lock.sh     #   Gradual dim before i3lock
│       ├── switch-audio.sh      #   Rofi card profile switcher
│       ├── smart-toggle.sh      #   Group focused window + neighbor into nested split
│       └── apply-nvidia-tearfree.sh  #   Fix screen tearing (ForceFullCompositionPipeline)
├── i3status-rust/        # i3status-rust bar config (generated)
│   ├── config.base.toml  #   Template with placeholders
│   └── config.toml       #   Generated (gitignored)
├── rofi/                 # Rofi launcher config (generated)
│   ├── config.base.rasi  #   Template with placeholders
│   └── config.rasi       #   Generated (gitignored)
├── picom/                # Picom compositor config
│   ├── picom.base.conf   #   Template with PICOM_FADING placeholder
│   └── picom.conf        #   Generated (dual_kawase blur, no fade)
├── emacs/                # Emacs config
│   └── theme.el          #   Generated Emacs theme file
├── hypr/                 # Hyprland compositor config
│   ├── hyprland/         #   Window manager settings
│   ├── hyprlock.conf     #   Lock screen config
│   ├── hypridle.conf     #   Idle management config
│   └── custom/           #   Custom scripts
├── tmux/                 # Tmux configuration
├── yazi/                 # Yazi file manager config
├── starship/             # Starship prompt config
├── fastfetch/            # Fastfetch system info config
├── zed/                  # Zed editor config
├── wallpapers/           # Desktop wallpapers
├── .vim/                 # Legacy Vim configuration
├── .zshrc                # Zsh shell configuration
├── toggle_record.sh      # Screen recording toggle script
└── README.md             # This file
```

## License

MIT
