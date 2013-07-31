call IncludeOtherSyntax("javascript")

syn region rubyJSHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zsJS+	 end=+$+ oneline contains=ALLBUT,@rubyNotTop
syn region rubyJSString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\=\z(JS\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3    matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@codeGroupJAVASCRIPT fold keepend

call IncludeOtherSyntax("coffee")

syn region rubyJSHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zsCOFFEE+	 end=+$+ oneline contains=ALLBUT,@rubyNotTop
syn region rubyJSString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\=\z(COFFEE\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3    matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@codeGroupCOFFEE fold keepend

call IncludeOtherSyntax("sql")

syn region rubyJSHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zsSQL+	 end=+$+ oneline contains=ALLBUT,@rubyNotTop
syn region rubyJSString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\=\z(SQL\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3    matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@codeGroupSQL fold keepend

call IncludeOtherSyntax("html")

syn region rubyJSHeredocStart matchgroup=rubyStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zsHTML+	 end=+$+ oneline contains=ALLBUT,@rubyNotTop
syn region rubyJSString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\=\z(HTML\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3    matchgroup=rubyStringDelimiter end=+^\s*\zs\z1$+ contains=rubyHeredocStart,@codeGroupHTML fold keepend
