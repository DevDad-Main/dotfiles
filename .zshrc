# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.hyde.zshrc - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information

#  Aliases 
# Add aliases here
alias vi="nvim"
alias vim="nvim"
#Can do this or simply \vim to ignore the aliases above
alias oldvim="vim"

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
# Add your configurations here
#export EDITOR=code


# alias nvim="NVIM_APPNAME=LazyVim nvim"
# alias nvchad="NVIM_APPNAME=NvChad nvim"
#
#
#
# # For calling default nvim my own config
# alias vi="nvim"

alias vi="NVIM_APPNAME=nvim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  # items=("default" "kickstart" "nvim" "NvChad" "AstroNvim")
  items=("default" "nvim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
  export EDITOR=$config nvim $@
}


# export EDITOR=nvim

bindkey -s ^a "ns\n"
# bindkey -s ^a "nvims\n"

eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh)"

export PATH=$PATH:/home/devdad/.spicetify
export PATH="$HOME/.dotnet/tools:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$DOTNET_ROOT:$PATH"

export DOTNET_ROOT=/usr/share/dotnet/ 

# bun completions
[ -s "/home/devdad/.bun/_bun" ] && source "/home/devdad/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
