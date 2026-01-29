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

" Paste without overwriting clipboard
xnoremap <leader>p "_dP
nnoremap <leader>pd "_d
vnoremap <leader>pd "_d

" Navigate quickfix list using Ctrl-j/k
nnoremap <C-j> :lnext<CR>
nnoremap <C-k> :lprev<CR>
nnoremap <leader>cl :lclose<CR>

" Source current file
nnoremap <leader><leader> :so<CR>

" Quickly exit insert mode
inoremap jj <Esc>

" Use the default ctrl s to save and format our file
nnoremap <C-s> :update<CR>

" Toggle Coc inlay hints
nnoremap <silent> <leader>h :CocCommand document.toggleInlayHint<CR>

" Substitute word under cursor on line
nnoremap <leader>s :s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Source current file
nnoremap <leader><leader> :so<CR>

" Visual mode mappings
" surround selected text with gs{char}
xmap S <Plug>YsurroundVisual 
" delete surrounding in visual mode
xmap D <Esc><Plug>Dsurround
" change surrounding in visual mode
" xmap gC <Plug>Csurround
nmap C <Esc><Plug>Csurround

" Visual-mode indent that keeps selection
vnoremap < <gv
vnoremap > >gv
