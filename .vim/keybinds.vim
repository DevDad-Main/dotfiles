let mapleader = " "

" Open netrw
nnoremap <leader>e :Lexplore<CR>


" Deletes currently open buffer
nnoremap <leader>db :bd<CR>

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
nnoremap <C-q> :copen<CR>

" Source current file
nnoremap ,, :so<CR>

" Quickly exit insert mode
inoremap jj <Esc>

" Use the default ctrl s to save and format our file
nnoremap <leader>w :update<CR>
nnoremap <leader>q :quit<CR>

" Toggle Coc inlay hints
nnoremap <silent> <leader>h :CocCommand document.toggleInlayHint<CR>

" Substitute word under cursor on line
nnoremap <leader>s :s/\<<C-r><C-w>\>//gI<Left><Left><Left>

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

smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split management
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>ws :split<CR>

" Resize splits
nnoremap <Esc>h :vertical resize -5<CR>
nnoremap <Esc>l :vertical resize +5<CR>
nnoremap <Esc>j :resize +2<CR>
nnoremap <Esc>k :resize -2<CR>

" Tab navigation
nnoremap <C-t> <Cmd>tabnew<CR>
nnoremap <C-x> <Cmd>tabclose<CR>
for i in range(1, 8)
  execute 'nnoremap <Leader>' . i . ' :tabnext ' . i . '<CR>'
endfor

" System clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" Better navigation - center screen on search
nmap n nzzzv
nmap N Nzzzv

" Use C-Space to Esc
nnoremap <C-Space> <Esc>:noh<cr>
vnoremap <C-Space> <Esc>gV

" Escape Insert Mode Quicker
inoremap jk <Esc>

" Q for Ex mode is useless - run macro in q register instead
nnoremap Q @q

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Save all and quit
nnoremap <leader>Q :wqa<CR>

" LazyGit (requires lazygit installed)
nnoremap <leader>l :!lazygit<CR>

" Run a node file and clear the screen before hand
nnoremap <leader>rf :!clear && node %<CR>
