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

alias v="nvim"
alias tm="tmux"                     # => Start tmux.
alias tma="tmux attach-session"     # => Attach to a tmux session.
alias tmat="tmux attach-session -t" # => Attach to a tmux session with name.
alias tmks="tmux kill-session -a"   # => Kill all tmux sessions.
alias tml="tmux list-sessions"      # => List tmux sessions.
alias tmn="tmux new-session"        # => Start a new tmux session.
alias tmnw="tmux new-window -n"     # => Start a new tmux window with name.
alias tmns="tmux new -s"            # => Start a new tmux session with name.
alias tms="tmux new-session -s"     # => Start a new tmux session.

# Lazy Git Simple Alias
alias lg="lazygit"

alias nvm="NVIM_APPNAME=nvimMinimal nvim"

alias nt="npm run test"
alias ntw="npm run test:watch"
alias ntc="npm run test:coverage"

alias dcu="docker-compose up --build"
alias dcd="docker-compose down"

# I Like the 70 percent height so i can see alot more but this is due to my monitor so i have more screen real estate, change this to your desire values - 40% works great as a default.
# Fuzzy cd into a directory
cdf() {
  local dir
  dir=$(fdfind --type d --max-depth 3 --hidden --follow \
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
  file=$(fdfind --type f --max-depth 2 --hidden --follow \
    --exclude .git \
    --exclude node_modules \
    --exclude dist \
    --exclude build \
    . | fzf --height 70% --reverse --border \
            --preview 'bat --style=numbers --color=always {} || cat {}') \
    && nvim "$file"
}



pk() {
  local pid
  pid=$(ps -eo pid,ppid,user,%cpu,%mem,etime,tty,cmd --sort=-%cpu | \
    fzf --header="Select process to kill (Press ESC to cancel)" \
        --height=70% --reverse --border=rounded \
        --preview 'pid=$(echo {} | awk "{print \$1}");
                   echo -e "\033[1;34m### PROCESS INFO ###\033[0m";
                   ps -p $pid -o pid,ppid,user,%cpu,%mem,etime,tty,cmd;
                   echo;
                   echo -e "\033[1;34m### CHILD PROCESSES ###\033[0m";
                   pstree -p $pid 2>/dev/null || echo "No child processes."'
  )

  # If user pressed ESC or nothing selected, return
  [[ -z "$pid" ]] && return

  # Extract PID and kill the process
  echo "$pid" | awk '{print $1}' | xargs -r kill -9
}
