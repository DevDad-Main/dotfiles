# If you come from bash you might have to change you
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"


plugins=(
  git
  fzf-tab # Faster and better fuzzy finder completion
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  # zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# We make the ls list command return lsd which has icones for a nice aesthetic
alias ls="lsd"

alias tm="tmux"                     # => Start tmux.
alias tma="tmux attach-session"     # => Attach to a tmux session.
alias tmat="tmux attach-session -t" # => Attach to a tmux session with name.
alias tmks="tmux kill-session -a"   # => Kill all tmux sessions.
alias tml="tmux list-sessions"      # => List tmux sessions.
alias tmn="tmux new-session"        # => Start a new tmux session.
alias tmns="tmux new -s"            # => Start a new tmux session with name.
alias tms="tmux new-session -s"     # => Start a new tmux session.

# Lazy Git Simple Alias
alias lg="lazygit"

alias neoterm="neovide -- -u '~/.config/neoterm/neoterm.lua'"
alias nvl="NVIM_APPNAME=LazyVim nvim"
alias nvk="NVIM_APPNAME=kickstart nvim"
alias nvc="NVIM_APPNAME=NvChad nvim"
alias nva="NVIM_APPNAME=AstroNvim nvim"


# I Like the 70 percent height so i can see alot more but this is due to my monitor so i have more screen real estate, change this to your desire values - 40% works great as a default.
# Fuzzy cd into a directory
cdf() {
  local dir
  dir=$(fd --type d --hidden --follow \
    --exclude .git \
    --exclude node_modules \
    --exclude dist \
    --exclude build \
    . | fzf --height 70% --reverse --border \
            --preview 'tree -C {} | head -100') \
    && cd "$dir"
}

# Fuzzy open a file with nvim - Change the nvc below to your alias of choice of use default nvim
vf() {
  local file
  file=$(fd --type f --hidden --follow \
    --exclude .git \
    --exclude node_modules \
    --exclude dist \
    --exclude build \
    . | fzf --height 70% --reverse --border \
            --preview 'bat --style=numbers --color=always {} || cat {}') \
    && nvc "$file"
}
