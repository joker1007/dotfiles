" rubyの構文チェック cf. http://d.hatena.ne.jp/idesaku/20120104/1325636604
function! ExecuteMake()
  if &filetype == 'ruby'
    silent make! -c "%" | redraw!
  endif
endfunction

compiler ruby
augroup rbsytaxcheck
  autocmd! BufWritePost <buffer> call ExecuteMake()
augroup END
