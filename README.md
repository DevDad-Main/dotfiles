# DevDad Dotfiles

<!-- ## About The Project -->

Home repo for all my dotfiles.

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

# Pre-requisites - DevDadVim

## ✨ Features

- 🔥 Transform your Neovim into a full-fledged IDE
- 💤 Easily customize and extend your config with lazy.nvim
- 🚀 Blazingly fast
- 🧹 Sane default settings for options, autocmds, and keymaps
- 📦 Comes with a wealth of plugins pre-configured and ready to use

## ⚡️ Requirements

- Neovim >= 0.9.0 (needs to be built with LuaJIT)
- Git >= 2.19.0 (for partial clones support)
- a Nerd Font(v3.0 or greater) (optional, but needed to display some icons)
- lazygit (optional)
- a C compiler for nvim-treesitter. See here
- curl for blink.cmp (completion engine)
- for fzf-lua (optional)
- fzf: fzf (v0.25.1 or greater)
- live grep: ripgrep
- find files: fd
- a terminal that supports true color and undercurl:
  - kitty (Linux & Macos)
  - wezterm (Linux, Macos & Windows)
  - alacritty (Linux, Macos & Windows)
  - iterm2 (Macos)

### 🖼️ Preview

<details>

<summary>NvChad - DevDad</summary>

## NvDash - DevDad

![nvdash plugin](./previews/nv-dash.png)

## Nvim-Tree

![nvim-tree plugin](./previews/nvim-tree.png)

## Telescope & Telescope-Frecency

![telescope-with-frecency plugin](./previews/telescope-with-frecency.png)

## Grug Far

![grug-far plugin](./previews/grug-far.png)

## Telescope Buffers With Terminals via builtin :term

![telescope-buffer-terms plugin](./previews/buffers-with-term.png)

## Telescope Fzf Todos

![telescope-fzf-todos plugin](./previews/telescope-fzf-todos.png)

## ToggleTerm Vscode Style Terminals

![toggle-term-vscode plugin](./previews/vert-terminal-vscode.png)

## Telescope Keymaps

![telescope-find-keymaps plugin](./previews/telescope-keymaps.png)

## NvimTree - Custom Fzf File Picker

![nvimtree plugin](./previews/nvimtree-fzf-file.png)

## NvimTree - Custom Fzf Directory Picker (Majorly needed for NvimTree/Neovide)

![nvimtree plugin](./previews/nvimtree-fzf-dir.png)

## Tmux

![tmux](./previews/tmux.png)

</details>

## Custom Fzf Functions

> cd quicker than cd with fzf
> ![fzf-cd](./previews/custom-fzf-cd-func.png)
> find files quicker than find with fzf and open them with your favourite editor
> ![fzf-file-picker](./previews/custom-fzf-file-picker.png)

### Recommended Packages

> Required for some LazyVim plugins, Mason, LSPs.

```bash
sudo pacman -S --needed git base-devel clang gcc go nodejs npm yarn python python-pip luarocks unzip wget ripgrep fd
```

## Installation for .zshrc and custom fzf functions

<details>

<summary>Zsh - OhMyZsh </summary>

```bash
sudo pacman -Syu zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- autosuggesions plugin

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  ```

- zsh-syntax-highlighting plugin

  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  ```

- zsh-fast-syntax-highlighting plugin

  ```bash
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  ```

- zsh-autocomplete plugin

  ```bash
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
  ```

- zsh-fsf plugin
  ```bash
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
  ```

> Remove the ~/zshrc file and replace it with the one in this repo

```bash

ln -s ~/.config/dotfiles/.zshrc ~/
```

</details>

<details>

<summary>Niri - Installation/Setup</summary>


https://github.com/user-attachments/assets/82de8725-0603-4ca5-9985-a4f21939c1d6


> I'm using arch linux so you may need to change some things depeding on your distro

### 1. Install Niri

> Niri is needed and after those are the additional packages suggested by the [Niri AUR](https://wiki.archlinux.org/title/Niri)

```bash
yay -S niri fuzzel mako waybar xdg-desktop-portal-gtk alacritty swaybg swayidle swaylock xwayland-satellite udiskie
```

### 2. Install Noctalia-Shell Dependencies

> Nocatlia shell is a choice of mine but waybar and other bar managers can be used - refer to the [noctalia-shell](https://github.com/noctali/noctalia-shell) repo for more info.

```bash
# Core dependencies (required)
yay -S quickshell ttf-roboto inter-font gpu-screen-recorder brightnessctl

# Desktop monitor brightness (may cause instability with some monitors)
yay -S ddcutil

# Optional dependencies
yay -S cliphist matugen-git cava wlsunset xdg-desktop-portal python3 evolution-data-server

# Polkit agent (can be any other agent)
yay -S polkit-kde-agent
```

### 3. Install Noctalia-Shell

> The configuration files are saved in ~/.config/noctalia/ and the cache files are saved in ~/.cache/noctalia/.

```bash
mkdir -p ~/.config/quickshell/noctalia-shell && \
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | \
tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
```

</details>

# Installation

#### 1. Clone the repo:

- Optionally if you are downloading the repo manually just place everything that is inside of the dotfiles directory into the ~./config directory and you can skip the next steps.

  ```bash
  git clone https://github.com/DevDad-Main/dotfiles.git ~/.config/
  ```

#### 2. Create symlinks to the repo:

- Due to how the $XDG_CONFIG_HOME is set, we need to create symlinks

  ```bash
  ln -s ~/.config/dotfiles/NvChad_devdad ~/.config/NvChad
  ln -s ~/.config/dotfiles/LazyVim ~/.config/LazyVim
  ln -s ~/.config/dotfiles/kickstart_devdad/ ~/.config/kickstart
  ln -s ~/.config/dotfiles/tmux ~/.config/tmux
  ln -s ~/.config/dotfiles/yazi ~/.config/yazi

  # Niri Related
  ln -s ~/.config/dotfiles/niri/niri  ~/.config/niri
  ln -s ~/.config/dotfiles/niri/noctalia  ~/.config/noctalia
  # Remove the default quickshell install and replace it with the one in this repo (optional)
  rm -rf ~/.config/quickshell && ln -s ~/.config/dotfiles/niri/quickshell ~/.config/quickshell
  ```

#### 3. For Vscode config:

- We need to now install the extensions from the extenstions.txt file

```bash
cat ~/.config/dotfiles/vscode/.config/Code/User/extensions.txt | xargs -L 1 code --install-extension
```
