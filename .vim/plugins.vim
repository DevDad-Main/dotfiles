
" MUST be before coc.nvim is loaded
if $TERM ==# 'dumb'
  let $TERM = 'xterm-kitty'
endif

call plug#begin('~/.vim/plugged')

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'ghifarit53/tokyonight-vim'
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
Plug 'preservim/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'tpope/vim-surround'

call plug#end()
