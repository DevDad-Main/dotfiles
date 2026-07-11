# ── Oh My Zsh ──
[[ -n "$ZSH_VERSION" ]] || return # only run in zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ── Paths ──
export PATH=$HOME/.local/bin:$HOME/go/bin:$HOME/.config/emacs/bin:$PATH
export TERM=xterm-256color

# ── Languages ──
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/default
export PATH=$JAVA_HOME/bin:$PATH

# ── Aliases ──
alias ls="lsd"
alias v="nvim"
alias nv="bob run nightly"
alias ns="bob run stable"
alias nvo="NVIM_APPNAME=nvim_online nvim"
alias nvt="NVIM_APPNAME=neovim nvim"
alias mini="NVIM_APPNAME=nvim-nvchad nvim"
alias lg="lazygit"
alias nt="npm run test"
alias ntw="npm run test:watch"
alias ntc="npm run test:coverage"
alias dcu="docker-compose up --build"
alias dcd="docker-compose down"
alias tm="tmux"
alias tma="tmux attach-session"
alias tmat="tmux attach-session -t"
alias tmks="tmux kill-session -a"
alias tml="tmux list-sessions"
alias tmn="tmux new-session"
alias tmnw="tmux new-window -n"
alias tmns="tmux new -s"
alias tms="tmux new-session -s"

# ── FZF ──
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

cdf() {
  local dir
  dir=$(fd --type d --max-depth 3 --hidden --follow \
    --exclude .git --exclude node_modules --exclude dist --exclude build \
    . | fzf --height 70% --reverse --border \
            --preview 'tree -C {} | head -100') \
    && cd "$dir"
}

vf() {
  local file
  file=$(fd --type f --max-depth 2 --hidden --follow \
    --exclude .git --exclude node_modules --exclude dist --exclude build \
    . | fzf --height 70% --reverse --border \
            --preview 'bat --style=numbers --color=always {} || cat {}') \
    && nvim "$file"
}

pk() {
  local pid
  pid=$(ps -eo pid,ppid,user,%cpu,%mem,etime,tty,cmd --sort=-%cpu | \
    fzf --header="Select process to kill" --height=70% --reverse --border=rounded \
        --preview 'pid=$(echo {} | awk "{print \$1}");
                   ps -p $pid -o pid,ppid,user,%cpu,%mem,etime,tty,cmd' \
  )
  [[ -z "$pid" ]] && return
  echo "$pid" | awk '{print $1}' | xargs -r kill -9
}

# ── Prompt ──
export STARSHIP_CONFIG=~/.config/dotfiles/starship/starship.toml
eval "$(starship init zsh)"

fastfetch

# ── Package finder (inspired by omarchy) ──
pi() {
  local pkgs
  pkgs=$(pacman -Slq | fzf --multi --preview 'pacman -Sii {1}' \
    --preview-window 'down:65%:wrap' \
    --bind 'alt-p:toggle-preview' \
    --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up' \
    --color 'pointer:green,marker:green') \
    && [[ -n "$pkgs" ]] && sudo pacman -S $(echo "$pkgs" | tr '\n' ' ')
}
pia() {
  local pkgs
  pkgs=$(yay -Slqa 2>/dev/null | fzf --multi --preview 'yay -Siia {1}' \
    --preview-window 'down:65%:wrap' \
    --bind 'alt-p:toggle-preview' \
    --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up' \
    --color 'pointer:magenta,marker:magenta') \
    && [[ -n "$pkgs" ]] && yay -S $(echo "$pkgs" | sed 's/^/aur\//' | tr '\n' ' ')
}
pr() {
  local pkgs
  pkgs=$(yay -Qqe 2>/dev/null | fzf --multi --preview 'yay -Qi {1}' \
    --preview-window 'down:65%:wrap' \
    --bind 'alt-p:toggle-preview' \
    --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up' \
    --color 'pointer:red,marker:red') \
    && [[ -n "$pkgs" ]] && echo "$pkgs" | tr '\n' ' ' | xargs sudo pacman -Rns
}
