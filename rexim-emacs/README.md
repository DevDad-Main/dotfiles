# rexim-emacs

Minimal Emacs config by [rexim](https://github.com/rexim/dotfiles), adapted for personal use.

## Usage

```bash
rexim                    # launch
rexim <file>             # open file
rexim ~/emacs-practice   # open directory in dired
```

The alias is defined in `.zshrc`:

```zsh
alias rexim='HOME=$HOME/.config/dotfiles/rexim-emacs emacs'
```

It overrides `HOME` so Emacs finds `~/.emacs` → `~/.config/dotfiles/rexim-emacs/.emacs` and installs packages to `~/.config/dotfiles/rexim-emacs/.emacs.d/`.

## Changes from upstream

- **Font**: Iosevka Nerd Font 17 (instead of Iosevka-20)
- **LSP**: Added eglot for Python (pyright), Lua (lua-language-server), Rust, Go, C/C++ (clangd), and others
- **Movement**: Swapped `C-j`/`C-k` for up/down, `C-n`/`C-p` for newline/kill-line
- **Package fixes**: Removed `helm-git-grep`, `helm-cmd-t`, `helm-ls-git` (no longer on MELPA)
- **Error guards**: Wrapped exotic mode `require`s (fasm-mode, simpc-mode, etc.) in `ignore-errors`

## Dependencies

Install LSP servers for features you want:

```bash
# Python
sudo pacman -S python-lsp-server   # or use pyright (already installed)

# Lua
sudo pacman -S lua-language-server

# C/C++
sudo pacman -S clang               # already installed (provides clangd)

# Rust
sudo pacman -S rustup              # already installed (provides rust-analyzer)

# Go
sudo pacman -S go                  # then: go install golang.org/x/tools/gopls@latest

# TypeScript
sudo pacman -S typescript          # already configured via tide
```

## Cheatsheet

See [CHEATSHEET.md](./CHEATSHEET.md).

## First launch

First start will download ~50 packages from MELPA — expect 30-60 seconds. Subsequent launches are much faster.
