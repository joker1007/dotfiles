" Vim plugin file
"
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Last Change:  1 September 2004
"
" Purpose:      To make <ctrl-a> and <ctrl-x> operate on the names of weekdays
"               and months.
"
" TODO:         Although it is possible to add any words you like as
"               increase/decrease pairs, problems will arise when one word has
"               two or more possible increments (or decrements). For instance,
"               the 4th month is named "April" in both English and Swedish, but
"               its increment is called "May" and "Maj", respectively.
"
"               So, in order for the script to be generally applicable, I must
"               find a way to toggle between all possible increments/decrements
"               of a word.


if exists('loaded_monday') || &compatible
    finish
endif
let loaded_monday = 1

function s:AddPair(word1, word2)
    let w10 = tolower(a:word1)
    let w11 = toupper(matchstr(w10, '.')) . matchstr(w10, '.*', 1) 
    let w12 = toupper(w10)

    let w20 = tolower(a:word2)
    let w21 = toupper(matchstr(w20, '.')) . matchstr(w20, '.*', 1) 
    let w22 = toupper(w20)

    let s:words = s:words . w10 . ':' . w20 . ','
    let s:words = s:words . w11 . ':' . w21 . ','
    let s:words = s:words . w12 . ':' . w22 . ','
endfunction

let s:words = ''

" add custom AddPair pattern
" 2004/10/14
call <SID>AddPair('true', 'false')
call <SID>AddPair('false', 'true')
call <SID>AddPair('yes', 'no')
call <SID>AddPair('no', 'yes')
call <SID>AddPair('on', 'off')
call <SID>AddPair('off', 'on')

call <SID>AddPair('mon', 'tue')
call <SID>AddPair('tue', 'wed')
call <SID>AddPair('wed', 'thu')
call <SID>AddPair('thu', 'fri')
call <SID>AddPair('fri', 'sat')
call <SID>AddPair('sat', 'sun')
call <SID>AddPair('sun', 'mon')

call <SID>AddPair('jan', 'feb')
call <SID>AddPair('feb', 'mar')
call <SID>AddPair('mar', 'apr')
"call <SID>AddPair('apr', 'may')
"call <SID>AddPair('may', 'june')
"call <SID>AddPair('june', 'july')
"call <SID>AddPair('july', 'aug')
call <SID>AddPair('aug', 'sep')
call <SID>AddPair('sep', 'oct')
call <SID>AddPair('oct', 'nov')
call <SID>AddPair('nov', 'dec')
call <SID>AddPair('dec', 'jan')

call <SID>AddPair('public', 'protected')
call <SID>AddPair('protected', 'private')
call <SID>AddPair('private', 'public')

" default AddPair pattern
call <SID>AddPair('monday', 'tuesday')
call <SID>AddPair('tuesday', 'wednesday')
call <SID>AddPair('wednesday', 'thursday')
call <SID>AddPair('thursday', 'friday')
call <SID>AddPair('friday', 'saturday')
call <SID>AddPair('saturday', 'sunday')
call <SID>AddPair('sunday', 'monday')

call <SID>AddPair('january', 'february')
call <SID>AddPair('february', 'march')
call <SID>AddPair('march', 'april')
call <SID>AddPair('april', 'may')
call <SID>AddPair('may', 'june')
call <SID>AddPair('june', 'july')
call <SID>AddPair('july', 'august')
call <SID>AddPair('august', 'september')
call <SID>AddPair('september', 'october')
call <SID>AddPair('october', 'november')
call <SID>AddPair('november', 'december')
call <SID>AddPair('december', 'january')


function s:MakeMapping(inc_or_dec)
    if a:inc_or_dec == 'inc' || a:inc_or_dec == 'both'
        nmap <silent> <c-a> :<c-u>call <SID>IncDec('inc')<cr>
    endif
    if a:inc_or_dec == 'dec' || a:inc_or_dec == 'both'
        nmap <silent> <c-x> :<c-u>call <SID>IncDec('dec')<cr>
    endif
endfunction

function s:IncDec(inc_or_dec)
    let N = (v:count < 1) ? 1 : v:count
    let i = 0
    if a:inc_or_dec == 'inc'
        while i < N
            let w = expand('<cword>')
            if s:words =~# '\<' . w . ':'
                let n = match(s:words, w . ':\i\+\C')
                let n = match(s:words, ':', n)
                let a = matchstr(s:words, '\i\+', n)
                execute "normal ciw" . a
            else
                nunmap <c-a>
                execute "normal \<c-a>"
                call <SID>MakeMapping('inc')
            endif
            let i = i + 1
        endwhile
    else "inc_or_dec == 'dec'
        while i < N
            let w = expand('<cword>')

            if s:words =~# ':' . w . '\>'
                let n = match(s:words, '\i\+\C:' . w)
                let a = matchstr(s:words, '\i\+', n)
                execute "normal ciw" . a
            else
                nunmap <c-x>
                execute "normal \<c-x>"
                call <SID>MakeMapping('dec')
            endif
            let i = i + 1

        endwhile
    endif
endfunction

call <SID>MakeMapping('both')
