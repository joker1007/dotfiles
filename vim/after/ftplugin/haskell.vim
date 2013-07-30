let g:haskell_conceal = 0

nnoremap <buffer> ,mt :<C-U>GhcModType<CR>
nnoremap <buffer> ,mc :<C-U>GhcModTypeClear<CR>
nnoremap <buffer> ,ml :<C-U>GhcModLintAsync<CR>

augroup ghcmodcheck
  autocmd! BufWritePost <buffer> GhcModCheckAndLintAsync
augroup END
