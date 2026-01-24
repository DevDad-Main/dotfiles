" " plugins.vim - Dead simple plugin manager
" " Just source this file in your vimrc
" let s:plugin_dir = expand('~/.vim/plugged')

" " Install a plugin if it doesn't exist
" function! s:ensure(repo)
"   let name = split(a:repo, '/')[-1]
"   let path = s:plugin_dir . '/' . name
  
"   if !isdirectory(path)
"     if !isdirectory(s:plugin_dir)
"       call mkdir(s:plugin_dir, 'p')
"     endif
"     execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
"   endif
  
"   execute 'set runtimepath+=' . fnameescape(path)
" endfunction

" " Your plugins
" call s:ensure('junegunn/fzf')
" call s:ensure('junegunn/fzf.vim')
" call s:ensure('tomasiser/vim-code-dark')
" call s:ensure('ghifarit53/tokyonight-vim')
" call s:ensure('yegappan/lsp')
" call s:ensure('ojroques/vim-oscyank')
" call s:ensure('tpope/vim-commentary')
" call s:ensure('itchyny/lightline.vim')

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
Plug 'yegappan/lsp'
Plug 'ojroques/vim-oscyank'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'machakann/vim-highlightedyank'
call plug#end()
