require "plugins"

local wk = require "which-key"

vim.opt.fileencodings = "ucs_bom,utf8,ucs-2le,ucs-2,iso-2022-jp-3,euc-jp,cp932"

vim.cmd [[packadd termdebug]]

vim.g.termdebug_useFloatingHover = 1
vim.g.termdebug_wide = 160

vim.api.nvim_create_augroup("vimrc", {})

-- Basic Setting {{{
vim.opt.bs = "indent,eol,start" -- allow backspacing over everything in insert mode
vim.opt.ai = true -- always set autoindenting on
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shada = "'100,<1000,:10000,h"
vim.opt.history = 10000
vim.opt.ruler = true
vim.opt.nu = true
vim.opt.ambiwidth = "single"
vim.opt.display = "uhex"
vim.opt.scrolloff = 5 -- 常にカーソル位置から5行余裕を取る
vim.opt.virtualedit = "block"
vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 1000
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.conceallevel = 1
vim.opt.undofile = true
vim.opt.timeoutlen = 500

-- gui configs
vim.cmd [[
if exists("g:neovide")
  set guifont=Monospace:h12
  let g:neovide_cursor_vfx_mode="wireframe"
  let g:neovide_transparency=0.9
  let g:neovide_cursor_vfx_mode = "railgun"
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
]]

-- swap ; and :
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", ":", ";", {})
vim.keymap.set("v", ";", ":", {})
vim.keymap.set("v", ":", ";", {})

-- Space prefix

-- Edit vimrc
local sfile = debug.getinfo(1, "S").short_src
vim.keymap.set("n", "<space>v", function()
  vim.cmd("edit " .. sfile)
end, {})

-- Reload vimrc"{{{
vim.api.nvim_create_user_command("ReloadVimrc", function()
  vim.fn.source(sfile)
  print "Reload vimrc"
end, {})
-- }}}

-- タブストップ設定
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true

-- 折り畳み設定
vim.opt.foldmethod = "marker"
vim.opt.foldcolumn = "auto:3"

-- 検索設定
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.cmd [[nohlsearch]] -- reset highlight
vim.keymap.set("n", "<space>/", ":noh<CR>", { silent = true })
vim.keymap.set("n", "*", "<Plug>(visualstar-*)N", { remap = true })
vim.keymap.set("n", "#", "<Plug>(visualstar-#)N", { remap = true })

-- ステータスライン表示
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.cmdheight = 2
vim.opt.wildmode = "list:full"
vim.opt.showcmd = true

-- tabline
vim.opt.showtabline = 2
vim.api.nvim_create_user_command("Te", "tabedit <args>", { nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("Tn", "tabnew <args>", { nargs = "*", complete = "file" })
vim.keymap.set("n", "<S-Right>", ":<C-U>tabnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", ":<C-U>tabprevious<CR>", { silent = true })
vim.keymap.set("n", "L", ":<C-U>tabnext<CR>", { silent = true })
vim.keymap.set("n", "H", ":<C-U>tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<C-L>", ":<C-U>tabmove +1<CR>", { silent = true })
vim.keymap.set("n", "<C-H>", ":<C-U>tabmove -1<CR>", { silent = true })

-- completion
vim.opt.complete = ".,w,b,u,t,i,d"
vim.keymap.set("i", "<C-X><C-O>", "<C-X><C-O><C-P>")

-- クリップボード設定
vim.opt.clipboard = "unnamedplus"

-- バッファ切り替え
vim.opt.hidden = true

-- Tab表示
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:<"

-- タイトルを表示
vim.opt.title = true

-- 対応括弧を表示
vim.opt.showmatch = true

-- jkを直感的に
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "gj", "j", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "gk", "k", { silent = true })
vim.keymap.set("n", "$", "g$", { silent = true })
vim.keymap.set("n", "g$", "$", { silent = true })
vim.keymap.set("v", "j", "gj", { silent = true })
vim.keymap.set("v", "gj", "j", { silent = true })
vim.keymap.set("v", "k", "gk", { silent = true })
vim.keymap.set("v", "gk", "k", { silent = true })
vim.keymap.set("v", "$", "g$", { silent = true })
vim.keymap.set("v", "g$", "$", { silent = true })

-- JとDで半ページ移動
vim.keymap.set("n", "J", "<C-D>", { silent = true })
vim.keymap.set("n", "K", "<C-U>", { silent = true })

-- 編集中のファイルのディレクトリに移動
vim.cmd [[command! CdCurrent execute ":cd" . expand("%:p:h")]]
vim.keymap.set("n", ",c", ":<C-U>CdCurrent<CR>:pwd<CR>", { silent = true })

-- 最後に編集した場所にカーソルを移動する
vim.cmd [[autocmd! vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- colorscheme
-- 全角スペースをハイライト
vim.cmd [[autocmd! vimrc ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060]]
vim.cmd [[autocmd! vimrc VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')]]

vim.cmd [[colorscheme zephyr]]

--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
--If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
--(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.termguicolors = true

-- neovim provider
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------}}}

-- filetype setter {{{
vim.api.nvim_create_augroup("FileTypeSetter", {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "Steepfile" },
  command = "set ft=ruby",
})
-- }}}

-- surround.vim {{{
vim.keymap.set("n", ",(", "csw(", { remap = true })
vim.keymap.set("n", ",)", "csw)", { remap = true })
vim.keymap.set("n", ",{", "csw{", { remap = true })
vim.keymap.set("n", ",}", "csw}", { remap = true })
vim.keymap.set("n", ",[", "csw[", { remap = true })
vim.keymap.set("n", ",]", "csw]", { remap = true })
vim.keymap.set("n", ",'", "csw'", { remap = true })
vim.keymap.set("n", ',"', 'csw"', { remap = true })
--}}}

-- from http://vim-users.jp/2011/04/hack214/ {{{
vim.keymap.set("v", "(", "t(", { remap = true })
vim.keymap.set("v", ")", "t)", { remap = true })
vim.keymap.set("v", "]", "t]", { remap = true })
vim.keymap.set("v", "[", "t[", { remap = true })
vim.keymap.set("o", "(", "t(", { remap = true })
vim.keymap.set("o", ")", "t)", { remap = true })
vim.keymap.set("o", "]", "t]", { remap = true })
vim.keymap.set("o", "[", "t[", { remap = true })
-- }}}

-- set paste
vim.cmd [[nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>]]

-- eskk {{{
vim.g["eskk#large_dictionary"] = { path = "/usr/share/skk/SKK-JISYO.L", sorted = 1, encoding = "euc-jp" }
-- }}}

-- UTF8、SJIS(CP932)、EUCJPで開き直す {{{
vim.cmd [[command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>]]
vim.cmd [[command! -bang -nargs=? Sjis edit<bang> ++enc=cp932 <args>]]
vim.cmd [[command! -bang -nargs=? Euc edit<bang> ++enc=eucjp <args>]]
-- }}}

-- YAMLファイル用タブストップ設定
vim.cmd [[au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8]]

-- For avsc
vim.cmd [[autocmd! vimrc BufNewFile,BufRead *.avsc set filetype=json]]

-- バッファ切り替え {{{
vim.keymap.set("n", "<space>n", ":<C-U>bnext<CR>")
vim.keymap.set("n", "<space>p", ":<C-U>bprevious<CR>")
-- }}}

-- smartchr {{{
vim.cmd [[
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

autocmd vimrc FileType c,cpp,php,python,javascript,ruby,vim call s:EnableSmartchrBasic()
autocmd vimrc FileType python,ruby,vim call s:EnableSmartchrRegExp()
autocmd vimrc FileType ruby call s:EnableSmartchrRubyHash()
autocmd vimrc FileType ruby,eruby setlocal tags+=gems.tags,./gems.tags,~/rtags
autocmd vimrc FileType haml call s:EnableSmartchrHaml()
]]
-- }}}

-- shファイルの保存時にはファイルのパーミッションを755にする {{{
vim.cmd [[
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
vim.g.html_use_encoding = "utf-8"

-- quickrun{{{
vim.cmd [[
autocmd vimrc FileType quickrun setlocal concealcursor=""

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
vim.keymap.set("n", "<space>tn", ":TestNearest<cr>")
vim.keymap.set("n", "<space>tf", ":TestFile<cr>")

vim.cmd [[let test#strategy = 'toggleterm']]

vim.cmd [[let test#ruby#rspec#executable = 'rspec']]

vim.cmd [[
function! DockerTransformer(cmd) abort
  if $APP_CONTAINER_NAME != ''
    let container_id = trim(system('docker ps --filter name=$APP_CONTAINER_NAME -q'))
    return 'docker exec -t ' . container_id . ' bundle exec ' . a:cmd
  else
    return 'bundle exec ' . a:cmd
  endif
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransformer')}
let g:test#transformation = 'docker'
]]

-- webapi-vim
vim.g["webapi#system_function"] = "vimproc#system"

-- vista.vim {{{
vim.g.vista_default_executive = "ctags"
vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
vim.g.vista_executive_for = { rust = "lcn" }
vim.keymap.set("n", "<leader>v", ":<C-U>Vista!!<CR>", { silent = true })
-- }}}

-- Fugitive {{{
wk.register({
  [",g"] = {
    name = "+git",
  },
})
vim.keymap.set("n", ",gd", ":<C-u>DiffviewOpen<CR>")
vim.keymap.set("n", ",gs", ":<C-u>Git<CR>")
vim.keymap.set("n", ",gl", ":<C-u>Gclog HEAD~20..HEAD<CR>")
vim.keymap.set("n", ",gh", ":<C-u>DiffviewFileHistory %<CR>")
vim.keymap.set("n", ",ga", ":<C-u>Gwrite<CR>")
vim.keymap.set("n", ",gc", ":<C-u>Git commit<CR>")
vim.keymap.set("n", ",gC", ":<C-u>Git commit --amend<CR>")
vim.keymap.set("n", ",gb", ":<C-u>Git blame<CR>")
vim.keymap.set("n", ",gn", ":<C-u>Git now<CR>")
vim.keymap.set("n", ",gN", ":<C-u>Git now --all<CR>")
vim.keymap.set("n", ",gp", ":<C-u>GHPRBlame<CR>")

vim.cmd [[autocmd vimrc BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif]]
vim.cmd [[autocmd vimrc BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif]]
vim.cmd [[autocmd vimrc BufEnter * if expand("%:t") =~ "PULLREQ_EDITMSG" | set ft=gitcommit | endif]]
-- }}}

-- vim-choosewin {{{
vim.keymap.set("n", "_", "<Plug>(choosewin)", { remap = true })
-- }}}

-- switch.vim {{{
vim.cmd [[
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
vim.cmd [[
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
vim.keymap.set("n", ",q", ":<C-U>copen<CR>", { silent = true })
vim.keymap.set("n", "]q", ":<C-U>cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":<C-U>cprev<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":<C-U>clast<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":<C-U>cfirst<CR>", { silent = true })

-- errormarker.vim
vim.cmd [[let errormarker_disablemappings = 1]]

-- Merge Setting
vim.cmd [[
if &diff
  nmap <buffer> <leader>1 :diffget LOCAL<CR>
  nmap <buffer> <leader>2 :diffget BASE<CR>
  nmap <buffer> <leader>3 :diffget REMOTE<CR>
endif
]]

-- Tabular {{{
wk.register({
  ["<leader>a"] = { name = "+Tabularize" },
})
vim.keymap.set("n", "<Leader>a,", ":Tabularize /,<CR>")
vim.keymap.set("n", "<Leader>a=", ":Tabularize /=<CR>")
vim.keymap.set("n", "<Leader>a>", ":Tabularize /=><CR>")
vim.keymap.set("n", "<Leader>a:", ":Tabularize /:\zs<CR>")
vim.keymap.set("n", "<Leader>a<Bar>", ":Tabularize /<Bar><CR>")

vim.keymap.set("v", "<Leader>a,", ":Tabularize /,<CR>")
vim.keymap.set("v", "<Leader>a=", ":Tabularize /=<CR>")
vim.keymap.set("v", "<Leader>a>", ":Tabularize /=><CR>")
vim.keymap.set("v", "<Leader>a:", ":Tabularize /:\zs<CR>")
vim.keymap.set("v", "<Leader>a<Bar>", ":Tabularize /<Bar><CR>")
-- }}}

-- qfreplace
vim.cmd [[autocmd vimrc FileType qf nnoremap <buffer> r :<C-U>Qfreplace<CR>]]

-- ale {{{
vim.g.ale_linters = { ruby = { "ruby" } }
vim.g.ale_linters_explicit = 1
vim.g.ale_cache_executable_check_failures = 1
vim.g.ale_lua_luacheck_options = "--globals vim"
-- }}}

-- ag.vim
vim.g.ag_prg = "rg --vimgrep --smart-case"

-- TweetVim {{{
vim.keymap.set("n", "S", ":<C-u>TweetVimSay<CR>", { silent = true })
vim.keymap.set("n", "<space>tt", ":<C-u>TweetVimHomeTimeline<CR>", { silent = true })
vim.g.tweetvim_tweet_per_page = 50
vim.g.tweetvim_include_rts = 1
vim.g.tweetvim_display_icon = 1
-- }}}

-- toggleterm {{{
vim.keymap.set("t", "<A-n>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")

vim.keymap.set("n", "<F9>", "<cmd>ToggleTermSendCurrentLine<cr>")
vim.keymap.set("v", "<F9>", "<cmd>ToggleTermSendVisualSelection<cr>")
--- }}}

-- nvim-editcommand
vim.g.editcommand_prompt = "%"

-- Git commands
vim.cmd [[command! -nargs=+ Tg :T git <args>]]
-- }}}

-- markdown-composer
vim.g.markdown_composer_autostart = 0
vim.g.markdown_composer_refresh_rate = 10000

-- ghost_text
vim.cmd [[
augroup nvim_ghost_user_autocommands
  au User *github.com set filetype=markdown
augroup END
]]

-- vim-terraform
vim.g.terraform_fmt_on_save = 1

-- rust.vim
vim.g.rustfmt_autosave = 1

vim.cmd [[autocmd vimrc FileType rust let termdebugger = "rust-gdb"]]

-- todo-comments.nvim
require("todo-comments").setup()

vim.g.cursorhold_updatetime = 100

-- LSP configs {{{

local noremap_silent = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap_silent)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap_silent)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap_silent)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap_silent)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
  vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  vim.keymap.set("n", "gs", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
  vim.keymap.set("n", "<F6>", "<cmd>Lspsaga rename<CR>", { silent = true })
  vim.keymap.set("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
  vim.keymap.set("v", "<space>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
  vim.keymap.set("n", "<space>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  vim.keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  vim.keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  vim.keymap.set("n", "<space>cf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local luadev = require("lua-dev").setup()

local add_bundle_exec = function(config, gem, dir)
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle info " .. gem, {
    cwd = dir,
    on_exit = function(_, data)
      ret_code = data
    end,
  })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    table.insert(config.cmd, 1, "exec")
    table.insert(config.cmd, 1, "bundle")
  end
end

local lspconfig = require "lspconfig"
require("mason-lspconfig").setup_handlers({
  function(server_name)
    if (server_name ~= "jdtls") then
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
  end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", luadev, {
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    }))
  end,
  ["solargraph"] = function()
    lspconfig.solargraph.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      on_new_config = function(config, root_dir)
        add_bundle_exec(config, "solargraph", root_dir)
        return config
      end,
    })
  end,
})

lspconfig.steep.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  on_new_config = function(config, root_dir)
    add_bundle_exec(config, "steep", root_dir)
    return config
  end,
})

local lspconfig_configs = require "lspconfig.configs"
local lspconfig_util = require "lspconfig.util"
if not lspconfig_configs["ruby-lsp"] then
  lspconfig_configs["ruby-lsp"] = {
    default_config = {
      cmd = { "bundle", "exec", "ruby-lsp" },
      filetypes = { "ruby" },
      root_dir = lspconfig_util.root_pattern("Gemfile", ".git"),
      init_options = {
        enabledFeatures = {
          "documentHighlights",
          "documentSymbols",
          "foldingRanges",
          "selectionRanges",
          "semanticHighlighting",
          "formatting",
          "diagnostics",
          "codeActions",
        },
      },
    },
    docs = {
      description = [[https://github.com/Shopify/ruby-lsp]],
      default_config = {
        root_dir = [[root_pattern(".git")]],
      },
    },
  }
end

-- lspconfig["ruby-lsp"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

require("null-ls").setup({
  capabilities = capabilities,
  sources = {
    require("null-ls").builtins.formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ ".stylua.toml" })
      end,
    }),
    require("null-ls").builtins.diagnostics.rubocop.with({
      prefer_local = "bundle_bin",
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml" })
      end,
    }),
    require("null-ls").builtins.diagnostics.luacheck.with({
      extra_args = { "--globals", "vim", "--globals", "awesome" },
    }),
    require("null-ls").builtins.diagnostics.yamllint,
    require("null-ls").builtins.formatting.rubocop.with({
      prefer_local = "bundle_bin",
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml" })
      end,
    }),
    require("null-ls").builtins.completion.spell,
  },
})
-- }}}
