require'plugins'

local wk = require('which-key')

vim.opt.fileencodings = 'ucs_bom,utf8,ucs-2le,ucs-2,iso-2022-jp-3,euc-jp,cp932'

vim.cmd[[packadd termdebug]]

vim.g.termdebug_useFloatingHover = 1
vim.g.termdebug_wide = 160

vim.cmd[[
augroup vimrc
augroup END
]]

-- Basic Setting {{{
vim.opt.bs='indent,eol,start'   -- allow backspacing over everything in insert mode
vim.opt.ai=true                 -- always set autoindenting on
vim.opt.backup=false
vim.opt.swapfile=false
vim.opt.shada="'100,<1000,:10000,h"
vim.opt.history=10000
vim.opt.ruler=true
vim.opt.nu=true
vim.opt.ambiwidth='single'
vim.opt.display='uhex'
vim.opt.scrolloff=5             -- 常にカーソル位置から5行余裕を取る
vim.opt.virtualedit='block'
vim.opt.autoread=true
vim.opt.background='dark'
vim.opt.ttimeout=true
vim.opt.ttimeoutlen=100
vim.opt.signcolumn='yes'
vim.opt.updatetime=1000
vim.opt.mouse='a'
vim.opt.cursorline=true
vim.opt.conceallevel=1
vim.opt.undofile=true

-- swap ; and :
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')

-- Space prefix

-- Edit vimrc
vim.keymap.set('n', '<space>v', function() vim.cmd[[edit ~/.config/nvim/init.lua]] end)

-- Reload vimrc"{{{
vim.api.nvim_create_user_command(
  'ReloadVimrc',
  function()
    vim.fn.source('~/.config/nvim/init.lua')
    print "Reload vimrc"
  end,
  {}
)
-- }}}

-- タブストップ設定
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.softtabstop=0
vim.opt.expandtab=true
vim.opt.smarttab=true

-- 折り畳み設定
vim.opt.foldmethod='marker'
vim.keymap.set('n', ',fc', 'zM', {silent = true})
vim.keymap.set('n', ',fo', 'zR', {silent = true})
vim.cmd[[set foldtext=FoldCCtext()]]
vim.opt.foldcolumn='auto:3'

-- 検索設定
vim.opt.incsearch=true
vim.opt.hlsearch=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.wrapscan=true
vim.cmd[[nohlsearch]] -- reset highlight
vim.keymap.set('n', '<space>/', ':noh<CR>', {silent = true})
vim.keymap.set('n', '*', '<Plug>(visualstar-*)N', {remap = true})
vim.keymap.set('n', '#', '<Plug>(visualstar-#)N', {remap = true})

-- ステータスライン表示
vim.opt.laststatus=2
vim.opt.showmode=false
vim.opt.wildmenu=true
vim.opt.cmdheight=2
vim.opt.wildmode='list:full'
vim.opt.showcmd=true

-- tabline
vim.opt.showtabline=2
vim.cmd[[command! -nargs=+ -complete=file Te tabedit <args>]]
vim.cmd[[command! -nargs=* -complete=file Tn tabnew <args>]]
vim.keymap.set('n', '<S-Right>', ':<C-U>tabnext<CR>', {silent = true})
vim.keymap.set('n', '<S-Left>', ':<C-U>tabprevious<CR>', {silent = true})
vim.keymap.set('n', 'L', ':<C-U>tabnext<CR>', {silent = true})
vim.keymap.set('n', 'H', ':<C-U>tabprevious<CR>', {silent = true})
vim.keymap.set('n', '<C-L>', ':<C-U>tabmove +1<CR>', {silent = true})
vim.keymap.set('n', '<C-H>', ':<C-U>tabmove -1<CR>', {silent = true})

-- completion
vim.opt.complete='.,w,b,u,t,i,d'
vim.keymap.set('i', '<C-X><C-O>', '<C-X><C-O><C-P>')

-- クリップボード設定
vim.opt.clipboard='unnamedplus'

-- バッファ切り替え
vim.opt.hidden=true

-- Tab表示
vim.opt.list=true
vim.opt.listchars='tab:>-,trail:<'

-- タイトルを表示
vim.opt.title=true

-- 対応括弧を表示
vim.opt.showmatch=true

-- jkを直感的に
vim.keymap.set('n', 'j', 'gj', {silent = true})
vim.keymap.set('n', 'gj', 'j', {silent = true})
vim.keymap.set('n', 'k', 'gk', {silent = true})
vim.keymap.set('n', 'gk', 'k', {silent = true})
vim.keymap.set('n', '$', 'g$', {silent = true})
vim.keymap.set('n', 'g$', '$', {silent = true})
vim.keymap.set('v', 'j', 'gj', {silent = true})
vim.keymap.set('v', 'gj', 'j', {silent = true})
vim.keymap.set('v', 'k', 'gk', {silent = true})
vim.keymap.set('v', 'gk', 'k', {silent = true})
vim.keymap.set('v', '$', 'g$', {silent = true})
vim.keymap.set('v', 'g$', '$', {silent = true})

-- JとDで半ページ移動
vim.keymap.set('n', 'J', '<C-D>', {silent = true})
vim.keymap.set('n', 'K', '<C-U>', {silent = true})

-- 編集中のファイルのディレクトリに移動
vim.cmd[[command! CdCurrent execute ":cd" . expand("%:p:h")]]
vim.keymap.set('n', ',c', ':<C-U>CdCurrent<CR>:pwd<CR>', {silent = true})

-- 最後に編集した場所にカーソルを移動する
vim.cmd[[autocmd! vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- colorscheme
-- 全角スペースをハイライト
vim.cmd[[autocmd! vimrc ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060]]
vim.cmd[[autocmd! vimrc VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')]]

vim.cmd[[colorscheme zephyr]]

--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
--If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
--(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR=1
vim.opt.termguicolors=true

-- neovim provider
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------}}}


-- surround.vim {{{
vim.keymap.set('n', ',(', 'csw(', {remap = true})
vim.keymap.set('n', ',)', 'csw)', {remap = true})
vim.keymap.set('n', ',{', 'csw{', {remap = true})
vim.keymap.set('n', ',}', 'csw}', {remap = true})
vim.keymap.set('n', ',[', 'csw[', {remap = true})
vim.keymap.set('n', ',]', 'csw]', {remap = true})
vim.keymap.set('n', ",'", "csw'", {remap = true})
vim.keymap.set('n', ',"', 'csw"', {remap = true})
--}}}

-- from http://vim-users.jp/2011/04/hack214/ {{{
vim.keymap.set('v', '(', 't(', {remap = true})
vim.keymap.set('v', ')', 't)', {remap = true})
vim.keymap.set('v', ']', 't]', {remap = true})
vim.keymap.set('v', '[', 't[', {remap = true})
vim.keymap.set('o', '(', 't(', {remap = true})
vim.keymap.set('o', ')', 't)', {remap = true})
vim.keymap.set('o', ']', 't]', {remap = true})
vim.keymap.set('o', '[', 't[', {remap = true})
-- }}}

-- set paste
vim.cmd[[nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>]]

-- eskk {{{
vim.g["eskk#large_dictionary"] = { path = vim.env.HOME .. "/.vim/dict/skk/SKK-JISYO.L", sorted = 1, encoding = 'euc-jp'}
-- }}}

-- UTF8、SJIS(CP932)、EUCJPで開き直す {{{
vim.cmd[[command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>]]
vim.cmd[[command! -bang -nargs=? Sjis edit<bang> ++enc=cp932 <args>]]
vim.cmd[[command! -bang -nargs=? Euc edit<bang> ++enc=eucjp <args>]]
-- }}}

-- YAMLファイル用タブストップ設定
vim.cmd[[au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8]]

-- For avsc
vim.cmd[[autocmd! vimrc BufNewFile,BufRead *.avsc set filetype=json]]

-- バッファ切り替え {{{
vim.keymap.set('n', '<space>n', ':<C-U>bnext<CR>')
vim.keymap.set('n', '<space>p', ':<C-U>bprevious<CR>')
-- }}}


-- smartchr {{{
vim.cmd[[
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

autocmd vimrc FileType c,cpp,php,python,javascript,ruby,vim call s:EnableSmartchrBasic()
autocmd vimrc FileType python,ruby,vim call s:EnableSmartchrRegExp()
autocmd vimrc FileType ruby call s:EnableSmartchrRubyHash()
autocmd vimrc FileType ruby,eruby setlocal tags+=gems.tags,./gems.tags,~/rtags
autocmd vimrc FileType haml call s:EnableSmartchrHaml()
]]
-- }}}

-- shファイルの保存時にはファイルのパーミッションを755にする {{{
vim.cmd[[
function! s:ChangeShellScriptPermission()
  if !has("win32")
    if &ft =~ "\\(z\\|c\\|ba\\)\\?sh$" && expand('%:t') !~ "\\(zshrc\\|zshenv\\)$"
      call system("chmod 755 " . shellescape(expand('%:p')))
      echo "Set permission 755"
    endif
  endif
endfunction
autocmd vimrc BufWritePost * call s:ChangeShellScriptPermission()
]]
-- }}}

-- TOhtml
vim.g.html_number_lines = 0
vim.g.html_use_css = 1
vim.g.use_xhtml = 1
vim.g.html_use_encoding = 'utf-8'


-- quickrun{{{
vim.cmd[[
autocmd vimrc FileType quickrun setlocal concealcursor=""

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
autocmd vimrc BufReadPost *_spec.rb call s:RSpecQuickrun()

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
]]
-- }}}

-- vim-test
vim.keymap.set('n', '<space>tn', ':TestNearest<cr>')
vim.keymap.set('n', '<space>tf', ':TestFile<cr>')

vim.cmd[[let test#strategy = 'neoterm']]

vim.cmd[[let test#ruby#rspec#executable = 'rspec']]

vim.cmd[[
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
]]

-- webapi-vim
vim.g['webapi#system_function'] = "vimproc#system"

-- vista.vim {{{
vim.g.vista_default_executive = 'ctags'
vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
vim.g.vista_executive_for = {rust = 'lcn'}
vim.keymap.set('n', '<leader>v', ':<C-U>Vista!!<CR>', {silent = true})
-- }}}


-- Fugitive {{{
wk.register({
  [',g'] = {
    name = "+git",
  }
})
vim.keymap.set('n', ',gd', ':<C-u>DiffviewOpen<CR>')
vim.keymap.set('n', ',gs', ':<C-u>Git<CR>')
vim.keymap.set('n', ',gl', ':<C-u>Gclog HEAD~20..HEAD<CR>')
vim.keymap.set('n', ',gh', ':<C-u>DiffviewFileHistory %<CR>')
vim.keymap.set('n', ',ga', ':<C-u>Gwrite<CR>')
vim.keymap.set('n', ',gc', ':<C-u>Git commit<CR>')
vim.keymap.set('n', ',gC', ':<C-u>Git commit --amend<CR>')
vim.keymap.set('n', ',gb', ':<C-u>Git blame<CR>')
vim.keymap.set('n', ',gn', ':<C-u>Git now<CR>')
vim.keymap.set('n', ',gN', ':<C-u>Git now --all<CR>')
vim.keymap.set('n', ',gp', ':<C-u>GHPRBlame<CR>')

vim.cmd[[autocmd vimrc BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif]]
vim.cmd[[autocmd vimrc BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif]]
vim.cmd[[autocmd vimrc BufEnter * if expand("%:t") =~ "PULLREQ_EDITMSG" | set ft=gitcommit | endif]]
-- }}}


-- vim-altr {{{
vim.keymap.set('n', '<F3>', '<Plug>(altr-forward)', {remap = true})
vim.keymap.set('n', '<F2>', '<Plug>(altr-back)', {remap = true})
-- For ruby tdd
vim.fn['altr#define']('%.rb', 'spec/%_spec.rb')
-- For ruby tdd
vim.fn['altr#define']('lib/%.rb', 'spec/lib/%_spec.rb', 'spec/%_spec.rb')
-- For rails tdd
vim.fn['altr#define']('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
vim.fn['altr#define']('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
vim.fn['altr#define']('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
vim.fn['altr#define']('app/%.rb', 'spec/%_spec.rb')
-- }}}

-- vim-choosewin {{{
vim.keymap.set('n', '_', '<Plug>(choosewin)', {remap = true})
-- }}}


-- switch.vim {{{
vim.cmd[[
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
]]
-- }}}

-- github-complete.vim' {{{
vim.cmd[[
  " Disable overwriting 'omnifunc'
  let g:github_complete_enable_omni_completion = 0
  augroup ConfigGithubComplete
    " <C-x><C-x> invokes completions of github-complete.vim
    autocmd! FileType markdown,gitcommit
          \ imap <C-x><C-x> <Plug>(github-complete-manual-completion)
  augroup END
]]
-- }}}

-- vim-markdown
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_new_list_item_indent = 0


-- Quickfix
vim.keymap.set('n', ',q', ':<C-U>copen<CR>', {silent = true})
vim.keymap.set('n', ']q', ':<C-U>cnext<CR>', {silent = true})
vim.keymap.set('n', '[q', ':<C-U>cprev<CR>', {silent = true})
vim.keymap.set('n', ']Q', ':<C-U>clast<CR>', {silent = true})
vim.keymap.set('n', '[Q', ':<C-U>cfirst<CR>', {silent = true})


-- errormarker.vim
vim.cmd[[let errormarker_disablemappings = 1]]

-- Merge Setting
vim.cmd[[
if &diff
  nmap <buffer> <leader>1 :diffget LOCAL<CR>
  nmap <buffer> <leader>2 :diffget BASE<CR>
  nmap <buffer> <leader>3 :diffget REMOTE<CR>
endif
]]

-- Tabular {{{
wk.register({
  ['<leader>a'] = {name = '+Tabularize'}
})
vim.keymap.set('n', '<Leader>a,', ':Tabularize /,<CR>')
vim.keymap.set('n', '<Leader>a=', ':Tabularize /=<CR>')
vim.keymap.set('n', '<Leader>a>', ':Tabularize /=><CR>')
vim.keymap.set('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
vim.keymap.set('n', '<Leader>a<Bar>', ':Tabularize /<Bar><CR>')

vim.keymap.set('v', '<Leader>a,', ':Tabularize /,<CR>')
vim.keymap.set('v', '<Leader>a=', ':Tabularize /=<CR>')
vim.keymap.set('v', '<Leader>a>', ':Tabularize /=><CR>')
vim.keymap.set('v', '<Leader>a:', ':Tabularize /:\zs<CR>')
vim.keymap.set('v', '<Leader>a<Bar>', ':Tabularize /<Bar><CR>')
-- }}}

-- qfreplace
vim.cmd[[autocmd vimrc FileType qf nnoremap <buffer> r :<C-U>Qfreplace<CR>]]


-- ale {{{
vim.g.ale_cache_executable_check_failures = 1
-- }}}

-- ag.vim
vim.g.ag_prg="ag --vimgrep --smart-case"


-- TweetVim {{{
vim.keymap.set('n', 'S', ':<C-u>TweetVimSay<CR>', {silent = true})
vim.keymap.set('n', '<space>tt', ':<C-u>TweetVimHomeTimeline<CR>', {silent = true})
vim.g.tweetvim_tweet_per_page = 50
vim.g.tweetvim_include_rts = 1
vim.g.tweetvim_display_icon = 1
-- }}}

-- code snippet highlight {{{
vim.cmd[[
let g:markdown_quote_syntax_filetypes = {
        \ "mustache" : {
        \   "start" : "mustache",
        \},
        \ "haml" : {
        \   "start" : "haml",
        \},
  \}
]]
-- }}}


-- neoterm {{{
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>')
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')

vim.g.neoterm_autoinsert = 1
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_term_per_tab = 1
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_automap_keys = ',tt'
vim.g.neoterm_repl_ruby = 'pry'
vim.g.neoterm_term_per_tab = 1

vim.keymap.set('n', '<F9>', ':TREPLSendLine<cr>')
vim.keymap.set('v', '<F9>', ':TREPLSendSelection<cr>')
--- }}}

-- nvim-editcommand
vim.g.editcommand_prompt = '%'

-- Useful maps
wk.register({
  [',t'] = {name = '+Terminal'}
})
-- clear terminal
vim.keymap.set('n', ',tl', ':<C-U>Tclear<cr>')
vim.keymap.set('n', ',tL', ':<C-U>Tclear!<cr>')
-- kills the current job (send a <c-c>)
vim.keymap.set('n', ',tk', ':<C-U>Tkill<cr>')

-- hide/close terminal
vim.keymap.set('n', ',to', ':<C-U>Topen<cr>')
vim.keymap.set('n', ',tc', ':<C-U>Tclose<cr>')
vim.keymap.set('n', ',tC', ':<C-U>Tclose!<cr>')
vim.keymap.set('n', ',tac', ':<C-U>TcloseAll<cr>')
vim.keymap.set('n', ',taC', ':<C-U>TcloseAll!<cr>')

vim.keymap.set('n', ',te', ':<C-U>Tnew<cr>')
vim.keymap.set('n', ',tE', ':<C-U>tab Tnew<cr>')
vim.keymap.set('n', ',tn', ':<C-U>Tnext<cr>')
vim.keymap.set('n', ',tp', ':<C-U>Tprevious<cr>')

vim.keymap.set('n', ',tg', ':<C-U>Ttoggle<cr>')
vim.keymap.set('n', ',tag', ':<C-U>TtoggleAll<cr>')

-- Git commands
vim.cmd[[command! -nargs=+ Tg :T git <args>]]
-- }}}


-- markdown-composer
vim.g.markdown_composer_autostart = 0
vim.g.markdown_composer_refresh_rate = 10000

-- ghost_text
vim.cmd[[
augroup nvim_ghost_user_autocommands
  au User *github.com set filetype=markdown
augroup END
]]

-- vim-terraform
vim.g.terraform_fmt_on_save = 1

-- rust.vim
vim.g.rustfmt_autosave = 1

vim.cmd[[autocmd vimrc FileType rust let termdebugger = "rust-gdb"]]

-- LanguageClient
vim.cmd[[
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.local/bin/rust-analyzer'],
    \ 'ruby': ['bundle', 'exec', 'solargraph', 'stdio'],
    \ }
]]
vim.keymap.set('n', '<F5>', function() vim.fn.LanguageClient_contextMenu() end, {silent = true})
-- Or map each action separately
vim.keymap.set('n', '<leader>d', function() vim.fn['LanguageClient#textDocument_hover']() end, {silent = true})
vim.keymap.set('n', 'gd', function() vim.fn['LanguageClient#textDocument_definition']() end, {silent = true})
vim.keymap.set('n', '<F6>', function() vim.fn['LanguageClient#textDocument_rename']() end, {silent = true})
