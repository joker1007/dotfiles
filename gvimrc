"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=150
" ウインドウの高さ
set lines=50
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" どのモードでもマウスを使えるようにする
set mouse=a

if has('nvim')
  if exists('g:GuiLoaded')
    GuiFont! Monospace:h14
  endif
  if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Monospace 14')
  endif
endif

if !has('nvim')
  " GUIパーツの表示設定
  set guioptions=egimrLta
  "---------------------------------------------------------------------------
  " マウスに関する設定:
  "
  " 解説:
  " mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
  " ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
  " が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
  " という問題を引き起す。
  "
  " マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
  set nomousefocus
  " 入力時にマウスポインタを隠す (nomousehide:隠さない)
  set mousehide
  " ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
  set guioptions+=a

  " ポップアップメニューのカラーを設定
  hi Pmenu ctermbg=18 guibg=#666666
  hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
  hi PmenuSbar guibg=#333333

  set vb t_vb=
endif

"---------------------------------------------------------------------------
" ローカル設定:
if filereadable(expand('~/.gvimrc.local'))
  execute 'source' expand('~/.gvimrc.local')
endif
