" 文字コード, 改行コード {{{
set encoding=utf-8
set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac

" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" }}}

" pathogen {{{
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
filetype on
" }}}

syntax enable
filetype plugin indent on

if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

" augroup init (from tyru's vimrc)
augroup vimrc
  autocmd!
augroup END

command!
\ -bang -nargs=*
\ MyAutocmd
\ autocmd<bang> vimrc <args>

" Basic Setting {{{
set nocompatible            " Use Vim defaults (much better!)
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set ai                      " always set autoindenting on
set backupdir=~/.vim/backup
set noswapfile              " No Swap
set backup                  " keep a backup file
set viminfo='20,\"50        " read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set history=100             " keep 100 lines of command line history
set ruler                   " show the cursor position all the time
set nu                      " show line number
set ambiwidth=double
set display=uhex            " 表示できない文字を16進数で表示
set scrolloff=5             " 常にカーソル位置から5行余裕を取る
set virtualedit=block       " 矩形選択でカーソル位置の制限を解除
set autoread                " 他でファイルが編集された時に自動で読み込む

" Edit vimrc
nnoremap [space] <Nop>
nmap     <Space> [space]
nmap [space]v :edit $MYVIMRC<CR>
nmap [space]lv :edit ~/.vimrc.local<CR>
nmap [space]g :edit $MYGVIMRC<CR>
nmap [space]lg :edit ~/.gvimrc.local<CR>
nnoremap <C-H> :<C-U>help<Space>

" 編集中の行に下線を引く
MyAutocmd InsertLeave * setlocal nocursorline
MyAutocmd InsertEnter * setlocal cursorline
MyAutocmd InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
MyAutocmd InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF


" タブストップ設定
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

" 折り畳み設定
set foldmethod=marker
nmap <silent> ,fc :<C-U>%foldclose<CR>
nmap <silent> ,fo :<C-U>%foldopen<CR>

" 検索設定
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
nohlsearch "reset highlight
nnoremap <silent> [space]/ :noh<CR>
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

" ステータスライン表示
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%{exists('*SkkGetModeStr')?SkkGetModeStr():''}%=%l/%L,%c%V%8P
set wildmenu
set cmdheight=2
set wildmode=list:full
set showcmd

" tabline
set showtabline=2
nnoremap <S-Right> :<C-U>tabnext<CR>
nnoremap <S-Left> :<C-U>tabprevious<CR>
nnoremap L :<C-U>tabnext<CR>
nnoremap H :<C-U>tabprevious<CR>

" completion
set complete=.,w,b,u,t,i,d,k

" クリップボード設定
set clipboard=unnamed

" バッファ切り替え
set hidden

" Tab表示
set list
set listchars=tab:>-,trail:<

" タイトルを表示
set title

" 対応括弧を表示
set showmatch

" 自動折り返しを日本語に対応させるスクリプト用の設定
set formatoptions+=mM

" matchitスクリプトの読み込み
source $VIMRUNTIME/macros/matchit.vim

" jkを直感的に
nnoremap <silent> j gj
nnoremap <silent> gj j
nnoremap <silent> k gk
nnoremap <silent> gk k
nnoremap <silent> $ g$
nnoremap <silent> g$ $
vnoremap <silent> j gj
vnoremap <silent> gj j
vnoremap <silent> k gk
vnoremap <silent> gk k
vnoremap <silent> $ g$
vnoremap <silent> g$ $

" JとDで半ページ移動
nnoremap J <C-D>
nnoremap K <C-U>

" 編集中のファイルのディレクトリに移動
nnoremap ,d :execute ":lcd" . expand("%:p:h")<CR>

" 最後に編集した場所にカーソルを移動する
MyAutocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" colorscheme
" 全角スペースをハイライト
MyAutocmd ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060
MyAutocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

if stridx($TERM, "xterm-256color") >= 0
  colorscheme desert256
else
  colorscheme desert
endif

" 256色モード
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif

" mark, register確認
nnoremap ,m  :<C-u>marks<CR>
nnoremap ,r  :<C-u>registers<CR>
"---------------------------------------------------------}}}

" surround.vim {{{
nmap ,( csw(
nmap ,) csw)
nmap ,{ csw{
nmap ,} csw}
nmap ,[ csw[
nmap ,] csw]
nmap ,' csw'
nmap ," csw"
"}}}

" Insert Mode Mapping {{{
inoremap <C-K> <ESC>"*pa
imap <C-E> <END>
imap <C-A> <HOME>

" }}}

" from http://vim-users.jp/2011/04/hack214/ {{{
vnoremap ( t(
vnoremap ) t)
vnoremap ] t]
vnoremap [ t[
onoremap ( t(
onoremap ) t)
onoremap ] t]
onoremap [ t[
" }}}

" set paste
nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>

" skk {{{
let skk_jisyo            = '~/.skk-jisyo'
let skk_large_jisyo      = '~/.vim/dict/skk/SKK-JISYO.L'
let skk_auto_save_jisyo  = 1
let skk_keep_state       = 0
let skk_egg_like_newline = 1
let skk_show_annotation  = 1
let skk_use_face         = 1
let skk_imdisable_state  = 0
let skk_sticky_key       = ';'
" }}}

" UTF8、SJIS(CP932)、EUCJPで開き直す {{{
command! -bang -nargs=? Utf8
	\ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
	\ edit<bang> ++enc=cp932 <args>
command! -bang -nargs=? Euc
	\ edit<bang> ++enc=eucjp <args>
" }}}

" YAMLファイル用タブストップ設定
au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8

" actionscript mxml用のファイルタイプ設定
MyAutocmd BufNewFile,BufRead *.as set filetype=actionscript
MyAutocmd BufNewFile,BufRead *.mxml set filetype=mxml

" yanktmp用キー設定
map <silent> sy :call YanktmpYank()<CR> 
map <silent> sp :call YanktmpPaste_p()<CR> 
map <silent> sP :call YanktmpPaste_P()<CR> 

" バッファ切り替え {{{
nmap [space]n :<C-U>bnext<CR>
nmap [space]p :<C-U>bprevious<CR>
nnoremap <Leader>1   :e #1<CR>
nnoremap <Leader>2   :e #2<CR>
nnoremap <Leader>3   :e #3<CR>
nnoremap <Leader>4   :e #4<CR>
nnoremap <Leader>5   :e #5<CR>
nnoremap <Leader>6   :e #6<CR>
nnoremap <Leader>7   :e #7<CR>
nnoremap <Leader>8   :e #8<CR>
nnoremap <Leader>9   :e #9<CR>
" バッファ一覧
nmap ,b :buffers<CR>
" }}}

" NERDTree
nmap <silent> ,t :NERDTreeToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1

" smartchr {{{
cnoremap <expr> (  smartchr#loop('\(', '(', {'ctype': '/?'})

function! EnableSmartchrBasic()
  inoremap <buffer> ( ()<Esc>i
  inoremap <buffer> [ []<Esc>i
  inoremap <buffer> { {}<Esc>i
  inoremap <buffer><expr> + smartchr#one_of(' + ', '+', '++')
  inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
  inoremap <buffer><expr> , smartchr#one_of(', ', ',')
  inoremap <buffer><expr> <Bar> smartchr#one_of('<Bar>', ' <Bar><Bar> ', '<Bar>')
  inoremap <expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(\*\<bar>!\)\%#')? '= ' : smartchr#one_of(' = ', ' == ', '=')
endfunction

function! EnableSmartchrRegExp()
  inoremap <buffer><expr> ~ search('\(!\<bar>=\) \%#', 'bcn')? '<bs>~ ' : '~'
endfunction

function! EnableSmartchrRubyHash()
  inoremap <buffer><expr> > smartchr#one_of('>', ' => ')
endfunction

function! EnableSmartchrCoffeeFunction()
  inoremap <buffer><expr> > smartchr#one_of('>', ' ->')
endfunction

MyAutocmd FileType c,cpp,php,python,javascript,ruby,coffee,vim call EnableSmartchrBasic()
MyAutocmd FileType python,ruby,coffee,vim call EnableSmartchrRegExp()
MyAutocmd FileType ruby call EnableSmartchrRubyHash()
MyAutocmd FileType coffee call EnableSmartchrCoffeeFunction()
" }}}

" hatena.vim
let g:hatena_user = 'joker1007'

" shファイルの保存時にはファイルのパーミッションを755にする {{{
function! ChangeShellScriptPermission()
  if !has("win32")
    if &ft =~ "\\(z\\|c\\|ba\\)\\?sh"
      call system("chmod 755 " . shellescape(expand('%:p')))
      echo "Set permission 755"
    endif
  endif
endfunction
MyAutocmd BufWritePost * call ChangeShellScriptPermission()
" }}}

" QFixHowm用設定======================================================{{{
set runtimepath+=~/qfixapp

"キーマップリーダー
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir          = '~/Dropbox/howm'
let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat   = 'dos'

if has('win32')
  let mygrepprg = 'yagrep'
elseif has('unix')
  let mygrepprg = 'grep'
endif

let QFixHowm_MruFileMax = 30

let QFixHowm_RecentMode = 2


"ブラウザの指定
if has('win32')
  let QFixHowm_OpenURIcmd = '!start "C:\firefox-3.5.3-2009100400.en-US.win32-tete009-sse2-pgo\firefox.exe" %s'
elseif has('mac')
  let QFixHowm_OpenURIcmd = "call system('/usr/bin/open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin %s')"
elseif has('unix')
  let QFixHowm_OpenURIcmd = "call system('firefox %s &')"
endif
" }}}


" ポップアップメニューのカラーを設定
hi Pmenu ctermbg=18 guibg=#666666
hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

" TOhtml
let g:html_number_lines = 0
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = 'utf-8'

" rubycomplete.vim & RSense {{{
if filereadable(expand('~/dotfiles/rsense/bin/rsense'))
  let g:rsenseUseOmniFunc = 1
  let g:rsenseHome = expand('~/dotfiles/rsense')
else
  MyAutocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
  MyAutocmd FileType ruby,eruby let g:rubycomplete_rails = 0
  MyAutocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  MyAutocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
endif
" }}}

" grep.vim
let Grep_Default_Options = '-i'
nnoremap <C-G><C-G> :<C-u>GrepBuffer<Space>
nnoremap <C-G><C-W> :<C-u>GrepBuffer<Space><C-r>= expand('<cword>')<CR>

" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
vnoremap <leader>q :QuickRun >>buffer -mode v<CR>

" poslist
nmap <C-O> <Plug>(poslist-prev-pos)
nmap <C-I> <Plug>(poslist-next-pos)
let g:poslist_histsize = 1000

" Unite.vim {{{
nnoremap [unite] <Nop>
nmap     ,u [unite]
nnoremap <silent> [unite]f   :<C-u>Unite -buffer-name=files buffer file_mru file<CR>
nnoremap <silent> [unite]vf  :<C-u>Unite -vertical -buffer-name=files buffer file_mru file<CR>
nnoremap <silent> [unite]vp  :<C-u>Unite -vertical -winwidth=45 -no-quit -buffer-name=files buffer file<CR>
nnoremap <silent> [unite]F   :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru file<CR>
nnoremap <silent> [unite]vF  :<C-u>UniteWithBufferDir -vertical -winwidth=45 -buffer-name=files buffer file_mru file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite -auto-preview -auto-resize -buffer-name=buffers -prompt=#> buffer<CR>
nnoremap <silent> [unite]vb  :<C-u>Unite -vertical -auto-preview -buffer-name=buffers -prompt=#> buffer<CR>
nnoremap <silent> [unite]"   :<C-u>Unite -buffer-name=register -prompt="> register<CR>
nnoremap <silent> [unite]c   :<C-u>Unite -buffer-name=commands history/command<CR>
nnoremap <silent> [unite]C   :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> [unite]s   :<C-u>Unite -buffer-name=snippets snippet<CR>
nnoremap <silent> [unite]u   :<C-u>Unite source<CR>        
nnoremap <silent> [unite]l   :<C-u>Unite -buffer-name=lines line<CR>
nnoremap <silent> [unite]m   :<C-u>Unite -buffer-name=bookmark -prompt=bookmark> bookmark<CR>
nnoremap <silent> [unite]rm   :<C-u>Unite -buffer-name=ref -prompt=ref> ref/man<CR>
" }}}


" Gist.vim {{{
nnoremap [gist] <Nop>
nmap ,s [gist]
nnoremap [gist]g :Gist<CR>
nnoremap [gist]p :Gist -p<CR>
nnoremap [gist]e :Gist -e<CR>
nnoremap [gist]d :Gist -d<CR>
nnoremap [gist]l :Gist -l<CR>

if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

let g:gist_detect_filetype = 1
" }}}

" Fugitive {{{
nnoremap [git] <Nop>
nmap ,g [git]
nnoremap [git]d :<C-u>Gdiff HEAD<Enter>
nnoremap [git]s :<C-u>Gstatus<Enter>
nnoremap [git]l :<C-u>Glog<Enter>
nnoremap [git]a :<C-u>Gwrite<Enter>
nnoremap [git]c :<C-u>Gcommit<Enter>
nnoremap [git]C :<C-u>Git commit --amend<Enter>
nnoremap [git]b :<C-u>Gblame<Enter>
" }}}

" project.vim
let g:proj_window_width = 48

" vimfiler {{{
nnoremap <silent> ,vf :<C-U>VimFiler<CR>
let g:vimfiler_max_directory_histories = 20
function ChangeVimfilerKeymap()
  nmap <buffer> a <Plug>(vimfiler_toggle_mark_all_lines)
  nmap <buffer> j j
  nmap <buffer> k k
  nmap <buffer> s <Plug>(vimfiler_select_sort_type)
  nmap <End> <Plug>(vimfiler_clear_mark_all_lines)
  nmap <buffer> @ <Plug>(vimfiler_set_current_mask)
endfunction
MyAutocmd FileType vimfiler call ChangeVimfilerKeymap()
" }}}

" vimshell {{{
nnoremap <silent> ,vs :<C-U>VimShell<CR>
if has('win32') || has('win64')
  " Display user name on Windows.
  let g:vimshell_prompt = $USERNAME."% "
else
  let g:vimshell_prompt = $USER . "@" . hostname() . "% "
  if has('mac')
    call vimshell#set_execute_file('html', 'gexe open -a /Applications/Firefox.app/Contents/MacOS/firefox')
    call vimshell#set_execute_file('avi,mp4,mpg,ogm,mkv,wmv,mov', 'gexe open -a /Applications/MPlayerX.app/Contents/MacOS/MPlayerX')
  endif
endif
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b] ", "(%s)-[%b|%a] ") . "[" . getcwd() . "]"'
let g:vimshell_max_command_history = 3000

MyAutocmd FileType vimshell
  \ call vimshell#altercmd#define('g', 'git')
  \| call vimshell#altercmd#define('l', 'll')
  \| call vimshell#altercmd#define('ll', 'ls -l')
  \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

function! g:my_chpwd(args, context)
  call vimshell#execute('ls')
endfunction
" }}}

" neocomplcache================================================{{{
 " Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" filename width
let g:neocomplcache_max_menu_width = 30
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_plugin_completion_length = {
\ 'snippets_complete' : 1,
\ }
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'vimshell' : $HOME . '/.vimshell/command-history',
\ }
let g:neocomplcache_snippets_dir = ''

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
"inoremap <expr><C-e> neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"setlocal completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
MyAutocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
MyAutocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
MyAutocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
MyAutocmd FileType python setlocal omnifunc=pythoncomplete#Complete
MyAutocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}

" ref.vim
let g:ref_open = 'vsplit'

" ref-rurema {{{
" options.
if !exists('g:ref_rurema_cmd')
  let g:ref_rurema_cmd = executable('rurema') ? 'rurema' : ''
endif
let s:cmd = g:ref_rurema_cmd

if !exists('g:ref_rurema_encoding')
  let g:ref_rurema_encoding = &termencoding
endif

" source define
let s:rurema_source = {'name': 'rurema'}

function! s:rurema_source.available()
  return !empty(g:ref_rurema_cmd)
endfunction

function! s:rurema_source.get_body(query)
  let res = ref#system(ref#to_list(g:ref_rurema_cmd) + ref#to_list(a:query))
  if res.stderr != ''
    throw matchstr(res.stderr, '^.\{-}\ze\n')
  endif

  let content = res.stdout

  if exists('g:ref_rurema_encoding') && !('g:ref_rurema_encoding') && g:ref_rurema_encoding != &encoding
    let converted = iconv(content, g:ref_rurema_encoding,  &encoding)
    if converted != ''
      let content = converted
    endif
  endif

  return content
endfunction

function! s:rurema_source.opened(query)
  let [type, _] = s:rurema_detect_type()
  if type ==# 'list'
    silent! %s/ /\r/ge
    silent! global/^\s*$/delete _
  endif

  call s:rurema_syntax(type)
  1
endfunction

function! s:rurema_source.get_keyword()
  let pos = getpos('.')[1:]
  if &l:filetype ==# 'ref-rurema'
    let [type, name] = s:rurema_detect_type()

    if type ==# 'list'
      return getline(pos[0])
    endif
  endif
endfunction

function! s:rurema_detect_type()
  let [l1, l2, l3] = [getline(1), getline(2), getline(3)]
  let require = l1 =~# '^require'
  let m = matchstr(require ? l3 : l1, '^\%(class\|module\|object\) \zs\S\+')
  if m != ''
    return ['class', m]
  endif

  " include builtin variable.
  let m = matchstr(require ? l3 : l2, '^--- \zs\S\+')
  if m != ''
    return ['method', m]
  endif
  return ['list', '']
endfunction

" copy from ref/autoload/refe.vim
function! s:rurema_syntax(type)
  if exists('b:current_syntax') && b:current_syntax == 'ref-rurema-' . a:type
    return
  endif

  syntax clear

  syntax include @refRuremaRuby syntax/ruby.vim

  if a:type ==# 'list'
    syntax match refRuremaClassOrMethod '^.*$' contains=@refRuremaClassSepMethod
  elseif a:type ==# 'class'
    syntax region refRuremaMethods start="^---- \w* methods .*----$" end="^$" fold contains=refRuremaMethod,refRuremaMethodHeader
    syntax match refRuremaMethod '\S\+' contained
    syntax region refRuremaMethodHeader matchgroup=refRuremaLine start="^----" end="----$" keepend oneline contained
  endif

  syntax match refRuremaClassAndMethod '\v%(\u\w*%(::|\.|#))+\h\w*[?!=~]?' contains=@refRuremaClassSepMethod
  syntax cluster refRuremaClassSepMethod contains=refRuremaCommonClass,refRuremaCommonMethod,refRuremaCommonSep

  syntax match refRuremaCommonSep '::\|#' contained nextgroup=refRuremaCommonClass,refRuremaCommonMethod
  syntax match refRuremaCommonClass '\u\w*' contained nextgroup=refRuremaCommonSep
  syntax match refRuremaCommonMethod '[[:lower:]_]\w*[?!=~]\?' contained


  highlight default link refRuremaMethodHeader rubyClass
  highlight default link refRuremaMethod rubyFunction
  highlight default link refRuremaLine rubyOperator

  highlight default link refRuremaCommonSep rubyOperator
  highlight default link refRuremaCommonClass rubyClass
  highlight default link refRuremaCommonMethod rubyFunction

  " Copy from syntax/ruby.vim
  syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<\z(\h\w*\)\ze+hs=s+2    matchgroup=rubyStringDelimiter end=+^ \{2}\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
  syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<"\z([^"]*\)"\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^ \{2}\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend
  syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<'\z([^']*\)'\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^ \{2}\z1$+ contains=rubyHeredocStart		      fold keepend
  syn region rubyString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<`\z([^`]*\)`\ze+hs=s+2  matchgroup=rubyStringDelimiter end=+^ \{2}\z1$+ contains=rubyHeredocStart,@rubyStringSpecial fold keepend

  syntax region refRuremaRubyCodeBlock
  \      start=/^ \{2,4}\ze\S/
  \      end=/\n\+\ze \{,1}\S/ contains=@refRuremaRuby

  syntax match refRefeTitle "^===.\+$"
  highlight default link refRefeTitle Statement

  if a:type ==# 'method'
    syntax match refRuremaMethod '^--- \w\+[!?]'
    highlight default link refRuremaMethod Function
  endif

  let b:current_syntax = 'ref-rurema-' . a:type
endfunction

call ref#register(s:rurema_source)
call ref#register_detection('ruby', 'rurema', 'overwrite')

function! RefRuremaFromCurrentWord()
  let word = expand("<cword>")
  call ref#open("rurema", word)
endfunction

function! RefRuremaFromSelectWord()
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  call ref#open("rurema", selected)
endfunction

nnoremap [ref] <Nop>
nmap     ,r [ref]
MyAutocmd FileType ruby,ref-rurema nnoremap <buffer><silent> [ref]<C-R> :<C-U>call RefRuremaFromCurrentWord()<CR>
MyAutocmd FileType ruby,ref-rurema xnoremap <buffer><silent> <C-R> :<C-U>call RefRuremaFromSelectWord()<CR>

" }}}

" indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=DarkGrey   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=DarkCyan ctermbg=12
" }}}

" submode.vim {{{
let g:submode_timeout = 0
call submode#enter_with('window/manip', 'n', '', '<Leader>w')
call submode#enter_with('window/manip', 'n', '', '<C-W>-', '<C-W>-')
call submode#enter_with('window/manip', 'n', '', '<C-W>+', '<C-W>+')
call submode#enter_with('window/manip', 'n', '', '<C-W>>', '<C-W>>')
call submode#enter_with('window/manip', 'n', '', '<C-W><', '<C-W><')
call submode#leave_with('window/manip', 'n', '', '<Esc>')
call submode#map('window/manip', 'n', '', '-', '<C-W>-')
call submode#map('window/manip', 'n', '', '+', '<C-W>+')
call submode#map('window/manip', 'n', '', '<', '<C-W><')
call submode#map('window/manip', 'n', '', '>', '<C-W>>')
call submode#map('window/manip', 'n', '', '=', '<C-W>=')
call submode#map('window/manip', 'n', '', 'r', '<C-W>r')
call submode#map('window/manip', 'n', '', 'R', '<C-W>R')
call submode#map('window/manip', 'n', '', 'x', '<C-W>x')
call submode#map('window/manip', 'n', '', 'j', '<C-W>j')
call submode#map('window/manip', 'n', '', 'k', '<C-W>k')
call submode#map('window/manip', 'n', '', 'l', '<C-W>l')
call submode#map('window/manip', 'n', '', 'h', '<C-W>h')
" }}}

" vim-altr {{{
nmap <F3> <Plug>(altr-forward)
nmap <F2> <Plug>(altr-back)

" For ruby tdd
call altr#define('%.rb', 'spec/%_spec.rb')
" For rails tdd
call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')

" }}}

" toggle.vim {{{
imap <C-C> <Plug>ToggleI
nmap <C-C> <Plug>ToggleN
vmap <C-C> <Plug>ToggleV

let g:toggle_pairs = { 'and':'or', 'or':'and', 'if':'elsif', 'elsif':'else', 'else':'if', 'it':'specify', 'specify':'it', 'describe':"context", "context":"describe" }
" }}}
