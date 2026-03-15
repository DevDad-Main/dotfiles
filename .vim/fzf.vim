
" FZF.vim Specific
let g:fzf_layout = { 'down': '40%' }

nnoremap <leader>f :Files<CR>
nnoremap <leader>o :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>k :Maps<CR>
nnoremap <leader>j :Helptags<CR>

" RipGrep Specific
nnoremap <leader>g :RG<CR>

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
