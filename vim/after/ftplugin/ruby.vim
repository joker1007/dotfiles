" rubyの構文チェック cf. http://d.hatena.ne.jp/idesaku/20120104/1325636604
compiler ruby
augroup rbsytaxcheck
  autocmd! BufWritePost <buffer> silent make! -c "%" | redraw!
augroup END
