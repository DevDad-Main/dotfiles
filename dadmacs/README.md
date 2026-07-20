# dadmacs

Minimal Emacs config adapted for personal use, based on [rexim](https://github.com/rexim/dotfiles).

## Usage

```bash
dadmacs                    # launch
dadmacs <file>             # open file
dadmacs ~/emacs-practice   # open directory in dired
```

The alias is defined in `.zshrc`:

```zsh
alias dadmacs='HOME=$HOME/.config/dotfiles/dadmacs emacs'
```

It overrides `HOME` so Emacs finds `~/.emacs` → `~/.config/dotfiles/dadmacs/.emacs` and installs packages to `~/.config/dotfiles/dadmacs/.emacs.d/`.

## Changes from upstream

- **Font**: Iosevka Nerd Font 17 (instead of Iosevka-20)
- **LSP**: Added eglot for Python (pyright), Lua (lua-language-server), Rust, Go, C/C++ (clangd), and others
- **Movement**: Swapped `C-j`/`C-k` for up/down, `C-n`/`C-p` for newline/kill-line
- **LSP navigation**: `C-j`/`C-k` in company completions, xref results, and compile buffers
- **Tree-sitter**: Level 4 font-lock enabled — function calls, properties, operators, brackets, and delimiters get distinct faces (not just keywords and strings)
- **Theme**: Customized gruber-darker — golden functions, blue variables, purple properties, softened yellow
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

# JSON
sudo pacman -S vscode-json-languageserver

# TypeScript (tide bundles its own tsserver, no extra install needed)
```

## Cheatsheet

See [CHEATSHEET.md](./CHEATSHEET.md).

## First launch

First start will download ~50 packages from MELPA — expect 30-60 seconds. Subsequent launches are much faster.
