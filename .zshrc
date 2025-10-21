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

# Fuzzy cd into a directory
cdf() {
  local dir
  dir=$(fd . -type d \
    -not -path '*/\.git*' \
    -not -path '*/node_modules*' \
    -not -path '*/dist*' \
    -not -path '*/build*' \
    -print 2> /dev/null | fzf --height 40% --reverse --border --preview 'tree -C {} | head -100') \
    && cd "$dir"
}

# Fuzzy open a file with nvim
vf() {
  local file
  file=$(fd . -type f \
    -not -path '*/\.git*' \
    -not -path '*/node_modules*' \
    -not -path '*/dist*' \
    -not -path '*/build*' \
    -print 2> /dev/null | fzf --height 40% --reverse --border --preview 'bat --style=numbers --color=always {} || cat {}') \
    && nvc "$file"
}
