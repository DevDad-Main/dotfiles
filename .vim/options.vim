set softtabstop=4
set smartindent
set showmatch
syntax on
filetype plugin indent on

" Line numbers
set number
set relativenumber

" Indentation and tabs
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab

" Search
set ignorecase
set smartcase
set incsearch

" Appearance
set background=dark
" set signcolumn=yes
" set cursorline
" set colorcolumn=80

" Backspace behavior
set backspace=indent,eol,start

" Split window behavior
set splitbelow
set splitright

" dw/diw/ciw treat dash-separated words as single word
set iskeyword+=-

" Keep cursor 8 lines from top/bottom
set scrolloff=8

" Cursor responsiveness
set updatetime=50

set laststatus=2
set noshowmode


" Block cursor in Normal mode, line cursor in Insert mode
let &t_SI = "\e[6 q"   " Insert mode: vertical line
let &t_EI = "\e[2 q"   " Normal mode: block

" Use standard system clipboard when copying and pasting text.
" Changes how the clipboard functionality works.  The comma separated list
" recognizes following names:
" "unnamed" use clipboard register "*" for all yanks
" "unnamedplus" use clipboard register "+" instead "*" for all operations
" except for yank.  Yank will copy text to register "+" and "*" if "unnamed"
" is included.
set clipboard=unnamed,unnamedplus

set foldmethod=syntax
set foldlevelstart=99   " optional: open all folds by default
