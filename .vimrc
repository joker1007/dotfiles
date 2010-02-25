if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,cp932,eucjp
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" 行番号を表示
set nu
" タブストップ設定
set tabstop=4
set shiftwidth=4
set softtabstop=0
" 検索設定
set incsearch
set ignorecase
set smartcase
set wrapscan
" ステータスライン表示
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l/%L,%c%V%8P
set wildmenu
set cmdheight=2
set wildmode=list:full
set showcmd
" クリップボード設定
set clipboard=unnamed
" バッファ切り替え
set hidden
set list
set listchars=tab:>-
" タイトルを表示
set title
" 対応括弧を表示
set showmatch
" 自動折り返しを日本語に対応させるスクリプト用の設定
set formatoptions+=mM

colorscheme evening

syntax on
filetype plugin indent on

source $VIMRUNTIME/macros/matchit.vim

" YAMLファイル用タブストップ設定
au FileType yaml set expandtab ts=2 sw=2 fenc=utf-8
" actionscript mxml用のファイルタイプ設定
autocmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd BufNewFile,BufRead *.mxml set filetype=mxml

" yanktmp用キー設定
map <silent> sy :call YanktmpYank()<CR> 
map <silent> sp :call YanktmpPaste_p()<CR> 
map <silent> sP :call YanktmpPaste_P()<CR> 

" miniBufExplorer設定
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1
let g:miniBufExplModSelTarget = 1
" バッファ切り替え
nmap <Space> :MBEbn<CR>
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


" JとDで半ページ移動
nnoremap J <C-D>
nnoremap K <C-U>

" UTF8、SJIS(CP932)、EUCJPで開き直す
command! -bang -nargs=? Utf8
	\ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
	\ edit<bang> ++enc=cp932 <args>
command! -bang -nargs=? Euc
	\ edit<bang> ++enc=eucjp <args>

" QFixHowm用設定
set runtimepath+=~/qfixapp

"キーマップリーダー
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir = '~/Dropbox/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'cp932'
let howm_fileformat      = 'dos'

let mygrepprg = 'grep'

let QFixHowm_RecentMode = 2

"ブラウザの指定
if has('win32')
  let QFixHowm_OpenURIcmd = '!start "C:\firefox-3.5.3-2009100400.en-US.win32-tete009-sse2-pgo\firefox.exe" %s'
elseif has('unix')
  let QFixHowm_OpenURIcmd = "call system('firefox %s &')"
endif



" FuzzyFinder
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>fb :FufBuffer<CR>
nnoremap <Leader>fd :FufDir<CR>

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif
