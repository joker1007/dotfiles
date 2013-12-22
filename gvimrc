"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=150
" ウインドウの高さ
set lines=50
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" GUIパーツの表示設定
set guioptions=egimrLta

"---------------------------------------------------------------------------
" フォント設定:
"

if &guifont == ""
  if has('win32')
    " Windows用
    set guifont=M+2VM+IPAG_circle:h11,KonatuTohaba:h12,MS_Gothic:h12:cSHIFTJIS
    "set guifont=MS_Mincho:h12:cSHIFTJIS
    " 行間隔の設定
    set linespace=1
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
      set ambiwidth=auto
    endif
  elseif has('mac')
    set guifont=Ricty:h14
  else
    set guifont=M+1VM+IPAG\ circle\ 10
  endif
endif


"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a

colorscheme railscasts

" ポップアップメニューのカラーを設定
hi Pmenu ctermbg=18 guibg=#666666
hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

"---------------------------------------------------------------------------
" ローカル設定:
if filereadable(expand('~/.gvimrc.local'))
  execute 'source' expand('~/.gvimrc.local')
endif

