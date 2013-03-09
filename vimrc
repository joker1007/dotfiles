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

" for MacVim with rvm
if has('gui_macvim') && has('kaoriya')
  set shell=/bin/bash
endif

" Edit vimrc
nnoremap [space] <Nop>
nmap     <Space> [space]
xmap     <Space> [space]
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
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%{tagbar#currenttag('[%s]','')}%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%{exists('*SkkGetModeStr')?SkkGetModeStr():''}%=%l/%L,%c%V%8P\ 
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
" nnoremap ,m  :<C-u>marks<CR>
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

" wq alias
command! -nargs=0 Wq wq

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
nmap <silent> <Leader>t :NERDTreeToggle<CR>

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
  inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(\*\<bar>!\)\%#')? '= ' : smartchr#one_of(' = ', ' == ', '=')
endfunction

function! EnableSmartchrRegExp()
  inoremap <buffer><expr> ~ search('\(!\<bar>=\) \%#', 'bcn')? '<bs>~ ' : '~'
endfunction

function! EnableSmartchrRubyHash()
  inoremap <buffer><expr> > smartchr#one_of('>', ' => ')
endfunction

function! EnableSmartchrHaml()
  call EnableSmartchrRubyHash()
  inoremap <buffer> [ []<Esc>i
  inoremap <buffer> { {}<Esc>i
endfunction

function! EnableSmartchrCoffeeFunction()
  inoremap <buffer><expr> > smartchr#one_of('>', ' ->')
endfunction

MyAutocmd FileType c,cpp,php,python,javascript,ruby,coffee,vim call EnableSmartchrBasic()
MyAutocmd FileType python,ruby,coffee,vim call EnableSmartchrRegExp()
MyAutocmd FileType ruby call EnableSmartchrRubyHash()
MyAutocmd FileType ruby,eruby setlocal tags+=~/rtags
MyAutocmd FileType haml call EnableSmartchrHaml()
MyAutocmd FileType coffee call EnableSmartchrCoffeeFunction()
" }}}

" hatena.vim
let g:hatena_user = 'joker1007'

" shファイルの保存時にはファイルのパーミッションを755にする {{{
function! ChangeShellScriptPermission()
  if !has("win32")
    if &ft =~ "\\(z\\|c\\|ba\\)\\?sh$" && expand('%:t') !~ "\\(zshrc\\|zshenv\\)$"
      call system("chmod 755 " . shellescape(expand('%:p')))
      echo "Set permission 755"
    endif
  endif
endfunction
MyAutocmd BufWritePost * call ChangeShellScriptPermission()
" }}}

" QFixHowm用設定======================================================{{{
set runtimepath+=~/qfixapp

" ファイル拡張子をmkdにする
let howm_filename = '%Y-%m-%d-%H%M%S.mkd'
" ファイルタイプをmarkdownにする
let QFixHowm_FileType = 'markdown'
" 折り畳み正規表現
let QFixHowm_FoldingPattern = '^[=.*#]'

" タイトル記号
let QFixHowm_Title = '#'

"キーマップリーダー
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir          = '~/Dropbox/howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat   = 'unix'

if has('win32')
  let mygrepprg = 'yagrep'
elseif has('unix')
  let mygrepprg = 'grep'
endif

let QFixHowm_MruFileMax = 30

let QFixHowm_RecentMode = 2

" リネーム後のファイル名制限
let QFixHowm_FilenameLen = 80


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

" grep.vim
let Grep_Default_Options = '-i'
nnoremap <C-G><C-G> :<C-u>GrepBuffer<Space>
nnoremap <C-G><C-W> :<C-u>GrepBuffer<Space><C-r>= expand('<cword>')<CR>

" quickrun
MyAutocmd FileType quickrun AnsiEsc

vnoremap <leader>q :QuickRun >>buffer -mode v<CR>
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec %c %o --color --drb --tty %s'
  \}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'outputter': 'buffer',
  \ 'exec': '%c %o --color --drb --tty %s'
  \}
let g:quickrun_config['rspec/zeus'] = {
  \ 'type': 'rspec/zeus',
  \ 'command': 'rspec',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec zeus test %o --color --tty %s'
  \}
let g:quickrun_config['rspec/spring'] = {
  \ 'type': 'rspec/spring',
  \ 'command': 'rspec',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec spring rspec %o --color --tty %s'
  \}
let g:quickrun_config['cucumber/bundle'] = {
  \ 'type': 'cucumber/zeus',
  \ 'command': 'cucumber',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec %c %o --color --drb %s'
  \}
let g:quickrun_config['cucumber/zeus'] = {
  \ 'type': 'cucumber/zeus',
  \ 'command': 'cucumber',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec zeus cucumber %o --color %s'
  \}
let g:quickrun_config['cucumber/spring'] = {
  \ 'type': 'cucumber/spring',
  \ 'command': 'cucumber',
  \ 'outputter': 'buffer',
  \ 'exec': 'bundle exec spring cucumber %o --color %s'
  \}
function! RSpecQuickrun()
  if exists('g:use_spring_rspec')
    let b:quickrun_config = {'type' : 'rspec/spring'}
  elseif exists('g:use_zeus_rspec')
    let b:quickrun_config = {'type' : 'rspec/zeus'}
  else
    let b:quickrun_config = {'type' : 'rspec/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
endfunction
MyAutocmd BufReadPost *_spec.rb call RSpecQuickrun()

function! CucumberQuickrun()
  if exists('g:use_spring_cucumber')
    let b:quickrun_config = {'type' : 'cucumber/spring'}
  elseif exists('g:use_zeus_cucumber')
    let b:quickrun_config = {'type' : 'cucumber/zeus'}
  else
    let b:quickrun_config = {'type' : 'cucumber/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
endfunction
MyAutocmd BufReadPost *.feature call CucumberQuickrun()

function! SetUseSpring()
  let g:use_spring_rspec = 1
  let g:use_spring_cucumber = 1
endfunction

function! SetUseZeus()
  let g:use_zeus_rspec = 1
  let g:use_zeus_cucumber = 1
endfunction

command! -nargs=0 UseSpring call SetUseSpring()
command! -nargs=0 UseZeus call SetUseZeus()

" libruby load
if has('gui_macvim') && has('kaoriya')
  let s:ruby_libdir = system("ruby -rrbconfig -e 'print RbConfig::CONFIG[\"libdir\"]'")
  let s:ruby_libruby = s:ruby_libdir . '/libruby.dylib'
  if filereadable(s:ruby_libruby)
    let $RUBY_DLL = s:ruby_libruby
  endif
endif

" poslist
nmap <C-O> <Plug>(poslist-prev-pos)
nmap <C-I> <Plug>(poslist-next-pos)
let g:poslist_histsize = 2000

" Unite.vim {{{
nnoremap [unite] <Nop>
nmap     ,u [unite]
nnoremap <silent> [unite]ff   :<C-u>Unite -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]fr   :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> [unite]fa   :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> [unite]d   :<C-u>Unite -buffer-name=files directory_mru<CR>
nnoremap <silent> [unite]vff  :<C-u>Unite -vertical -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]vfr  :<C-u>Unite -vertical -buffer-name=files file_mru <CR>
nnoremap <silent> [unite]vp  :<C-u>Unite -vertical -winwidth=45 -no-quit -buffer-name=files buffer file<CR>
nnoremap <silent> [unite]F   :<C-u>UniteWithBufferDir -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]vF  :<C-u>UniteWithBufferDir -vertical -winwidth=45 -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]b   :<C-u>Unite -buffer-name=buffers -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vb  :<C-u>Unite -vertical -buffer-name=buffers -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vB  :<C-u>Unite -vertical -buffer-name=buffers -prompt=Buffer>\  -winwidth=45 -no-quit buffer<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -vertical -winwidth=35 -no-quit -toggle -buffer-name=outline outline<CR>
nnoremap <silent> [unite]"   :<C-u>Unite -buffer-name=register -prompt=">\  register<CR>
nnoremap <silent> [unite]c   :<C-u>Unite -buffer-name=commands history/command<CR>
nnoremap <silent> [unite]C   :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> [unite]s   :<C-u>Unite -buffer-name=snippets snippet<CR>
nnoremap <silent> [unite]u   :<C-u>Unite source<CR>
nnoremap <silent> [unite]l   :<C-u>Unite -buffer-name=lines line<CR>
nnoremap <silent> [unite]m   :<C-u>Unite -buffer-name=bookmark -prompt=bookmark> bookmark<CR>
nnoremap <silent> [unite]rm   :<C-u>Unite -buffer-name=ref -prompt=ref> ref/man<CR>
nnoremap <silent> [unite]g   :<C-u>Unite -buffer-name=grep grep<CR>
nnoremap <silent> [unite]gg  :<C-u>Unite -buffer-name=grep vcs_grep/git -start-insert<CR>
nnoremap <silent> [unite]hd   :<C-u>Unite haddock -start-insert<CR>

let g:unite_winheight = 15
let g:unite_source_grep_max_candidates = 500

call unite#custom_default_action('source/bookmark/directory', 'vimfiler')

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

" ftdetect is often failed
MyAutocmd BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif
MyAutocmd BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif
" }}}

" project.vim
let g:proj_window_width = 48

" vimfiler {{{
let g:vimfiler_as_default_explorer = 1
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
"let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b] ", "(%s)-[%b|%a] ") . "[" . getcwd() . "]"'
let g:vimshell_right_prompt = '"[" . getcwd() . "]"'
let g:vimshell_max_command_history = 3000

MyAutocmd FileType vimshell
  \ call vimshell#altercmd#define('g', 'git')
  \| call vimshell#altercmd#define('l', 'll')
  \| call vimshell#altercmd#define('ll', 'ls -l')
  \| call vimshell#altercmd#define('be', 'bundle exec')
  \| call vimshell#altercmd#define('ra', 'rails')
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
"let g:neocomplcache_enable_underbar_completion = 1
" Use fuzzy completion.
" let g:neocomplcache_enable_fuzzy_completion = 1
" filename width
let g:neocomplcache_max_menu_width = 40
" Set minimum syntax keyword length.
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_plugin_completion_length = {
\ 'snippets_complete' : 1,
\ }
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_prefetch = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'vimshell' : $HOME . '/.vimshell/command-history',
\ }

let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'
nnoremap <Space>se :<C-U>NeoSnippetEdit<CR>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" キャッシュしないファイル名
let g:neocomplcache_disable_caching_file_path_pattern = '\.log\|\.log\.\|\.jax'
" 自動補完を行わないバッファ名
let g:neocomplcache_lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

" rubycomplete.vim & RSense {{{
if filereadable(expand('~/dotfiles/rsense/bin/rsense'))
  let g:rsenseHome = expand('~/dotfiles/rsense')
  let g:rsenseUseOmniFunc = 1
  if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
  endif
  let g:neocomplcache_omni_functions.ruby = 'RSenseCompleteFunction'
else
  MyAutocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
  MyAutocmd FileType ruby,eruby let g:rubycomplete_rails = 0
  MyAutocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  MyAutocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
endif
" MyAutocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
" MyAutocmd FileType ruby,eruby let g:rubycomplete_rails = 0
" MyAutocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" MyAutocmd FileType ruby,eruby let g:rubycomplete_include_object = 0
" MyAutocmd FileType ruby,eruby let g:rubycomplete_include_object_space = 0
" MyAutocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 0
" let ruby_operators = 1

" enable ruby & rails snippet only rails file
MyAutocmd BufEnter * if exists("b:rails_root") && (&filetype == "ruby") | NeoComplCacheSetFileType ruby.rails | endif
MyAutocmd BufEnter * if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | NeoComplCacheSetFileType ruby.rspec | endif
" }}}


" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
" }}}

" ref.vim
let g:ref_open = 'vsplit'
let g:ref_refe_cmd = "rurema"
let g:ref_refe_version = 2
let g:ref_refe_rsense_cmd = g:rsenseHome . "/bin/rsense"

let g:ref_source_webdict_sites = {
\   'wikipedia:ja': 'http://ja.wikipedia.org/wiki/%s',
\   'weblio': 'http://ejje.weblio.jp/content/%s',
\ }

nmap ,rr :<C-U>Ref refe<Space>

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

let g:toggle_pairs = { 'and':'or', 'or':'and', 'if':'unless', 'unless':'elsif', 'elsif':'else', 'else':'if', 'it':'specify', 'specify':'it', 'describe':"context", 'context':"describe", 'true':'false', 'false':'true', '&&':'||', '||':'&&' }
" }}}

" RSpec syntax {{{
function! RSpecSyntax()
  hi def link rubyRailsTestMethod             Function
  syn keyword rubyRailsTestMethod describe context it its specify shared_examples_for shared_examples shared_context it_should_behave_like it_behaves_like before after around subject fixtures controller_name helper_name include_context include_examples
  syn match rubyRailsTestMethod '\<let\>!\='
  syn keyword rubyRailsTestMethod violated pending expect double mock mock_model stub_model
  syn match rubyRailsTestMethod '\.\@<!\<stub\>!\@!'
endfunction
MyAutocmd Syntax ruby if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | call RSpecSyntax() | endif
" }}}

" Monit syntax {{{
function! MonitSyntax()
  syn keyword monitCommand set check include
  syn keyword monitSubject directory fifo file filesystem host process system nextgroup=monitIdentifier skipwhite
  syn keyword monitKeyword pidfile path nextgroup=monitFilePath skipwhite
  syn keyword monitKeyword alert noalert system logfile
  syn keyword monitKeyword group failed port checksum start stop restart
  syn keyword monitKeyword program daemon space usage
  syn keyword monitKeyword timeout restarts within cycles
  syn keyword monitCondition if then else
  syn keyword monitKeyword depends
  syn keyword monitChecksum md5 sha1

  syn keyword monitKeyword type nextgroup=monitSocket
  syn keyword monitSocket tcp udp tcpssl

  syn keyword monitKeyword proto protocol nextgroup=monitProtocol
  syn keyword monitProtocol https ssl http ftp smtp pop ntp3 nntp imap clamav ssh dwp ldap2 ldap3 tns contained

  syn keyword monitKeyword logfile syslog address enable disable pemfile allow read-only check init count pidfile statefile group start stop uid gid connection port portnumber unix unixsocket mail-format resource expect send mailserver every mode active passive manual depends host default request cpu mem totalmem children loadavg timestamp changed second seconds minute minutes hour hours day days inode pid ppid perm permission icmp process file directory filesystem size action unmonitor rdate rsync data invalid exec nonexist policy reminder instance eventqueue basedir slot slots system idfile gps radius secret target maxforward hostheader
  syn keyword monitNoise is as are on only with within and has using use the sum program programs than for usage was but of

  syn keyword monitKeyword url nextgroup=monitUrl
  syn match monitUrl "[a-z]\+://.\+"


  syn match monitIdentifier "[a-zA-Z0-9\-\.]\+"
  syn match monitFilePath "[/a-zA-Z0-9-\.]\+"
  syn match monitNumber "\d\+"
  syn match monitComment "#.*$"

  syn region monitString start='"' end='"'

  let b:current_syntax = "monitrc"

  hi def link monitCommand Function
  hi def link monitComment Comment
  hi def link monitCondition Conditional
  hi def link monitFilePath Identifier
  hi def link monitIdentifier Identifier
  hi def link monitKeyword Statement
  hi def link monitNoise Normal
  hi def link monitNumber Number
  hi def link monitProtocol Structure
  hi def link monitString String
  hi def link monitSubject Type
endfunction

au FileType monitrc call MonitSyntax()
" }}}

" Quickfix
augroup quickfixopen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END

nnoremap <silent> ,q :<C-U>copen<CR>
nnoremap <silent> ]q :<C-U>cnext<CR>
nnoremap <silent> [q :<C-U>cprev<CR>
nnoremap <silent> ]Q :<C-U>clast<CR>
nnoremap <silent> [Q :<C-U>cfirst<CR>

" errormarker.vim
let errormarker_disablemappings = 1

" Merge Setting
if &diff
  nmap <buffer> <leader>1 :diffget LOCAL<CR>
  nmap <buffer> <leader>2 :diffget BASE<CR>
  nmap <buffer> <leader>3 :diffget REMOTE<CR>
endif

" ctags
nnoremap <leader>lt :set tags+=**/tags<CR>

" TagBar
nnoremap <silent> ,t :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_updateonsave_maxlines = 10000
let g:tagbar_sort = 0

" Tabular
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" gundo
nnoremap U :<C-U>GundoToggle<CR>

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

" for Haskell
function! GhcModSetting()
  nnoremap <buffer> ,mt :<C-U>GhcModType<CR>
  nnoremap <buffer> ,mc :<C-U>GhcModTypeClear<CR>
  nnoremap <buffer> ,ml :<C-U>GhcModLintAsync<CR>
endfunction
MyAutocmd FileType haskell call GhcModSetting()

let g:haskell_conceal = 0

" syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['haskell'] }

" unite-ruby-require
let g:unite_source_ruby_require_ruby_command = '$HOME/.rbenv/shims/ruby'

" ft hamstache
function! HamstacheSyntax()
   let &filetype = "haml"
endfunction
MyAutocmd BufReadPost *.hamstache call HamstacheSyntax()

" ag.vim
let g:agprg="--nocolor --nogroup --column"

" ruby buffer
if has('ruby')
    nnoremap <silent> [space]r :set operatorfunc=Ruby<CR>g@
    nnoremap <silent> [space]rr :call RubyLines()<CR>
    nmap [space]R [space]r$
    nnoremap <silent> [space]rp :<C-u>call RubyPaste()<CR>

    xnoremap <silent> [space]r :<C-u>call Ruby(visualmode(), 1)<CR>
    xnoremap <silent> [space]R :<C-u>call Ruby('V', 1)<CR>

    command! -range Ruby :<line1>,<line2>call RubyLines()
    command! -range RubyPaste :<line1>,<line2>call RubyPaste()

    let s:ruby_buffer = ""

    ruby <<RUBY
class VimRuby
    @@binding = binding

    def VimRuby.evaluate(code)
        result = eval(code, @@binding)

        if result.instance_of?(String)
            str = result.gsub(/"/, '\\"')
            VIM.command(%(let s:ruby_buffer = "#{str}" . "\n"))
        else
            str = result.inspect.gsub(/"/, '\\"')
            VIM.command(%(let s:ruby_buffer = '#{str}' . "\n"))
        end

        return result
    end
end
RUBY

    function! RubyEval(code)
        ruby p VimRuby.evaluate(VIM.evaluate("a:code"))
    endfunction

    function! Ruby(type, ...)
        let saved_sel = &selection
        let &selection = "inclusive"
        let saved_reg = @*

        if a:0
            silent exe "normal! `<" . a:type . "`>y"
        elseif a:type == 'line'
            silent exe "normal! '[V']y"
        elseif a:type == 'block'
            silent exe "normal! `[\<C-v>`]y"
        else
            silent exe "normal! `[v`]y"
        endif

        call RubyEval(@*)

        let &selection = saved_sel
        let @* = saved_reg
    endfunction

    function! RubyLines() range
        let lines = getline(a:firstline, a:lastline)
        let code = join(lines, "\n")
        call RubyEval(code)
    endfunction

    function! RubyPaste()
        let saved_reg = @*
        let @* = s:ruby_buffer
        normal! p
        let @* = saved_reg
    endfunction
endif

