# Dotfiles

> Personal configuration files for a keyboard-driven dev environment on Arch Linux — i3 + Hyprland, Neovim, Doom Emacs, Tmux, and more.

- 💾 [One-shot installer](#-quick-install) — fresh machine to full setup in one command
- ⌨️ [Keybindings](#-keybindings) · 🔗 [Symlinks](#-what-gets-installed) · 🧩 [Customisation](#-customisation)
- 📱 [cascade-menu](#-cascade-menu-miller-column-launcher) · 🎮 [Unity ←→ Doom Emacs](#-unity--doom-emacs) · 🌐 [WiFi (impala/iwd)](#-wifi--ethernet)

---

## ✨ Quick install

Install everything on a fresh Arch-based machine (Arch, CachyOS, EndeavourOS, …) with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash
```

That single pipe will:
1. Clone this repo to `~/.config/dotfiles`
2. Ask which components you want (i3 desktop, Hyprland, browsers, dev tools, gaming, …)
3. Install packages from the official repos (and AUR via `yay`/`paru` if you want) with a live progress bar
4. Symlink all configs into place (backing up anything existing first)
5. Set up Oh My Zsh + plugins, Tmux + TPM, Neovim (lazy.nvim), Doom Emacs, NVM, and more
6. Configure NetworkManager → iwd for `impala`

Pass flags/modes straight through the one-liner:

```bash
# Update an existing machine (git pull + regenerate every templated config)
curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash -s -- update

# Preview what would be installed, change nothing
curl -fsSL https://raw.githubusercontent.com/DevDad-Main/dotfiles/main/install/bootstrap.sh | bash -s -- --dry-run
```

### Installer flags

| Flag | What it does |
|---|---|
| *(no arg)* | Full interactive install — asks which components, installs, links, configures |
| `update` | `git pull` + re-run `i3/generate.sh` + re-link symlinks. Safe anytime. |
| `--minimal` | Non-interactive: shell + editors only, no AUR |
| `--dry-run` | Show the plan without changing anything |
| `--no-aur` | Skip AUR packages entirely (official repos only) |
| `-h`, `--help` | Show usage |

> **Already cloned the repo?** Just run `bash install/install.sh` (or `… install/install.sh update`).
>
> **Overrides:** `DOTFILES_DIR` (where to clone/config) and `REPO_URL` (a fork) are honoured by the bootstrap script.

---

## 🗺 What's included

| Area | Tools |
|---|---|
| **Window managers** | i3 (X11, primary) · Hyprland (Wayland) · Picom (dual_kawase blur) |
| **Terminals** | Kitty (primary) · Foot (Hyprland fallback) |
| **Editors** | Neovim (lazy.nvim, 60+ plugins) · Doom Emacs (Unity/`.NET`) · Zed · Vim |
| **Shell** | Zsh + Oh My Zsh, Starship prompt, Fastfetch system info |
| **Multiplexer** | Tmux + TPM (resurrect, continuum, cpu/mem, navigator) |
| **Files** | Yazi (TUI) · Thunar (GUI) |
| **Browsers** | Qutebrowser (vim-style) · Firefox + textfox CSS · Zen Browser (userChrome) |
| **Launcher / menus** | Rofi · Cascade-menu (Miller-column launcher) |
| **Notifications / bar** | Dunst (themed, progress OSDs) · i3status-rust |
| **Audio** | wiremix (output switcher) · pulseaudio · playerctl · EasyEffects |
| **Screen record / shot** | gpu-screen-recorder · maim (X11) · grim/slurp/hyprshot (Wayland) |
| **Security / locks** | i3lock · Hyprlock · xautolock · redshift (night light) |
| **Utility TUIs** | bluetui (Bluetooth) · impala (WiFi) · wiremix · btop · fzf · lazygit · lsd · bat · fd |
| **Dev toolchains** | Node/NVM · Bun · Go · Rust · .NET 8 · Java · Docker · Python · clang/lldb |

---

## 🧩 Highlights

### Theme system (i3)

The whole desktop re-themes in one go — i3 borders, i3status-rust bar, rofi, dunst, kitty, Emacs, wallpapers — via `$mod+Shift+t` (rofi picker).

Themes: **Gruvbox Dark** · **Catppuccin Mocha** · **Tokyo Night** · **Monochrome**

### Keyboard-first i3

- Vim-style window navigation, drag-to-move/resize with the mouse
- OSD volume/brightness progress bars (dunst), screen dim/lock menu, power menu
- Smart window grouping (`$mod+Ctrl+y`), floating-vs-tiling auto rules for PiP/`Save As` dialogs
- Caps Lock → Ctrl (remapped on start; re-apply with `$mod+Shift+r` if a new keyboard resets it)
- `$mod+o` audio output switcher · `$mod+b` Bluetooth · `$mod+n` WiFi (impala)

---

## ⌨️ Keybindings

| Key | Action |
|---|---|
| `Super+Enter` | Terminal · `Super+Space` app launcher (rofi) |
| `Super+Shift+Return` | File manager (thunar) |
| `Super+m` | Cascade menu · `Super+/` keybind help |
| `Super+q` | Kill window |
| `Super+h/j/k/l` | Focus · `Super+Shift+h/j/k/l` move window |
| `Super+1-0` | Switch workspace (press again to toggle back) |
| `Super+Shift+1-0` | Move window to workspace |
| `Super+y` / `Super+Ctrl+y` | Toggle split / smart-group window + neighbour |
| `Super+s` / `Super+w` | Stacking / tabbed layout |
| `Super+Shift+Space` | Toggle floating · `Super+f` fullscreen · `Super+grave` focus parent |
| `Super+r` | Resize mode (h/j/k/l) |
| `Super+Shift+r` | Restart i3 · `Super+Shift+e` exit i3 |
| `Super+Ctrl+q` | Power menu (shutdown/reboot/lock/…) |
| `Super+Shift+b` | Toggle bar |
| `Super+b` | Bluetooth (bluetui) · `Super+n` WiFi (impala) · `Super+g` git (lazygit) |
| `Super+c` | Code editor (configurable, default `emacs`) |
| `Super+o` | Audio output switcher (wiremix) |
| `Super+Escape` | Lock · `Super+Shift+Escape` dim/lock menu · `Super+Ctrl+Escape` night light |
| `Super+Shift+t` | Theme picker · `Super+Shift+w` wallpaper picker · `Super+Shift+c` color picker |
| `Super+Ctrl+equal/+-` | Bar font size |
| `Super+-` / `Super+=` | Scratchpad move/show |
| `Super+Shift+s` | Region screenshot (clipboard) · `Super+Print` / `Print` fullscreen (clipboard/file) |
| Volume / brightness / media keys | OSD-controlled |

---

## 🔄 What gets installed

The installer's symlinks (each source is in this repo):

| Repo dir | Installed to |
|---|---|
| `nvim/` | `~/.config/nvim` |
| `i3/` | `~/.config/i3` |
| `i3status-rust/` | `~/.config/i3status-rust` |
| `rofi/` | `~/.config/rofi` |
| `hypr/` | `~/.config/hypr` |
| `kitty/` | `~/.config/kitty` |
| `tmux/` | `~/.config/tmux` |
| `yazi/`, `qutebrowser/`, `starship/`, `fastfetch/`, `zed/`, `zen/`, `dunst/`, `picom/` | `~/.config/<name>` |
| `cascade-menu/` | `~/.config/cascade-menu` + binary → `~/.local/bin/` |
| `dadmacs/` | `~/.config/dadmacs` |
| `.doom.d/` | `~/.doom.d` **and** `~/.config/doom` (Doom v3) |
| `.zshrc` | `~/.zshrc` |

Anything already at those paths is **backed up** to `~/.dotfiles-backup-<timestamp>` before linking, never overwritten.

Configs that are **generated** from templates (i3, i3status-rust, rofi, dunst, picom, kitty theme, Emacs theme, Zen/Firefox CSS) are produced by `i3/generate.sh` — run automatically by the installer, and on every `update`.

---

## 🛠 Customisation

### Per-machine overrides

Machine-specific settings live in `i3/config.local` (**gitignored** — never synced):

```bash
BAR_FONT=8
THEME=catppuccin-mocha
EDITOR_CMD="kitty -e nvim"      # $mod+c → code editor
NET_DEVICE=eth0                  # pin status-bar network interface (default: auto)
PICOM_FADING=true                # enable window fading
NIGHT_TEMP=4500
WALLPAPER=/path/to/wallpaper.png
```

Edit `config.local`, then re-run `bash install/install.sh update` (or `~/.config/dotfiles/i3/generate.sh` and `i3-msg restart`).

### Theme picker

`$mod+Shift+t` opens a rofi theme switcher; pick and the whole desktop re-themes.

---

<details>
<summary><b>📋 cascade-menu — Miller-column launcher</b> <i>(click to expand)</i></summary>

A keyboard-driven cascading menu for i3. Each column is its own floating window; navigate with `j/k/h/l`, execute with `Enter`, close with `q`/`Escape`. Opens via `$mod+m`.

Config lives in `~/.config/cascade-menu/`:

- **`config.toml`** — appearance (theme, font_size, opacity, border_style), position (offset_x/y, bar_height), keybindings (close/up/down/back/execute)
- **`menu.toml`** — items: `label`, `icon` (Nerd Font glyph), `command`, `shell` (run via `sh -c`), `children`, `disabled`, `separator`, `heading`. Commands starting `$EDITOR` expand to your configured editor.
- **`themes/*.toml`** — color palettes (`background`, `foreground`, `selected_bg`, `selected_fg`, `font_family`, `font_size`)

Example item:

```toml
[[menu.children]]
label = "Update system"
command = ["kitty", "-e", "sudo pacman -Syu"]
```

</details>

<details>
<summary><b>🎮 Unity ←→ Doom Emacs</b> <i>(external editor for the Unity engine; click to expand)</i></summary>

Sets up Doom Emacs as Unity's external editor with OmniSharp LSP (C#), CSharpier formatting, ShaderLab highlighting, via the patched [`rider2emacs`](rider2emacs/) shim (generates Rider-style `.sln`/`.csproj` for Unity, opens files in `emacsclient -c`).

```bash
# Post-install steps the installer runs (or run manually):
sudo pacman -S dotnet-sdk-8.0
cargo install --path ~/.config/dotfiles/rider2emacs --force
dotnet tool install -g csharpier
doom sync
```

- The Emacs daemon auto-starts with i3, so `emacsclient` always has a server.
- Closing the window won't kill the daemon — answering "no" just closes the frame.
- On first `.cs` open, lsp-mode offers to install `omnisharp` — accept.
- The Doom config lives in `.doom.d/` (linked to `~/.config/doom`): modules for corfu, lsp, tree-sitter, evil, org, docker, plus `unity.el` (auto-moves `.meta` files, forces CSharpier) and a custom theme set.
- `dadmacs/` is a separate vanilla-Emacs (evil-mode) config run via the `dadmacs` alias with its own HOME.

> **ShaderLab LSP** is currently disabled (needs EOL .NET 7 runtime). `shader-mode` still provides highlighting.

</details>

<details>
<summary><b>🌐 WiFi / Ethernet (impala + iwd)</b> <i>(click to expand)</i></summary>

The i3status-rust `net` block auto-detects the active interface (WiFi or Ethernet) — no per-machine config. `$mod+n` or clicking the network block opens **impala**, a TUI WiFi manager that talks to `iwd`.

The installer configures NetworkManager to use the `iwd` backend and disables `wpa_supplicant` (both steps matter):

```bash
printf '[device]\nwifi.backend=iwd\n' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null
sudo systemctl disable --now wpa_supplicant
sudo systemctl enable --now iwd
sudo systemctl restart NetworkManager
```

Verify: `nmcli -t -f DEVICE,TYPE,STATE dev | grep wifi` → want `wlan0:wifi:connected`, and `systemctl is-active wpa_supplicant iwd` → `inactive active`.

</details>

<details>
<summary><b>🎮 Gaming</b> <i>(click to expand)</i></summary>

Steam games run well on i3 via **gamescope**:

```bash
# Steam → Settings → Compatibility → Launch options:
gamescope -f -- %command%
```

Flags: `-f` fullscreen · `-W 2560 -H 1440 -r 144` resolution/refresh · `--adaptive-sync` VRR.

</details>

<details>
<summary><b>🖼 Screen tearing fix</b> <i>(click to expand)</i></summary>

If i3 + picom tears on NVIDIA:

```bash
~/.config/i3/scripts/apply-nvidia-tearfree.sh   # adds ForceFullCompositionPipeline
```

Safe on any machine (matches NVIDIA GPUs only). Log out/in after. Picom also runs `vsync = true`.

</details>

---

## 📁 Project structure

```
dotfiles/
├── install/               # ⭐ the installer
│   ├── bootstrap.sh       #   curl | bash entry point (clones + hands off)
│   ├── install.sh         #   main installer (modes, progress bar, questions)
│   ├── packages.sh        #   component groups → pacman / AUR package lists
│   ├── setup.sh           #   symlinks, shell/tmux/doom/npm post-install steps
│   └── lib/ui.sh          #   colors, progress bar, prompts
├── i3/                    # primary DE
│   ├── config.base        #   template (tracked) → config (generated)
│   ├── config.local       #   per-machine overrides (gitignored)
│   ├── generate.sh        #   merges base + local → all generated configs
│   ├── themes/            #   gruvbox-dark · catppuccin-mocha · tokyo-night · monochrome
│   └── scripts/           #   powermenu, dim-then-lock, volume/brightness OSD, …
├── hypr/                  # Wayland DE (quickshell-based)
├── nvim/                  # main editor config (lazy.nvim)
├── .doom.d/               # Doom Emacs config (Unity/.NET focus)
├── dadmacs/               # vanilla Emacs config (evil-mode)
├── rider2emacs/           # patched Unity→Emacs shim (Rust)
├── cascade-menu/          # Miller-column launcher (Python/GTK)
├── kitty/ tmux/ yazi/ qutebrowser/ starship/ fastfetch/ zed/ zen/ dunst/ picom/ rofi/ i3status-rust/
├── .vim/                  # legacy Vim config
├── .zshrc
└── toggle_record.sh        # gpu-screen-recorder toggle
```

---

## 🔄 Syncing to another machine

```bash
cd ~/.config/dotfiles && bash install/install.sh update
```

Or via the one-liner: `curl -fsSL …/install/bootstrap.sh | bash -s -- update`

`update` pulls from git, re-creates symlinks, and regenerates all templated configs — your per-machine `config.local` is never touched (it's gitignored).

### Backup / revert

```bash
# Snapshot current configs before a big change
mkdir -p ~/config-backup && cp -r ~/.config ~/config-backup/ && cp -r ~/.local ~/config-backup/

# Restore
cp -r ~/config-backup/.config/* ~/.config/
cp -r ~/config-backup/.local/* ~/.local/
```

---

## License

MIT