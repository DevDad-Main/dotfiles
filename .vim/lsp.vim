" " Enable diagnostics highlighting
" let lspOpts = #{autoHighlightDiags: v:true}
" autocmd User LspSetup call LspOptionsSet(lspOpts)

" let lspServers = [#{
" 	\	  name: 'clang',
" 	\	  filetype: ['c', 'cpp'],
" 	\	  path: '/usr/local/bin/clangd',
" 	\	  args: ['--background-index']
" 	\ },
" 	\ #{
" 	\	  name: 'typescriptlang',
" 	\	  filetype: ['javascript', 'typescript', 'typescript.tsx', 'javascript.jsx'],
" 	\	  path: '/usr/local/bin/typescript-language-server',
" 	\	  args: ['--stdio']
" 	\ }]


" autocmd User LspSetup call LspAddServer(lspServers)

" " Key mappings
" nnoremap gd :LspGotoDefinition<CR>
" nnoremap gr :LspShowReferences<CR>
" nnoremap K  :LspHover<CR>
" nnoremap gl :LspDiag current<CR>
" nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
" nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
" inoremap <silent> <C-Space> <C-x><C-o>

" " Set omnifunc for completion
" autocmd FileType php setlocal omnifunc=lsp#complete
" autocmd FileType typescript setlocal omnifunc=lsp#complete
" autocmd FileType javascript setlocal omnifunc=lsp#complete

" " Custom diagnostic sign characters
" autocmd User LspSetup call LspOptionsSet(#{
"     \   diagSignErrorText: '✘',
"     \   diagSignWarningText: '▲',
"     \   diagSignInfoText: '»',
"     \   diagSignHintText: '⚑',
"     \ })
