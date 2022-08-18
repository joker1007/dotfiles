if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim/
  set runtimepath+=/usr/share/vim/vimfiles
endif

"let g:python3_host_prog = "/usr/bin/python3.8"

if filereadable(expand('~/.vimrc.local.before'))
  execute 'source' expand('~/.vimrc.local.before')
endif

" gui configs
if exists("g:neovide")
  set guifont=Monospace:h12
  let g:neovide_cursor_vfx_mode="wireframe"
  function! FontSizePlus()
    let l:gf_size_whole = matchstr(&guifont, 'h\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = l:gf_size_whole
    let &guifont = substitute(&guifont, 'h\d\+$', 'h' . l:new_font_size, '')
  endfunction
  function! FontSizeMinus()
    let l:gf_size_whole = matchstr(&guifont, 'h\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = l:gf_size_whole
    let &guifont = substitute(&guifont, 'h\d\+$', 'h' . l:new_font_size, '')
  endfunction
  function! FontSizeReset()
    let &guifont = substitute(&guifont, 'h\d\+$', 'h12', '')
  endfunction
  nnoremap <C-=> :call FontSizePlus()<CR>
  nnoremap <C--> :call FontSizeMinus()<CR>
  nnoremap <C-0> :call FontSizeReset()<CR>
endif

" charset {{{
set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac

set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2,iso-2022-jp-3,euc-jp,cp932
" }}}

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
call dein#add('ryanoasis/vim-devicons')
call dein#add('junegunn/vim-emoji')

call dein#add('moro/vim-review')
call dein#add('cespare/vim-toml')

call dein#add('kana/vim-submode')

call dein#add('simeji/winresizer')

call dein#add('plasticboy/vim-markdown')
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
call dein#add('rakr/vim-one')
call dein#add('jacoborus/tender.vim')
call dein#add('MaxSt/FlatColor')
call dein#add('cocopon/iceberg.vim')
" }}}

" ruby rails develop {{{
call dein#add('tpope/vim-rails')
call dein#add('vim-ruby/vim-ruby')
"call dein#add('noprompt/vim-yardoc')
call dein#add('thinca/vim-quickrun', {'depends' : 'vimproc'})

call dein#add('leafgarland/typescript-vim')
" }}}

" ref {{{
call dein#add('thinca/vim-ref')
call dein#add('taka84u9/vim-ref-ri')
" }}}

" vim-scripts {{{
call dein#add('vim-scripts/surround.vim')
call dein#add('LeafCage/yankround.vim')
" call dein#add('vim-scripts/grep.vim'
call dein#add('vim-scripts/errormarker.vim')
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
" }}}

" web browse, api {{{
call dein#add('tyru/open-browser.vim')
call dein#add('mattn/webapi-vim')
call dein#add('kannokanno/previm', {'on_cmd' : ['PrevimOpen']})
" }}}

" other programinng {{{
if has("nvim")
  call dein#add('nvim-treesitter/nvim-treesitter')
endif
call dein#add('andymass/vim-matchup')
call dein#add('godlygeek/tabular')
call dein#add('dense-analysis/ale')
call dein#add('rhysd/github-complete.vim')
call dein#add('rhysd/ghpr-blame.vim')
call dein#add('hashivim/vim-terraform')
call dein#add('Shougo/vinarise.vim')
call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })

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
call dein#add('osyo-manga/shabadou.vim')
call dein#add('joker1007/quickrun-rspec-notifier', {'depends' : 'vim-quickrun'})
call dein#add('superbrothers/vim-quickrun-markdown-gfm', {'on_ft': 'markdown'})
call dein#add('kana/vim-metarw')
call dein#add('joker1007/vim-metarw-qiita')
call dein#add('joker1007/vim-metarw-github-issues')
call dein#add('lilydjwg/colorizer')
call dein#add('mattn/httpstatus-vim')
call dein#add('tmux-plugins/vim-tmux')
call dein#add('haya14busa/incsearch.vim')
call dein#add('eugen0329/vim-esearch')
call dein#add('fuenor/qfixhowm')

call dein#add('vim-scripts/SQLUtilities')
call dein#add('vim-scripts/dbext.vim')
call dein#add('exu/pgsql.vim')

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

" tweetvim {{{
call dein#add('basyura/bitly.vim')
call dein#add('basyura/twibill.vim')
call dein#add('basyura/TweetVim', {
\   'rev': 'master',
\   'depends' : ['twibill.vim', 'open-browser.vim' ],
\})
" }}}

" cursor move {{{
call dein#add('thinca/vim-visualstar')

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

call dein#add('t9md/vim-choosewin')
" }}}

" git {{{
call dein#add('tpope/vim-fugitive', {'augroup' : 'fugitive'})
call dein#add('rbong/vim-flog')
call dein#add('airblade/vim-gitgutter')

if has('nvim')
  call dein#add('ldelossa/litee.nvim')
  call dein#add('ldelossa/gh.nvim')
endif

call dein#add('mattn/gist-vim', {
\     'on_cmd' : [ "Gist" ]
\})

call dein#add('lambdalisue/vim-gista', {
\     'on_cmd' : [ "Gista" ]
\})
" }}}

" denite {{{
call dein#add('Shougo/neomru.vim')

call dein#add('Shougo/denite.nvim', {
\   'name' : 'denite',
\})

call dein#add('liuchengxu/vim-clap', {'build': 'cargo build --release'})
call dein#add('liuchengxu/vista.vim')
" }}}

" neocon {{{
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet', {
  \   'depends' : ["neosnippet-snippets"]
\})
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
endif
" }}}

call dein#add('mattn/vim-sonots')

" }}}

" neovim {{{
if has('nvim')
  call dein#add('equalsraf/neovim-gui-shim')
  call dein#add('kassio/neoterm')
  call dein#add('janko-m/vim-test')
  call dein#add('brettanomyces/nvim-editcommand')
  call dein#add('euclio/vim-markdown-composer', {'build': 'cargo build --release'})
  call dein#add('subnut/nvim-ghost.nvim')
  call dein#add('akinsho/nvim-bufferline.lua')
  call dein#add('kyazdani42/nvim-tree.lua')
endif
" }}}

call dein#end()
call dein#save_state()
call dein#call_hook('source')
" endif
autocmd VimEnter * call dein#call_hook('post_source')
" }}}

packadd termdebug

let g:termdebug_useFloatingHover = 1
let g:termdebug_wide = 160

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
map <leader><leader> <Plug>leaderguide-global
let g:leaderGuide_default_group_name = "+group"

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
set ambiwidth=single
set display=uhex            " 表示できない文字を16進数で表示
set scrolloff=5             " 常にカーソル位置から5行余裕を取る
set virtualedit=block       " 矩形選択でカーソル位置の制限を解除
set autoread                " 他でファイルが編集された時に自動で読み込む
set background=dark
set ttimeout
set ttimeoutlen=100
set signcolumn=yes
set updatetime=1000
set mouse=a

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
command! CdCurrent execute ":cd" . expand("%:p:h")
nnoremap <silent> ,c :<C-U>CdCurrent<CR>:pwd<CR>

" 最後に編集した場所にカーソルを移動する
MyAutocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" colorscheme
" 全角スペースをハイライト
MyAutocmd ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060
MyAutocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

colorscheme hybrid
" colorscheme onedark
MyAutocmd ColorScheme * highlight Visual ctermbg=239 guibg=#30505d

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

" neovim provider

if has("nvim")
  let g:loaded_node_provider = 0
  let g:loaded_perl_provider = 0
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

" For avsc
MyAutocmd BufNewFile,BufRead *.avsc set filetype=json

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

if has('nvim')
  " nvim-tree {{{
  lua <<EOF
    require'nvim-tree'.setup {
      disable_netrw       = true,
      hijack_netrw        = true,
      open_on_setup       = false,
      ignore_ft_on_setup  = {},
      hijack_directories  = {
        enable = true,
        auto_open = true,
      },
      open_on_tab         = false,
      hijack_cursor       = false,
      update_cwd          = true,
      diagnostics         = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        }
      },
      update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
      },
      system_open = {
        cmd  = nil,
        args = {}
      },
      view = {
        width = 36,
        height = 30,
        side = 'left',
        mappings = {
          custom_only = false,
          list = {}
        }
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      filters = {
        dotfiles = false,
        custom = {}
      }
    }
EOF

  nnoremap <leader>tt :NvimTreeToggle<CR>
  nnoremap <leader>tr :NvimTreeRefresh<CR>
  nnoremap <leader>tf :NvimTreeFindFile<CR>
  " }}}

  " nvim-bufferline {{{
  if dein#tap('nvim-bufferline.lua')
  lua << EOF
    require("bufferline").setup{}
EOF
  endif
  nnoremap <silent> gb :<C-U>BufferLinePick<CR>
  nnoremap <silent> gD :<C-U>BufferLinePickClose<CR>
  nnoremap <silent>[b :<C-U>BufferLineCycleNext<CR>
  nnoremap <silent>]b :<C-U>BufferLineCyclePrev<CR>
  " }}}
endif

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

MyAutocmd FileType c,cpp,php,python,javascript,ruby,vim call s:EnableSmartchrBasic()
MyAutocmd FileType python,ruby,vim call s:EnableSmartchrRegExp()
MyAutocmd FileType ruby call s:EnableSmartchrRubyHash()
MyAutocmd FileType ruby,eruby setlocal tags+=gems.tags,./gems.tags,~/rtags
MyAutocmd FileType haml call s:EnableSmartchrHaml()
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
MyAutocmd Syntax * hi Pmenu ctermfg=0 ctermbg=116 guifg=#FFFFFF guibg=#3c4083
MyAutocmd Syntax * hi PmenuSel cterm=bold ctermfg=235 ctermbg=81 gui=bold guifg=#282828 guibg=#63cef4
MyAutocmd Syntax * hi PmenuSbar guibg=#333333
MyAutocmd Syntax * hi CursorLine ctermbg=238 guibg=#3A3A2A

" treesitter {{{
if dein#tap('nvim-treesitter')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "rust", "java", "scala", "json", "typescript", "bash", "css", "html", "javascript"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "ruby", "markdown" },
  },
  incremental_selection = {
    enable = true,
    disable = { "ruby", "markdown" },
  },
  indent = {
    enable = true,
    disable = { "ruby", "markdown" },
  },
  matchup = {
    enable = true,
    disable = { "ruby", "markdown" },
  },
}
EOF
endif
" }}}

" TOhtml
let g:html_number_lines = 0
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = 'utf-8'

" quickrun{{{

" ヤンクを取りやすいようにconcealcursorを無効にする。
MyAutocmd FileType quickrun setlocal concealcursor=""

call quickrun#module#register(shabadou#make_quickrun_hook_anim(
      \"now_running",
      \['||| Now Running |||', '/// Now Running ///', '--- Now Running ---', '\\\ Now Running \\\', '||| Now Running |||', '/// Now Running ///', '--- Now Running ---', '\\\ Now Running \\\', ],
      \2,
      \), 1)

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

function! s:SetUseSpring()
  let g:use_spring_rspec = 1
  let g:use_spring_cucumber = 1
endfunction

function! s:SetUseBundle()
  let g:use_spring_rspec = 0
  let g:use_spring_cucumber = 0
endfunction

command! -nargs=0 UseSpringRSpec let b:quickrun_config = {'type' : 'rspec/spring'} | call s:SetUseSpring()
command! -nargs=0 UseBundleRSpec let b:quickrun_config = {'type' : 'rspec/bundle'} | call s:SetUseBundle()
command! -nargs=0 UsePlainRuby let b:quickrun_config = {'type' : 'ruby/plain'}
" }}}

" vim-test
if dein#tap('vim-test')
  nnoremap [space]tn :TestNearest<cr>
  nnoremap [space]tf :TestFile<cr>

  let test#strategy = 'neoterm'

  let test#ruby#rspec#executable = 'rspec'

  function! DockerTransformer(cmd) abort
    if $APP_CONTAINER_NAME != ''
      let container_id = system('docker ps --filter name=$APP_CONTAINER_NAME -q')
      return 'docker exec -t ' . container_id . ' bundle exec ' . a:cmd
    else
      return 'bundle exec ' . a:cmd
    endif
  endfunction

  let g:test#custom_transformations = {'docker': function('DockerTransformer')}
  let g:test#transformation = 'docker'
endif

" vim-milfeulle
" nmap <C-O> <Plug>(milfeulle-prev)
" nmap <C-I> <Plug>(milfeulle-next)

" webapi-vim
let g:webapi#system_function = "vimproc#system"

" denite {{{
nnoremap [denite] <Nop>
nmap     ,d [denite]
nnoremap <silent> [denite]ff   :<C-u>Denite -buffer-name=files -start-filter file<CR>
nnoremap <silent> [denite]fn   :<C-u>Denite -buffer-name=files -start-filter file:new<CR>
nnoremap <silent> [denite]fa   :<C-u>Denite -buffer-name=files -start-filter file/rec<CR>
nnoremap <silent> [denite]fr   :<C-u>Denite -buffer-name=files -start-filter file_mru<CR>
nnoremap <silent> [denite]fg   :<C-u>Denite -buffer-name=files -start-filter file_rec/git<CR>
nnoremap <silent> [denite]d   :<C-u>Denite -buffer-name=files -start-filter directory_mru<CR>
nnoremap <silent> [denite]F   :<C-u>DeniteBufferDir -buffer-name=files -start-filter file<CR>
nnoremap <silent> [denite]b   :<C-u>Denite -buffer-name=buffers -start-filter buffer<CR>
nnoremap <silent> [denite]o   :<C-u>Denite -buffer-name=outline -start-filter -split=vertical outline<CR>
nnoremap <silent> [denite]"   :<C-u>Denite -buffer-name=register register<CR>
nnoremap <silent> [denite]c   :<C-u>Denite -buffer-name=commands command<CR>
" nnoremap <silent> [denite]u   :<C-u>Denite -mode=insert source<CR>
nnoremap <silent> [denite]l   :<C-u>Denite -buffer-name=lines line<CR>
nnoremap <silent> [denite]g   :<C-u>Denite -buffer-name=grep grep<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Tab>
        \ denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> mf
        \ denite#do_map('toggle_matchers', 'fuzzy')
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  call deoplete#custom#buffer_option('auto_complete', v:false)
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
endfunction

if dein#tap("denite")
  call denite#custom#option('_', 'statusline', v:false)
  call denite#custom#option('_', 'prompt', '>')
  call denite#custom#option('_', 'split', 'floating')

  let s:denite_win_width_percent = 0.75
  let s:denite_win_height_percent = 0.7

  " Change denite default options
  call denite#custom#option('_', {
        \ 'split': 'floating',
        \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
        \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
        \ 'winheight': min([float2nr(&lines * s:denite_win_height_percent), 35]),
        \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
        \ })

  call denite#custom#filter('matcher/substring',
        \ 'clap_path', expand('~/.vim/bundle/repos/github.com/liuchengxu/vim-clap'))

  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

  " call denite#custom#source(
  " \ 'file', 'converters', ['converter/relative_abbr'])

  call denite#custom#source(
  \ 'file', 'matchers', ['matcher/substring'])

  call denite#custom#source(
  \ 'file', 'sorters', ['sorter/path'])

  call denite#custom#source(
  \ 'file/rec', 'matchers', ['matcher/substring'])

  call denite#custom#alias('source', 'file_rec/git', 'file/rec')
  call denite#custom#var('file_rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-d>', '<denite:scroll_window_downwards>', 'noremap')
  call denite#custom#map('insert', '<PageDown>', '<denite:scroll_page_forwards>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-u>', '<denite:scroll_window_upwards>', 'noremap')
  call denite#custom#map('insert', '<PageUp>', '<denite:scroll_page_backwards>', 'noremap')
endif
" }}}

" vim-clap {{{
nnoremap <silent> ,aff :<C-u>Clap files<CR>
nnoremap ,afp :<C-u>Clap files %:h:h
nnoremap <silent> ,afl :<C-u>Clap filer<CR>
nnoremap <silent> ,aF :<C-u>Clap files %:h<CR>
nnoremap <silent> ,afg :<C-u>Clap git_files<CR>
nnoremap <silent> ,ag :<C-u>Clap grep2<CR>
nnoremap <silent> ,a" :<C-u>Clap registers<CR>
nnoremap <silent> ,al :<C-u>Clap blines<CR>
nnoremap <silent> ,am :<C-u>Clap marks<CR>
nnoremap <silent> ,ao :<C-u>Clap proj_tags<CR>
nnoremap <silent> ,ac :<C-u>Clap bcommits<CR>
nnoremap <silent> ,ab :<C-u>Clap buffers<CR>

let g:clap_layout = { 'relative': 'editor' }
let g:clap_enable_background_shadow = v:false
MyAutocmd FileType clap_input inoremap <silent> <buffer> <C-O> <ESC>
MyAutocmd FileType clap_input nnoremap <silent> <buffer> q :<C-U>call clap#handler#exit()<CR>
" }}}

" vista.vim {{{
let g:vista_default_executive = 'ctags'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_executive_for = {
  \ 'rust': 'lcn',
  \ }
nnoremap <silent> <leader>v :<C-U>Vista!!<CR>
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
nnoremap [git]d :<C-u>Gdiffsplit HEAD<CR>
nnoremap [git]s :<C-u>Git<CR>
nnoremap [git]l :<C-u>Gclog HEAD~20..HEAD<CR>
nnoremap [git]L :<C-u>0Gclog<CR>
nnoremap [git]a :<C-u>Gwrite<CR>
nnoremap [git]c :<C-u>Git commit<CR>
nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]b :<C-u>Git blame<CR>
nnoremap [git]n :<C-u>Git now<CR>
nnoremap [git]N :<C-u>Git now --all<CR>
nnoremap [git]p :<C-u>GHPRBlame<CR>

" ftdetect is often failed
MyAutocmd BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif
MyAutocmd BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif
MyAutocmd BufEnter * if expand("%:t") =~ "PULLREQ_EDITMSG" | set ft=gitcommit | endif
" }}}

" gh.nvim {{{
if dein#tap('gh.nvim')
lua <<EOF
require('litee.lib').setup({
})
EOF
lua <<EOF
require('litee.gh').setup({
})
EOF
endif
" }}}

" vim-gitgitter {{{
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '**'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '*-'
"}}}

" vim-airline {{{
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline#extensions#tagbar#enabled = 0
let g:airline_powerline_fonts = 0
let g:airline_theme = "tender"
let g:airline#extensions#hunks#hunk_symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
  \ ]
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

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  set completeopt-=preview
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
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333373   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=DarkCyan ctermbg=12
" }}}

" submode.vim {{{
let g:submode_timeout = 0
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

" vim-choosewin {{{
if dein#tap('vim-choosewin')
  nmap _ <Plug>(choosewin)
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
  " Disable overwriting 'omnifunc'
  let g:github_complete_enable_omni_completion = 0
  augroup ConfigGithubComplete
    " <C-x><C-x> invokes completions of github-complete.vim
    autocmd! FileType markdown,gitcommit
          \ imap <C-x><C-x> <Plug>(github-complete-manual-completion)
  augroup END
endif

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conveal = 0

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

" ale {{{
if dein#tap('ale')
  let g:ale_cache_executable_check_failures = 1
endif
" }}}

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
nnoremap <silent> [space]ts   :<C-u>TweetVimUserStream<CR>
nnoremap <silent> [space]tt   :<C-u>TweetVimHomeTimeline<CR>
if dein#tap('TweetVim')
  let g:tweetvim_tweet_per_page = 50
  let g:tweetvim_include_rts = 1
  let g:tweetvim_display_icon = 1
endif
" }}}

" code snippet highlight {{{
let g:markdown_quote_syntax_filetypes = {
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
  tnoremap <C-j> <C-\><C-n>
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
endif
if dein#tap('neoterm')
  let g:neoterm_autoinsert = 1
  let g:neoterm_autoscroll = 1
  let g:neoterm_term_per_tab = 1
  let g:neoterm_default_mod = 'botright'
  let g:neoterm_automap_keys = ',tt'
  let g:neoterm_repl_ruby = 'pry'
  let g:neoterm_term_per_tab = 1

  nnoremap <silent> <f9> :TREPLSendLine<cr>
  vnoremap <silent> <f9> :TREPLSendSelection<cr>

" nvim-editcommand
if dein#tap('nvim-editcommand')
  let g:editcommand_prompt = '%'
endif

  " Useful maps
  " clear terminal
  nnoremap <silent> ,tl :<C-U>Tclear<cr>
  nnoremap <silent> ,tL :<C-U>Tclear!<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> ,tk :<C-U>Tkill<cr>

  " hide/close terminal
  nnoremap <silent> ,to :<C-U>Topen<cr>
  nnoremap <silent> ,tc :<C-U>Tclose<cr>
  nnoremap <silent> ,tC :<C-U>Tclose!<cr>
  nnoremap <silent> ,tac :<C-U>TcloseAll<cr>
  nnoremap <silent> ,taC :<C-U>TcloseAll!<cr>

  nnoremap <silent> ,te :<C-U>Tnew<cr>
  nnoremap <silent> ,tE :<C-U>tab Tnew<cr>
  nnoremap <silent> ,tn :<C-U>Tnext<cr>
  nnoremap <silent> ,tp :<C-U>Tprevious<cr>

  nnoremap <silent> ,tg :<C-U>Ttoggle<cr>
  nnoremap <silent> ,tag :<C-U>TtoggleAll<cr>

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

" vim-metarw-qiita
let g:qiita_user = "joker1007"
let g:qiita_per_page = 50

" vim-metarw-github-issues
let g:github_user = "joker1007"

" vim-json
let g:vim_json_syntax_conceal = 0

" markdown-composer
let g:markdown_composer_autostart = 0
let g:markdown_composer_refresh_rate = 10000

" ghost_text
augroup nvim_ghost_user_autocommands
  au User *github.com set filetype=markdown
augroup END

" vim-terraform
let g:terraform_fmt_on_save = 1

" rust.vim
let g:rustfmt_autosave = 1

MyAutocmd FileType rust let termdebugger = "rust-gdb"

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.local/bin/rust-analyzer'],
    \ 'ruby': ['bundle', 'exec', 'solargraph', 'stdio'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> <leader>d :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

syntax enable

if filereadable(expand('~/.vimrc.local.after'))
  execute 'source' expand('~/.vimrc.local.after')
endif

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call dein#call_hook('source')
endif
