call plug#begin('~/.vim/plugged')

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
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
  \ ]
