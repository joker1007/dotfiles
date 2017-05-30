if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim/
endif

" charset {{{
set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac

if has('guess_encode')
  set fileencodings=guess
else
  set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2

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
endif

" NeoBundle {{{
" if dein#load_state(expand('~/.vim/bundle/'))
call dein#begin(expand('~/.vim/bundle/'))

call dein#add('Shougo/vimproc', {'build': 'make'})
call dein#add('tyru/eskk.vim', {'on_i' : 1})
call dein#add('tyru/skkdict.vim')

call dein#add('scrooloose/nerdcommenter', {
\   'on_map' : [
      \'\cc',
      \'\cn',
      \'\c<space>',
      \'\cm',
      \'\ci',
      \'\cs',
      \'\cy',
      \'\c$',
      \'\cA',
      \'\ca'
\   ],
\})

call dein#add('thinca/vim-prettyprint')
call dein#add('mhinz/vim-startify')
call dein#add('hecal3/vim-leader-guide')

call dein#add('moro/vim-review')
call dein#add('cespare/vim-toml')

call dein#add('kana/vim-submode')

call dein#add('tpope/vim-markdown')
call dein#add('mattn/vim-maketable', {'on_ft' : ['markdown']})

call dein#add('joker1007/vim-ruby-heredoc-syntax', {'on_ft' : ['ruby', 'eruby']})

call dein#add('joker1007/vim-markdown-quote-syntax', {'on_ft' : ['markdown']})

call dein#add('pangloss/vim-javascript')
call dein#add('elzr/vim-json')
call dein#add('mxw/vim-jsx')

" colorschemes plugin {{{
call dein#add('baskerville/bubblegum')
call dein#add('nanotech/jellybeans.vim')
call dein#add('w0ng/vim-hybrid')
call dein#add('vim-scripts/twilight')
call dein#add('jonathanfilip/vim-lucius')
call dein#add('jpo/vim-railscasts-theme')
call dein#add('29decibel/codeschool-vim-theme')
call dein#add('joshdick/onedark.vim')
call dein#add('MaxSt/FlatColor')
" }}}

" ruby rails develop {{{
call dein#add('tpope/vim-rails')
call dein#add('vim-ruby/vim-ruby')
call dein#add('tpope/vim-cucumber')
call dein#add('thinca/vim-quickrun', {'depends' : 'vimproc'})
call dein#add('kchmck/vim-coffee-script')
call dein#add('carlosvillu/coffeScript-VIM-Snippets')

call dein#add('leafgarland/typescript-vim')
call dein#add('clausreinke/typescript-tools.vim')
" }}}

" ref {{{
call dein#add('thinca/vim-ref')
call dein#add('taka84u9/vim-ref-ri')
call dein#add('ujihisa/ref-hoogle')
" }}}

" vim-scripts {{{
call dein#add('vim-scripts/surround.vim')
call dein#add('LeafCage/yankround.vim')
" call dein#add('vim-scripts/grep.vim'
call dein#add('vim-scripts/sudo.vim')
call dein#add('vim-scripts/errormarker.vim')
call dein#add('powerman/vim-plugin-AnsiEsc')
"}}}

" smartchr textobj {{{
call dein#add('kana/vim-smartchr')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-niceblock')
call dein#add('nelstrom/vim-textobj-rubyblock', {'on_ft' : ['ruby']})
call dein#add('kana/vim-textobj-indent')
" }}}


" html template {{{
call dein#add('mattn/emmet-vim', {'on_i' : 1})
call dein#add('claco/jasmine.vim')
call dein#add('digitaltoad/vim-jade')
call dein#add('slim-template/vim-slim')
call dein#add('tpope/vim-haml')
call dein#add('nono/vim-handlebars')
call dein#add('juvenn/mustache.vim')
" }}}

" visibility {{{
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('LeafCage/foldCC')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('osyo-manga/vim-over', {
      \ 'on_cmd' : ['OverCommandLine', 'OverCommandLineNoremap', 'OverCommandLineMap', 'OverCommandLineUnmap']
\})
" }}}

" haskell develop {{{
call dein#add('dag/vim2hs')
call dein#add('pbrisbin/html-template-syntax')

call dein#add('eagletmt/ghcmod-vim', {'on_ft' : [ "haskell" ]})

call dein#add('ujihisa/neco-ghc', {'on_ft' : [ "haskell" ]})
" }}}

" web browse, api {{{
call dein#add('tyru/open-browser.vim')
call dein#add('mattn/webapi-vim')
call dein#add('kannokanno/previm', {'on_cmd' : ['PrevimOpen']})
" }}}

" other programinng {{{
call dein#add('godlygeek/tabular')
call dein#add('scrooloose/syntastic')
call dein#add('rhysd/github-complete.vim')
call dein#add('hashivim/vim-terraform')
call dein#add('Shougo/vinarise.vim')

call dein#add('rking/ag.vim', {
      \ 'on_cmd' : [
        \ 'Ag',
        \ 'AgBuffer',
        \ 'AgAdd',
        \ 'AgFromSearch',
        \ 'LAg',
        \ 'LAgBuffer',
        \ 'LAgAdd',
        \ 'LAgFile',
        \ 'AgHelp',
        \ 'LAgHelp',
      \ ]
\})
call dein#add('majutsushi/tagbar', {
      \ 'on_cmd' : [
        \ 'TagbarOpen',
        \ 'TagbarToggle',
        \ 'TagbarOpenAutoClose',
        \ 'TagbarTogglePause',
        \ 'TagbarCurrentTag',
        \ 'TagbarShowTag',
        \ 'TagbarGetTypeConfig',
      \ ]
\})
call dein#add('thinca/vim-qfreplace', { 'on_cmd' : ['Qfreplace'] })
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('derekwyatt/vim-scala')
call dein#add('rust-lang/rust.vim')
call dein#add('derekwyatt/vim-sbt')
call dein#add('elixir-lang/vim-elixir')
call dein#add('fatih/vim-go')
call dein#add('rhysd/devdocs.vim')
call dein#add('othree/html5.vim')
call dein#add('JulesWang/css.vim')
call dein#add('moskytw/nginx-contrib-vim')
call dein#add('supermomonga/shiraseru.vim', {'depends' : 'vimproc'})
if has('mac')
  call dein#add('rhysd/quickrun-mac_notifier-outputter', {'depends' : 'vim-quickrun'})
endif
call dein#add('osyo-manga/shabadou.vim')
call dein#add('joker1007/quickrun-rspec-notifier', {'depends' : 'vim-quickrun'})
call dein#add('superbrothers/vim-quickrun-markdown-gfm', {'on_ft': 'markdown'})
call dein#add('kana/vim-metarw')
call dein#add('joker1007/vim-metarw-qiita')
call dein#add('joker1007/vim-metarw-github-issues')
call dein#add('lilydjwg/colorizer')
call dein#add('pasela/unite-webcolorname')
call dein#add('mattn/httpstatus-vim')
call dein#add('tmux-plugins/vim-tmux')
call dein#add('haya14busa/incsearch.vim')
call dein#add('eugen0329/vim-esearch')
call dein#add('fuenor/qfixhowm')

call dein#add('vim-scripts/SQLUtilities')
call dein#add('vim-scripts/dbext.vim')
call dein#add('exu/pgsql.vim')
call dein#add('ternjs/tern_for_vim', {'build': 'npm install'})

call dein#add('AndrewRadev/switch.vim', {
\   'on_cmd' : [ "Switch" ],
\   'on_func' : [ "switch#Switch" ],
\})

call dein#add('sjl/gundo.vim', {
\   'on_cmd' : [ "GundoShow", "GundoToggle" ]
\})

call dein#add('kana/vim-altr', {
\   'on_map' : ['<Plug>(altr-forward)', '<Plug>(altr-back)'],
\})

call dein#add('osyo-manga/vim-anzu', {
\   'on_map' : [
      \'<Plug>(anzu-n-with-echo)',
      \'<Plug>(anzu-N-with-echo)',
      \'<Plug>(anzu-star-with-echo)',
      \'<Plug>(anzu-sharp-with-echo)'
\   ],
\})

call dein#add("osyo-manga/vim-gyazo", {
\   'on_cmd' : [ "GyazoPost", "GyazoOpenBrowser", "GyazoTweetVim", "GyazoOpenBrowserCurrentWindow", "GyazoTweetVimCurrentWindow" ]
\})
" }}}

" tweetvim {{{
call dein#add('basyura/bitly.vim')
call dein#add('mattn/favstar-vim')
call dein#add('basyura/twibill.vim')
call dein#add('basyura/TweetVim', {
\   'rev': 'dev',
\   'depends' : ['twibill.vim', 'open-browser.vim' ],
\   'on_cmd' : [ "TweetVimHomeTimeline", "TweetVimSay", "TweetVimUserStream", "TweetVimUserTimeline" ]
\})
" }}}

" cursor move {{{
" call dein#add('osyo-manga/vim-milfeulle'
call dein#add('thinca/vim-visualstar')
" call dein#add('rhysd/accelerated-jk')
" call dein#add('yonchu/accelerated-smooth-scroll')

call dein#add('Lokaltog/vim-easymotion', {
\   'on_map' : [
      \'\\w',
      \'\\t',
      \'\\n',
      \'\\k',
      \'\\j',
      \'\\f',
      \'\\e',
      \'\\b',
      \'\\W',
      \'\\T',
      \'\\N',
      \'\\F',
      \'\\B'
\   ],
\})
" }}}

" git {{{
call dein#add('tpope/vim-fugitive', {'augroup' : 'fugitive'})
call dein#add('gregsexton/gitv', {'on_cmd' : ['Gitv']})
call dein#add('airblade/vim-gitgutter')

call dein#add('mattn/gist-vim', {
\     'on_cmd' : [ "Gist" ]
\})

call dein#add('lambdalisue/vim-gista', {
\     'on_cmd' : [ "Gista" ]
\})
" }}}

" unite {{{
call dein#add('tsukkee/unite-help')
call dein#add('ujihisa/unite-gem')
call dein#add('thinca/vim-unite-history')
call dein#add('Shougo/unite-outline')
call dein#add('eagletmt/unite-haddock')
call dein#add('ujihisa/unite-haskellimport')
call dein#add('tsukkee/unite-tag')
call dein#add('rhysd/unite-ruby-require.vim')
call dein#add('joker1007/unite-pull-request')
call dein#add('osyo-manga/unite-quickrun_config')
call dein#add('Shougo/neomru.vim')

call dein#add('Shougo/unite.vim', {
\   'name' : 'unite',
\})

call dein#add('Shougo/denite.nvim', {
\   'name' : 'denite',
\   'on_cmd' : [ "Denite", "DeniteBufferDir" ]
\})
" }}}

" neocon {{{
call dein#add('justmao945/vim-clang')

call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet', {
  \   'depends' : ["neosnippet-snippets"]
\})
if has('lua')
  call dein#add('Shougo/neocomplete', {
  \   'depends' : ['neosnippet', 'context_filetype.vim'],
  \   'on_i' : 1,
  \})
elseif has('nvim')
  call dein#add('Shougo/deoplete.nvim')
else
  call dein#add('Shougo/neocomplcache', {
  \   'depends' : ["neosnippet"],
  \   'on_i' : 1,
  \})
endif
" }}}

" vimshell, vimfiler {{{
call dein#add('Shougo/vimfiler', {
\   'depends' : ["unite"],
\   'on_cmd' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
\   'on_map' : ['<Plug>(vimfiler_switch)'],
\})

call dein#add('Shougo/vimshell', {
      \ 'depends' : 'vimproc',
      \ 'on_cmd' : ['VimShell', 'VimShellExecute', 'VimShellInteractive',
      \            'VimShellTerminal', 'VimShellPop'],
      \ 'on_map' : ['<Plug>(vimshell_switch)']
      \ })
call dein#add('mattn/vim-sonots')

" }}}

" neovim {{{
if has('nvim')
  call dein#add('kassio/neoterm')
  call dein#add('janko-m/vim-test')
  call dein#add('brettanomyces/nvim-editcommand')
  call dein#add('euclio/vim-markdown-composer', {'build': 'cargo build --release'})
endif
" }}}

call dein#end()
call dein#save_state()
" endif
autocmd VimEnter * call dein#call_hook('post_source')
" }}}

filetype plugin indent on

if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

" augroup init (from tyru's vimrc)
augroup vimrc
  autocmd!
augroup END

" vim-leader-guide
let g:lmap =  {}
map <leader>. <Plug>leaderguide-global

command!
\ -bang -nargs=*
\ MyAutocmd
\ autocmd<bang> vimrc <args>

" Basic Setting {{{
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set ai                      " always set autoindenting on
set nobackup
set noswapfile              " No Swap
if has('nvim')
  set viminfo='100,<1000,:10000,h
else
  set viminfo='100,<1000,h
endif
set history=10000           " keep 10000 lines of command line history
set ruler                   " show the cursor position all the time
set nu                      " show line number
set ambiwidth=double
set display=uhex            " 表示できない文字を16進数で表示
set scrolloff=5             " 常にカーソル位置から5行余裕を取る
set virtualedit=block       " 矩形選択でカーソル位置の制限を解除
set autoread                " 他でファイルが編集された時に自動で読み込む
set background=dark
set ttimeout
set ttimeoutlen=100

" Space prefix
nnoremap [space] <Nop>
nmap     <Space> [space]
xmap     <Space> [space]

" Edit vimrc
nnoremap [space]v :<C-U>edit $MYVIMRC<CR>

if has('gui_running')
  nnoremap [space]g :<C-U>edit $MYGVIMRC<CR>
endif

" Reload vimrc"{{{
if has('vim_starting')
  function! ReloadVimrc()
    source $MYVIMRC
    if has('gui_running')
      source $MYGVIMRC
    endif

  echom "Reload vimrc"
  endfunction
endif
nmap <expr> [space]rv ReloadVimrc()
"}}}

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
set smarttab

" 折り畳み設定
set foldmethod=marker
nnoremap <silent> ,fc :<C-U>%foldclose<CR>
nnoremap <silent> ,fo :<C-U>%foldopen<CR>
set foldtext=FoldCCtext()

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
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%{tagbar#currenttag('[%s]','')}%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%{eskk#statusline()}%=%l/%L,%c%V%8P\
set noshowmode
set wildmenu
set cmdheight=2
set wildmode=list:full
set showcmd

" tabline
set showtabline=2
command! -nargs=+ -complete=file Te tabedit <args>
command! -nargs=* -complete=file Tn tabnew <args>
nnoremap <silent> <S-Right> :<C-U>tabnext<CR>
nnoremap <silent> <S-Left> :<C-U>tabprevious<CR>
nnoremap <silent> L :<C-U>tabnext<CR>
nnoremap <silent> H :<C-U>tabprevious<CR>
nnoremap [tab]+     :<C-U>tabmove +1<CR>
nnoremap [tab]-     :<C-U>tabmove -1<CR>

" completion
set complete=.,w,b,u,t,i,d
inoremap <C-X><C-O> <C-X><C-O><C-P>

" クリップボード設定
if has('unix')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" バッファ切り替え
set hidden

" Tab表示
set list
set listchars=tab:>-,trail:<

" タイトルを表示
set title

" 対応括弧を表示
set showmatch

" undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

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

" <Space>h or <Space>lで行頭か行末に移動する
noremap [space]h  ^
noremap [space]l  $

" 編集中のファイルのディレクトリに移動
command! CdCurrent execute ":lcd" . expand("%:p:h")

" 最後に編集した場所にカーソルを移動する
MyAutocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" colorscheme
" 全角スペースをハイライト
MyAutocmd ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060
MyAutocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

if stridx($TERM, "256color") >= 0
  colorscheme onedark
else
  colorscheme desert
endif


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if has("nvim")
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if has("termguicolors")
  set termguicolors
endif

" 256色モード
if !has("nvim") && !has("termguicolors")
  if stridx($TERM, "256color") >= 0
    set t_Co=256
  else
    set t_Co=16
  endif
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

" eskk {{{
let g:eskk#large_dictionary = {
      \ 'path': $HOME . "/.vim/dict/skk/SKK-JISYO.L",
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \}
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

" バッファ切り替え {{{
nnoremap [space]n :<C-U>bnext<CR>
nnoremap [space]p :<C-U>bprevious<CR>
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

" NERDCommenter
let NERDSpaceDelims = 1

" smartchr {{{
function! s:EnableSmartchrBasic()
  inoremap <buffer><expr> + smartchr#one_of(' + ', '+', '++')
  inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
  inoremap <buffer><expr> , smartchr#one_of(', ', ',')
  inoremap <buffer><expr> <Bar> smartchr#one_of('<Bar>', ' <Bar><Bar> ', '<Bar><Bar>')
  inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(\*\<bar>!\)\%#')? '= ' : smartchr#one_of(' = ', ' == ', '=')
endfunction

function! s:EnableSmartchrRegExp()
  inoremap <buffer><expr> ~ search('\(!\<bar>=\) \%#', 'bcn')? '<bs>~ ' : '~'
endfunction

function! s:EnableSmartchrRubyHash()
  inoremap <buffer><expr> > smartchr#one_of('>', '>>', ' => ')
endfunction

function! s:EnableSmartchrHaml()
  call s:EnableSmartchrRubyHash()
  inoremap <buffer> [ []<Esc>i
  inoremap <buffer> { {}<Esc>i
endfunction

function! s:EnableSmartchrCoffeeFunction()
  inoremap <buffer><expr> > smartchr#one_of('>', ' ->')
endfunction

MyAutocmd FileType c,cpp,php,python,javascript,ruby,coffee,vim call s:EnableSmartchrBasic()
MyAutocmd FileType python,ruby,coffee,vim call s:EnableSmartchrRegExp()
MyAutocmd FileType ruby call s:EnableSmartchrRubyHash()
MyAutocmd FileType ruby,eruby setlocal tags+=gems.tags,./gems.tags,~/rtags
MyAutocmd FileType haml call s:EnableSmartchrHaml()
MyAutocmd FileType coffee call s:EnableSmartchrCoffeeFunction()
" }}}

" shファイルの保存時にはファイルのパーミッションを755にする {{{
function! s:ChangeShellScriptPermission()
  if !has("win32")
    if &ft =~ "\\(z\\|c\\|ba\\)\\?sh$" && expand('%:t') !~ "\\(zshrc\\|zshenv\\)$"
      call system("chmod 755 " . shellescape(expand('%:p')))
      echo "Set permission 755"
    endif
  endif
endfunction
MyAutocmd BufWritePost * call s:ChangeShellScriptPermission()
" }}}

" QFixHowm用設定======================================================{{{

if has('vim_starting')
  set runtimepath+=~/qfixapp
endif

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
  let QFixHowm_OpenURIcmd = '!start "C:\firefox\firefox.exe" %s'
elseif has('mac')
  let QFixHowm_OpenURIcmd = "call system('/usr/bin/open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin %s')"
elseif has('unix')
  let QFixHowm_OpenURIcmd = "call system('xdg-open %s')"
endif
" }}}


" ポップアップメニューのカラーを設定
MyAutocmd Syntax * hi Pmenu ctermfg=15 ctermbg=18 guibg=#666666
MyAutocmd Syntax * hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
MyAutocmd Syntax * hi PmenuSbar guibg=#333333

" TOhtml
let g:html_number_lines = 0
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = 'utf-8'

" quickrun{{{

" エスケープカラーを表示する。
" MyAutocmd FileType quickrun AnsiEsc
nnoremap ,a :<C-U>AnsiEsc<CR>
" ヤンクを取りやすいようにconcealcursorを無効にする。
MyAutocmd FileType quickrun setlocal concealcursor=""

call quickrun#module#register(shabadou#make_quickrun_hook_anim(
      \"now_running",
      \['||| Now Running |||', '/// Now Running ///', '--- Now Running ---', '\\\ Now Running \\\', '||| Now Running |||', '/// Now Running ///', '--- Now Running ---', '\\\ Now Running \\\', ],
      \2,
      \), 1)

let s:ansiesc_hook = {
      \ 'kind' : 'hook',
      \ 'name' : 'ansiesc',
      \ 'config' : {},
      \ }

function! s:ansiesc_hook.on_exit(session, context)
  let l:winnr = winnr("$")
  execute l:winnr 'wincmd w'
  let ft = &filetype
  if ft == 'quickrun'
    AnsiEsc
  endif
endfunction

call quickrun#module#register(s:ansiesc_hook, 1)

vnoremap <leader>q :QuickRun >>buffer -mode v<CR>
let g:quickrun_config = {}
let g:quickrun_config._ = {
      \'runner' : 'vimproc',
      \'outputter/buffer/split' : ':botright 10sp',
      \'outputter/error': 'buffer',
      \'runner/vimproc/updatetime' : 40,
      \'hook/now_running/enable' : 1,
      \'hook/time/enable' : 1,
      \}

let g:quickrun_config.ruby = {
  \ 'cmdopt': '-W2',
  \ 'exec': 'bundle exec %c %o %s %a',
  \ }

let g:quickrun_config['ruby/plain'] =
  \ extend(copy(g:quickrun_config.ruby), {
    \ 'type': 'ruby/plain',
    \ 'command': 'ruby',
    \ 'exec': '%c %o %s %a',
  \})

let s:rspec_quickrun_config = {
  \ 'command': 'rspec',
  \ 'outputter': 'multi:error:rspec_notifier',
  \ 'outputter/buffer/split': ':botright 8sp',
  \ 'hook/close_buffer/enable_success' : 1,
  \}

let g:quickrun_config['rspec/bundle'] =
  \ extend(copy(s:rspec_quickrun_config), {
    \ 'type': 'rspec/bundle',
    \ 'exec': 'bundle exec %c %o --color --tty %s%a'
  \})

let g:quickrun_config['rspec/normal'] =
  \ extend(copy(s:rspec_quickrun_config), {
    \ 'type': 'rspec/normal',
    \ 'exec': '%c %o --color --tty %s%a'
  \})

let g:quickrun_config['rspec/spring'] =
  \ extend(copy(s:rspec_quickrun_config), {
    \ 'type': 'rspec/spring',
    \ 'exec': 'spring rspec %o --color --tty %s%a'
  \})

let s:cucumber_quickrun_config = {
  \ 'command': 'cucumber',
  \ 'outputter': 'buffer',
  \ 'outputter/buffer/split': ':botright 8sp',
  \}

let g:quickrun_config['cucumber/bundle'] =
  \ extend(copy(s:cucumber_quickrun_config), {
    \ 'type': 'cucumber/bundle',
    \ 'exec': 'bundle exec %c %o --color %s'
  \})

let g:quickrun_config['cucumber/spring'] =
  \ extend(copy(s:cucumber_quickrun_config), {
    \ 'type': 'cucumber/spring',
    \ 'exec': 'spring cucumber %o --color %s'
  \})

let g:quickrun_config['markdown'] = {
 \ 'type': 'markdown/gfm',
 \ 'outputter': 'browser'
 \}

function! s:RSpecQuickrun()
  if exists('g:use_spring_rspec') && g:use_spring_rspec == 1
    let b:quickrun_config = {'type' : 'rspec/spring'}
  elseif exists('g:use_zeus_rspec') && g:use_zeus_rspec == 1
    let b:quickrun_config = {'type' : 'rspec/zeus'}
  else
    let b:quickrun_config = {'type' : 'rspec/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -args :" . line(".") . "<CR>"
endfunction
MyAutocmd BufReadPost *_spec.rb call s:RSpecQuickrun()

function! s:CucumberQuickrun()
  if exists('g:use_spring_cucumber') && g:use_spring_cucumber == 1
    let b:quickrun_config = {'type' : 'cucumber/spring'}
  elseif exists('g:use_zeus_cucumber') && g:use_zeus_cucumber == 1
    let b:quickrun_config = {'type' : 'cucumber/zeus'}
  else
    let b:quickrun_config = {'type' : 'cucumber/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
endfunction
MyAutocmd BufReadPost *.feature call s:CucumberQuickrun()

function! s:SetUseSpring()
  let g:use_spring_rspec = 1
  let g:use_zeus_rspec = 0
  let g:use_spring_cucumber = 1
  let g:use_zeus_cucumber = 0
endfunction

function! s:SetUseZeus()
  let g:use_zeus_rspec = 1
  let g:use_spring_rspec = 0
  let g:use_zeus_cucumber = 1
  let g:use_spring_cucumber = 0
endfunction

function! s:SetUseBundle()
  let g:use_zeus_rspec = 0
  let g:use_spring_rspec = 0
  let g:use_zeus_cucumber = 0
  let g:use_spring_cucumber = 0
endfunction

command! -nargs=0 UseSpringRSpec let b:quickrun_config = {'type' : 'rspec/spring'} | call s:SetUseSpring()
command! -nargs=0 UseZeusRSpec   let b:quickrun_config = {'type' : 'rspec/zeus'}   | call s:SetUseZeus()
command! -nargs=0 UseBundleRSpec let b:quickrun_config = {'type' : 'rspec/bundle'} | call s:SetUseBundle()
command! -nargs=0 UseSpringCucumber let b:quickrun_config = {'type' : 'cucumber/spring'} | call s:SetUseSpring()
command! -nargs=0 UseZeusCucumber   let b:quickrun_config = {'type' : 'cucumber/zeus'}   | call s:SetUseZeus()
command! -nargs=0 UseBundleCucumber let b:quickrun_config = {'type' : 'cucumber/bundle'} | call s:SetUseBundle()
command! -nargs=0 UsePlainRuby let b:quickrun_config = {'type' : 'ruby/plain'}
" }}}

" vim-test
if dein#tap('vim-test')
  nnoremap [space]tn :TestNearest<cr>
  nnoremap [space]tf :TestFile<cr>

  let test#strategy = 'neoterm'

  let test#ruby#rspec#executable = 'rspec'
  let test#ruby#rspec#options = {
    \ 'nearest': '--backtrace',
  \}

  function! DockerTransformer(cmd) abort
    if $APP_CONTAINER_NAME != ''
      let container_id = system('docker ps --filter name=$APP_CONTAINER_NAME -q')
      return 'docker exec -t ' . container_id . ' spring ' . a:cmd
    else
      return 'bundle exec ' . a:cmd
    endif
  endfunction

  let g:test#custom_transformations = {'docker': function('DockerTransformer')}
  let g:test#transformation = 'docker'
endif

" libruby load
if filereadable(expand("~/.rbenv/shims/ruby"))
  let s:ruby_exec = expand("~/.rbenv/shims/ruby")
else
  let s:ruby_exec = "ruby"
endif
let s:ruby_libdir = system(s:ruby_exec . " -rrbconfig -e 'print RbConfig::CONFIG[\"libdir\"]'")
let s:ruby_headerdir = system(s:ruby_exec . " -rrbconfig -e 'print RbConfig::CONFIG[\"rubyhdrdir\"]'")
let s:ruby_archheaderdir = system(s:ruby_exec . " -rrbconfig -e 'print RbConfig::CONFIG[\"rubyarchhdrdir\"]'")
let s:ruby_libruby = s:ruby_libdir . '/libruby.dylib'
if filereadable(s:ruby_libruby)
  if has('gui_macvim') && has('kaoriya')
    let &rubydll=s:ruby_libruby
  endif
endif

" liblua load
" if has('gui_macvim') && has('kaoriya')
  " if filereadable(expand("/usr/local/lib/libluajit-5.1.2.dylib"))
    " let $LUA_DLL = "/usr/local/lib/libluajit-5.1.2.dylib"
  " endif
" endif

" vim-milfeulle
" nmap <C-O> <Plug>(milfeulle-prev)
" nmap <C-I> <Plug>(milfeulle-next)

" webapi-vim
let g:webapi#system_function = "vimproc#system"

" Unite.vim {{{
nnoremap [unite] <Nop>
nmap     ,u [unite]
nnoremap <silent> [unite]ff   :<C-u>Unite -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> [unite]fr   :<C-u>Unite -buffer-name=files -start-insert file_mru<CR>
nnoremap <silent> [unite]fg   :<C-u>Unite -buffer-name=files -start-insert file_rec/git<CR>
nnoremap <silent> [unite]fa   :<C-u>Unite -buffer-name=files -start-insert file_rec/async<CR>
nnoremap <silent> [unite]d   :<C-u>Unite -buffer-name=files -start-insert directory_mru<CR>
nnoremap <silent> [unite]vff  :<C-u>Unite -vertical -buffer-name=files -start-insert file/new<CR>
nnoremap <silent> [unite]vfr  :<C-u>Unite -vertical -buffer-name=files -start-insert file_mru <CR>
nnoremap <silent> [unite]vp  :<C-u>Unite -vertical -winwidth=45 -no-quit -buffer-name=files -start-insert buffer file<CR>
nnoremap <silent> [unite]F   :<C-u>UniteWithBufferDir -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> [unite]vF  :<C-u>UniteWithBufferDir -vertical -winwidth=45 -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> [unite]b   :<C-u>Unite -buffer-name=buffers -start-insert -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vb  :<C-u>Unite -vertical -buffer-name=buffers -start-insert -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vB  :<C-u>Unite -vertical -buffer-name=buffers -start-insert -prompt=Buffer>\  -winwidth=45 -no-quit buffer<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -vertical -winwidth=45 -start-insert -wrap -no-quit -toggle -buffer-name=outline outline<CR>
nnoremap <silent> [unite]"   :<C-u>Unite -buffer-name=register -prompt=">\  register<CR>
nnoremap <silent> [unite]c   :<C-u>Unite -buffer-name=commands history/command<CR>
nnoremap <silent> [unite]C   :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> [unite]s   :<C-u>Unite -buffer-name=snippets snippet<CR>
nnoremap <silent> [unite]u   :<C-u>Unite -start-insert source<CR>
nnoremap <silent> [unite]l   :<C-u>Unite -buffer-name=lines line<CR>
nnoremap <silent> [unite]m   :<C-u>Unite -buffer-name=bookmark -prompt=bookmark> bookmark<CR>
nnoremap <silent> [unite]rm   :<C-u>Unite -buffer-name=ref -start-insert -prompt=ref> ref/man<CR>
nnoremap <silent> [unite]rr   :<C-u>Unite -buffer-name=ref -start-insert -prompt=ref> ref/refe<CR>
nnoremap <silent> [unite]g   :<C-u>Unite -buffer-name=grep grep<CR>
nnoremap <silent> [unite]hd   :<C-u>Unite haddock -start-insert<CR>
nnoremap <silent> [unite]y   :<C-u>Unite -buffer-name=yankround yankround<CR>
nnoremap [unite]pr  :<C-u>Unite pull_request:
nnoremap [unite]pf  :<C-u>Unite pull_request_file:

if dein#tap('unite')
  let g:unite_enable_start_insert = 1

  let g:unite_winheight = 15
  let g:unite_winwidth = 45
  let g:unite_source_grep_max_candidates = 500

  " unite-ruby-require
  let g:unite_source_ruby_require_ruby_command = expand("~/.rbenv/shims/ruby")

  function! s:unite_config()
    " ディレクトリに対するブックマークはvimfilerをデフォルトアクションにする
    call unite#custom#default_action('source/bookmark/directory', 'vimfiler')

    call unite#custom#source('buffer,file,file_mru,file_rec,file_rec/async', 'sorters', 'sorter_rank')

    call unite#custom#source('file_rec,file_rec/async', 'converters',
          \ ['converter_relative_word', 'converter_relative_abbr', 'converter_file_directory'])
    call unite#custom#source('file_rec,file_rec/async', 'matcher', 'matcher_default')

    call unite#custom#source(
          \ 'file_mru', 'converters',
          \ ['converter_file_directory'])
  endfunction
  call dein#config(g:dein#name, {'hook_source': function("s:unite_config")})

  function! s:unite_my_settings()
    " Overwrite settings.
    nmap <buffer> l     <Plug>(unite_choose_action)
    nmap <buffer> <C-c>     <Plug>(unite_choose_action)

    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

    nmap <silent><buffer><expr> f unite#do_action('vimfiler')

    " grep bufferの時はrをreplaceアクションにマップする
    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^grep'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
            \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
  endfunction
  MyAutocmd FileType unite call s:unite_my_settings()
endif
" }}}

" denite {{{
nnoremap [denite] <Nop>
nmap     ,d [denite]
nnoremap <silent> [denite]ff   :<C-u>Denite -buffer-name=files -mode=insert file_rec<CR>
nnoremap <silent> [denite]fr   :<C-u>Denite -buffer-name=files -mode=insert file_mru<CR>
nnoremap <silent> [denite]d   :<C-u>Denite -buffer-name=files -mode=insert directory_mru<CR>
nnoremap <silent> [denite]F   :<C-u>DeniteBufferDir -buffer-name=files -mode=insert file_rec<CR>
nnoremap <silent> [denite]b   :<C-u>Denite -buffer-name=buffers -mode=insert buffer<CR>
nnoremap <silent> [denite]o   :<C-u>Denite -mode=insert -buffer-name=outline outline<CR>
nnoremap <silent> [denite]"   :<C-u>Denite -buffer-name=register register<CR>
nnoremap <silent> [denite]c   :<C-u>Denite -buffer-name=commands command<CR>
nnoremap <silent> [denite]s   :<C-u>Denite -buffer-name=snippets unite:snippet<CR>
" nnoremap <silent> [denite]u   :<C-u>Denite -mode=insert source<CR>
nnoremap <silent> [denite]l   :<C-u>Denite -buffer-name=lines line<CR>
nnoremap <silent> [denite]m   :<C-u>Denite -buffer-name=bookmark unite:bookmark<CR>
nnoremap <silent> [denite]rm   :<C-u>Denite -buffer-name=ref -mode=insert unite:ref/man<CR>
nnoremap <silent> [denite]rr   :<C-u>Denite -buffer-name=ref -mode=insert unite:ref/refe<CR>
nnoremap <silent> [denite]g   :<C-u>Denite -buffer-name=grep grep<CR>
nnoremap <silent> [denite]hd   :<C-u>Denite -mode=insert unite:haddock<CR>
nnoremap <silent> [denite]y   :<C-u>Denite -buffer-name=yankround unite:yankround<CR>
nnoremap [denite]pr  :<C-u>Denite unite:pull_request:
nnoremap [denite]pf  :<C-u>Denite unite:pull_request_file:

if dein#tap("denite")
  function! s:denite_config()
    call denite#custom#var('file_rec', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
  endfunction
  call dein#config(g:dein#name, {"hook_source": function("s:denite_config")})
endif
" }}}


" Gist.vim {{{
nnoremap [gist] <Nop>
nmap ,s [gist]
nnoremap [gist]g :Gist<CR>
nnoremap [gist]p :Gist -p<CR>
nnoremap [gist]e :Gist -e<CR>
nnoremap [gist]d :Gist -d<CR>
nnoremap [gist]l :Gist -l<CR>

if dein#tap('gist-vim')
  if has("mac")
    let g:gist_clip_command = 'pbcopy'
  elseif has("unix")
    let g:gist_clip_command = 'xclip -selection clipboard'
  endif

  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  let g:gist_show_privates = 1
endif
" }}}

" Fugitive {{{
nnoremap [git] <Nop>
nmap ,g [git]
nnoremap [git]d :<C-u>Gdiff HEAD<CR>
nnoremap [git]s :<C-u>Gstatus<CR>
nnoremap [git]l :<C-u>Glog<CR>
nnoremap [git]a :<C-u>Gwrite<CR>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]n :<C-u>Git now<CR>
nnoremap [git]N :<C-u>Git now --all<CR>

" ftdetect is often failed
MyAutocmd BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif
MyAutocmd BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif
MyAutocmd BufEnter * if expand("%:t") =~ "PULLREQ_EDITMSG" | set ft=gitcommit | endif
" }}}

" gitv {{{
if dein#tap("gitv")
  nnoremap [git]vn :<C-u>Gitv<CR>
  nnoremap [git]va :<C-u>Gitv --all<CR>
  nnoremap [git]vf :<C-u>Gitv!<CR>
endif

" http://d.hatena.ne.jp/cohama/20130517/1368806202
function! GitvGetCurrentHash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

function! s:my_gitv_settings()
  setlocal foldlevel=99

  setlocal iskeyword+=/,-,.
  " カーソル下のブランチ名で checkout
  " ブランチ間移動 r/R
  nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>

  " カーソル位置のコミットに対する操作
  nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> <Space>ri :<C-u>Git rebase -i <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>p :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR>
endfunction

MyAutocmd FileType gitv call s:my_gitv_settings()

" }}}

" vim-gitgitter {{{
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '**'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '*-'
"}}}

" vim-airline {{{
let g:airline_powerline_fonts = 0
let g:airline_theme = "onedark"
let g:airline#extensions#hunks#hunk_symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
  \ ]
" }}}

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim {{{
function! GetCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F> 70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction
" }}}

" vimfiler {{{
nnoremap <silent> ,vf :<C-U>VimFiler<CR>

if dein#tap('vimfiler')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_max_directory_histories = 100

  function s:ChangeVimfilerKeymap()
    nmap <buffer> a <Plug>(vimfiler_toggle_mark_all_lines)

    " j k 移動でループしないように
    nmap <buffer> j j
    nmap <buffer> k k
    nmap <buffer> <Enter> <Plug>(vimfiler_execute_vimfiler_associated)

    nmap <buffer> s <Plug>(vimfiler_select_sort_type)
    nmap <End> <Plug>(vimfiler_clear_mark_all_lines)
    nmap <buffer> @ <Plug>(vimfiler_set_current_mask)
    nmap <buffer> V <Plug>(vimfiler_quick_look)
  endfunction
  MyAutocmd FileType vimfiler call s:ChangeVimfilerKeymap()

  function! s:vimfiler_config()
    if filereadable(expand('~/.vimfiler.local'))
      execute 'source' expand('~/.vimfiler.local')
    endif
  endfunction
  call dein#config(dein#name, {'hook_source': function("s:vimfiler_config")})
endif
" }}}

" vimshell {{{
nnoremap <silent> ,vs :<C-U>VimShell<CR>

function! g:MyChpwd(args, context)
  call vimshell#execute('ls')
endfunction

if dein#tap('vimshell')
  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    let g:vimshell_prompt = $USER . "@" . hostname() . "% "
  endif
  "let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b] ", "(%s)-[%b|%a] ") . "[" . getcwd() . "]"'
  let g:vimshell_right_prompt = '"[" . getcwd() . "]"'
  let g:vimshell_max_command_history = 3000

  function! s:vimshell_config()
    if has('mac')
      call vimshell#set_execute_file('html', 'gexe open -a /Applications/Firefox.app/Contents/MacOS/firefox')
      call vimshell#set_execute_file('avi,mp4,mpg,ogm,mkv,wmv,mov', 'gexe open -a /Applications/MPlayerX.app/Contents/MacOS/MPlayerX')
    endif
  endfunction
  call dein#config(dein#name, {'hook_source': function("s:vimshell_config")})

  MyAutocmd FileType vimshell
    \ call vimshell#altercmd#define('g', 'git')
    \| call vimshell#altercmd#define('l', 'll')
    \| call vimshell#altercmd#define('ll', 'ls -l')
    \| call vimshell#altercmd#define('be', 'bundle exec')
    \| call vimshell#altercmd#define('ra', 'rails')
    \| call vimshell#hook#add('chpwd', 'MyChpwd', 'g:MyChpwd')

  function! s:EarthquakeKeyMap()
    nnoremap <buffer><expr> o OpenBrowserLine()
  endfunction
  MyAutocmd FileType int-earthquake call s:EarthquakeKeyMap()
endif
" }}}

" rubycomplete.vim {{{
let g:rubycomplete_rails = 0
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 0
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_object_space = 0
" let ruby_operators = 1
" }}}

" rails.vim {{{
nnoremap ,rm :<C-u>Rmodel<Space>
nnoremap ,rc :<C-u>Rcontroller<Space>
nnoremap ,rv :<C-u>Rview<Space>
nnoremap ,rs :<C-u>Rspec<Space>
nnoremap ,rl :<C-u>Rlog<Space>
" }}}

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" neosnippet {{{
nnoremap <Space>se :<C-U>NeoSnippetEdit<CR>
if dein#tap('neosnippet')
  let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

  " enable ruby & rails snippet only rails file
  function! s:RailsSnippet()
    if exists("b:rails_root") && (&filetype == "ruby")
      NeoSnippetSource ~/.vim/snippets/rails.snip
    endif
  endfunction

  function! s:RSpecSnippet()
    if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$")
      NeoSnippetSource ~/.vim/snippets/rspec.snip
    endif
  endfunction

  MyAutocmd BufEnter * call s:RailsSnippet()
  MyAutocmd BufEnter * call s:RSpecSnippet()
endif
" }}}

" neocomplcache or neocomplete {{{
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
      \ if &omnifunc == "" |
      \   setlocal omnifunc=syntaxcomplete#Complete |
      \ endif
endif

" Enable omni completion.
MyAutocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
MyAutocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
MyAutocmd FileType python setlocal omnifunc=pythoncomplete#Complete
MyAutocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
MyAutocmd FileType sql setlocal omnifunc=sqlcomplete#Complete

" clang_complete
if dein#tap('vim-clang')
  let g:clang_auto = 0
  let g:clang_use_library = 1
  let g:clang_check_syntax_auto = 1

  let g:clang_c_options = '-I' . s:ruby_headerdir . ' -I' . s:ruby_archheaderdir
  let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
  " let g:clang_debug = 1
  if has('mac')
    let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
  endif
  " let g:clang_user_options = '-std=c++11'
endif

if dein#tap('neocomplete')
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1

  " Set minimum syntax keyword length.
  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#manual_completion_start_length = 0
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#min_keyword_length = 2

  let g:neocomplete#enable_prefetch = 1

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME . '/.vimshell/command-history',
  \ }

  " キャッシュしないファイル名
  let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'
  " 自動補完を行わないバッファ名
  let g:neocomplete#lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'


  " Plugin key-mappings.
  inoremap <expr><C-l> neocomplete#complete_common_string()

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>"

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> neocomplete#close_popup()

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  " let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

  " for TweetVim スクリーン名のキャッシュを利用して、neocomplcache で補完する
  if !exists('g:neocomplete#sources#dictionary#dictionaries')
    let g:neocomplete#sources#dictionary#dictionaries = {}
  endif
  let neco_dic = g:neocomplete#sources#dictionary#dictionaries
  let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'

  " use clang_complete
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_overwrite_completefunc = 1
  let g:neocomplete#force_omni_input_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.objc =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:neocomplete#force_omni_input_patterns.objcpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

endif

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endif
" }}}

" ref.vim
let g:ref_open = 'vsplit'
let g:ref_refe_cmd = "rurema"
let g:ref_refe_version = 2
let g:ref_use_vimproc = 1

let g:ref_source_webdict_sites = {
\   'wikipedia:ja': 'http://ja.wikipedia.org/wiki/%s',
\   'weblio': 'http://ejje.weblio.jp/content/%s',
\ }

nmap ,rr :<C-U>Ref refe<Space>

" indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 35
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

call submode#enter_with('tab/move', 'n', '', '<Leader>t')
call submode#map('tab/move', 'n', 'r', 'h', 'H')
call submode#map('tab/move', 'n', 'r', 'l', 'L')
call submode#map('tab/move', 'n', 'r', '+', '[tab]+')
call submode#map('tab/move', 'n', 'r', '-', '[tab]-')
" }}}

" vim-altr {{{
nmap <F3> <Plug>(altr-forward)
nmap <F2> <Plug>(altr-back)

if dein#tap('vim-altr')
  function! s:vim_altr_config()
    " For ruby tdd
    call altr#define('%.rb', 'spec/%_spec.rb')
    " For ruby tdd
    call altr#define('lib/%.rb', 'spec/lib/%_spec.rb', 'spec/%_spec.rb')
    " For rails tdd
    call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
    call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
    call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
    call altr#define('app/%.rb', 'spec/%_spec.rb')
  endfunction
  call dein#config(dein#name, {'hook_source': function("s:vim_altr_config")})
endif
" }}}

" switch.vim {{{
let g:variable_style_switch_definitions = [
      \   {
      \     '\<[a-z0-9]\+_\k\+\>': {
      \       '_\(.\)': '\U\1'
      \     },
      \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
      \       '\([A-Z]\)': '_\l\1'
      \     },
      \   }
      \ ]

nnoremap <silent><C-c> :Switch<CR>
nnoremap <silent>- :Switch<CR>
nnoremap + :call switch#Switch(g:variable_style_switch_definitions)<cr>

let g:switch_custom_definitions = [
      \ ['and', 'or'],
      \ ['it', 'specify'],
      \ ['describe', 'context'],
      \ ['yes', 'no'],
      \ ['on', 'off'],
      \ ['public', 'protected', 'private'],
\ ]
" }}}

if dein#tap('github-complete.vim')
  augroup ConfigGithubComplete
    autocmd!
    autocmd FileType gitcommit setl omnifunc=github_complete#complete
    autocmd FileType markdown setl omnifunc=github_complete#complete
  augroup END
endif

" RSpec syntax {{{
function! RSpecSyntax()
  hi def link rubyRailsTestMethod             Function
  syn keyword rubyRailsTestMethod describe context it its specify shared_examples_for shared_examples shared_context it_should_behave_like it_behaves_like before after around subject fixtures controller_name helper_name include_context include_examples
  syn match rubyRailsTestMethod '\<let\>!\='
  syn keyword rubyRailsTestMethod violated pending expect double mock mock_model stub_model an_instance_of hash_including
  syn match rubyRailsTestMethod '\.\@<!\<stub\>!\@!'
endfunction
MyAutocmd Syntax ruby if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | call RSpecSyntax() | endif
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

" TagBar
if dein#tap('tagbar')
  let g:tagbar_left = 1
  let g:tagbar_width = 30
  let g:tagbar_updateonsave_maxlines = 10000
  let g:tagbar_sort = 0

  nnoremap <silent> <leader>t :TagbarToggle<CR>
endif

" Tabular
nnoremap <Leader>a, :Tabularize /,<CR>
vnoremap <Leader>a, :Tabularize /,<CR>
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a> :Tabularize /=><CR>
vnoremap <Leader>a> :Tabularize /=><CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>

" テーブルっぽく打つと自動的に位置調整を行う
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

" qfreplace
MyAutocmd FileType qf nnoremap <buffer> r :<C-U>Qfreplace<CR>

" sudo.vim
command! ES :e sudo:%
command! WS :w sudo:%

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)
function! OpenBrowserLine()
  let matched = matchlist(getline("."), 'https\?://[0-9A-Za-z_#?~=\-+%\.\/:]\+')
  if len(matched) == 0
    break
  endif
  execute "OpenBrowser " . matched[0]
endfunction

" syntastic
if executable('rubocop')
  let g:syntastic_ruby_checkers = ['mri', 'rubocop']
endif

function! s:toggle_rubocop() abort
  if index(g:syntastic_ruby_checkers, 'rubocop') >= 0
    let g:syntastic_ruby_checkers = ['mri']
  else
    let g:syntastic_ruby_checkers = ['mri', 'rubocop']
  endif
endfunction

command! ToggleRubocop :call s:toggle_rubocop()

if executable('coffeelint')
  let g:syntastic_coffee_checkers = ['coffeelint']
endif

let g:syntastic_javascript_checkers = []

if executable('eslint')
  let g:syntastic_javascript_checkers += ['eslint']
endif

if executable('flow')
  let g:syntastic_javascript_checkers += ['flow']
endif

let g:syntastic_enable_elixir_checker = 1
let g:syntastic_elixir_checkers = ['elixir']

let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby', 'javascript', 'typescript', 'coffee', 'elixir'],
                           \ 'passive_filetypes': [] }

" ft hamstache
MyAutocmd BufReadPost *.hamstache set filetype=haml

" ft ejs
MyAutocmd BufReadPost *.ejs set filetype=html

" ag.vim
let g:ag_prg="ag --vimgrep --smart-case"

" vim-anzu {{{
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
"}}}

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

" TweetVim {{{
nnoremap <silent> S :<C-u>TweetVimSay<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tweetvim<CR>
nnoremap <silent> [space]ts   :<C-u>TweetVimUserStream<CR>
nnoremap <silent> [space]tt   :<C-u>TweetVimHomeTimeline<CR>
if dein#tap('TweetVim')
  let g:tweetvim_include_rts = 1
  let g:tweetvim_display_icon = 1
endif
" }}}

" code snippet highlight {{{
let g:markdown_quote_syntax_filetypes = {
        \ "coffee" : {
        \   "start" : "coffee",
        \},
        \ "mustache" : {
        \   "start" : "mustache",
        \},
        \ "haml" : {
        \   "start" : "haml",
        \},
  \}
" }}}

" neoterm
if has('nvim')
  tnoremap <Esc><Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
endif
if dein#tap('neoterm')
  let g:neoterm_position = 'horizontal'
  let g:neoterm_automap_keys = ',tt'
  let g:neoterm_repl_ruby = 'pry'

  nnoremap <silent> <f10> :TREPLSendFile<cr>
  nnoremap <silent> <f9> :TREPLSendLine<cr>
  vnoremap <silent> <f9> :TREPLSendSelection<cr>

" nvim-editcommand
if dein#tap('nvim-editcommand')
  let g:editcommand_prompt = '%'
endif

  " Useful maps
  " hide/close terminal
  nnoremap <silent> ,th :call neoterm#toggle()<cr>
  " clear terminal
  nnoremap <silent> ,tl :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> ,tc :call neoterm#kill()<cr>

  " Git commands
  command! -nargs=+ Tg :T git <args>
endif

" incsearch.vim
if dein#tap('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif

" yankround
if dein#tap('yankround.vim')
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
endif

" dbext.vim
let dbext_default_profile = 'redshift'
let dbext_default_profile_redshift = 'type=PGSQL'
let dbext_default_profile_mysql = 'type=MYSQL'
let g:rails_no_dbext = 1

" accelerated-smooth-scroll
" let g:ac_smooth_scroll_du_sleep_time_msec = 5
" let g:ac_smooth_scroll_fb_sleep_time_msec = 5

" vim-metarw-qiita
let g:qiita_user = "joker1007"
let g:qiita_per_page = 50

" vim-metarw-github-issues
let g:github_user = "joker1007"

" vim-json
let g:vim_json_syntax_conceal = 0

syntax enable

if filereadable(expand('~/.vimrc.local.after'))
  execute 'source' expand('~/.vimrc.local.after')
endif

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call dein#call_hook('source')
endif
