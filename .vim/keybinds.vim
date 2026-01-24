let mapleader = ","

" Open netrw
nnoremap <leader>e :Ex<CR>

" Deletes currently open buffer
nnoremap <leader>d :bd<CR>

" Move selected lines up/down (like Alt-Up/Down)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Scroll half-page and center cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" " Paste without overwriting clipboard
" xnoremap <leader>p "_dP
" nnoremap <leader>dp "_d
" vnoremap <leader>dp "_d

" Navigate quickfix list using Ctrl-j/k
nnoremap <C-j> :lnext<CR>
nnoremap <C-k> :lprev<CR>
nnoremap <leader>cl :lclose<CR>

" Source current file
nnoremap <leader><leader> :so<CR>

" Quickly exit insert mode
inoremap jj <Esc>
