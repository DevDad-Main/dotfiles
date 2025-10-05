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

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s '^N' "nvims\n"
