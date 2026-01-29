set termguicolors

let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
let g:lightline = {'colorscheme' : 'tokyonight'}

" let g:typescript_disable_builtin_syntax = 1
let g:loaded_typescript_syntax = 1



" colorscheme codedark
colorscheme tokyonight
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE


" Vim-transparent Plugin defaults to make everything transparent
let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                            \ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                            \ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                            \ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']

" Pmenu
let g:transparent_groups += ['Pmenu']

" coc.nvim
" let g:transparent_groups += ['NormalFloat', 'CocFloating']
let g:transparent_groups += [ 'CocFloating']

augroup transparent
  autocmd VimEnter,ColorScheme * call MyTransparent()
augroup END

function! MyTransparent()
    " Customize the highlight groups for transparency in here.

    " CursorLine
    "hi CursorLine ctermfg=NONE ctermbg=239 guibg=NONE guibg=#4e4e4e

    " coc.nvim
    "hi CocMenuSel ctermbg=239 guibg=#4e4e4e
endfunction

" FZF Transparency
":echo g:fzf_colors
" transparent the gutter
let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS .. ' --color=gutter:-1'



