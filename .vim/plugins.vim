call plug#begin('~/.vim/plugged')

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

" NOTE: Add to your tmux.conf:
" bind -n C-h run-shell -t '{mouse}' 'tmux send-keys -t {mouse} C-h'
" bind -n C-j run-shell -t '{mouse}' 'tmux send-keys -t {mouse} C-j'
" bind -n C-k run-shell -t '{mouse}' 'tmux send-keys -t {mouse} C-k'
" bind -n C-l run-shell -t '{mouse}' 'tmux send-keys -t {mouse} C-l'
" is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|vim|nvim|emacs)(diff)?$'"
" bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\' 'select-pane -l'
Plug 'tomasiser/vim-code-dark'
Plug 'yegappan/lsp'
Plug 'ojroques/vim-oscyank'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'tpope/vim-surround'
Plug 'prisma/vim-prisma'

Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-vinegar'

Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'

Plug 'tribela/vim-transparent'
Plug 'tenfyzhong/CompleteParameter.vim'

" Nerd Tree
Plug 'preservim/nerdtree'

Plug 'yaegassy/coc-nginx', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-prettier',
  \ 'coc-prisma-latest',
  \ 'coc-protobuf',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-simple-react-snippets',
  \ 'coc-snippets',
  \ 'coc-sql',
  \ 'coc-tabnine',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-wxml',
  \ 'coc-xml',
  \ 'coc-docker',
  \ ]
