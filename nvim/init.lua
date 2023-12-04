vim.opt.termguicolors = true

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1

require "plugins"

local wk = require "which-key"

-- enable exrc to load local vimrc
vim.opt.exrc = true

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
vim.opt.ttimeoutlen = 200
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
vim.opt.clipboard = "unnamed,unnamedplus"

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

vim.cmd [[colorscheme duskfox]]

--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
--If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
--(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- neovim provider
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------}}}

-- filetype setter {{{
local file_type_setter_group = vim.api.nvim_create_augroup("FileTypeSetter", {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "Steepfile" },
  group = file_type_setter_group,
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
vim.cmd [[autocmd! vimrc BufNewFile,BufRead *waybar/config set filetype=json]]

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

-- vim-choosewin {{{
vim.keymap.set("n", "_", "<Plug>(choosewin)", { remap = true })
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

-- replacer.nvim
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf" },
  group = "vimrc",
  callback = function()
    vim.keymap.set("n", "r", function()
      require("replacer").run()
    end, { buffer = 0 })
  end,
})

-- ale {{{
vim.g.ale_linters = { ruby = { "ruby" } }
vim.g.ale_linters_explicit = 1
vim.g.ale_cache_executable_check_failures = 1
-- }}}

-- ag.vim
vim.g.ag_prg = "rg --vimgrep --smart-case"

-- toggleterm {{{
vim.keymap.set("t", "<A-n>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")
--- }}}

-- markdown-composer
vim.g.markdown_composer_autostart = 0
vim.g.markdown_composer_refresh_rate = 10000

-- ghost_text
--
vim.cmd [[
let g:nvim_ghost_use_script = 1
let g:nvim_ghost_python_executable = '/usr/bin/python'
augroup nvim_ghost_user_autocommands
  au User *github.com set filetype=markdown
augroup END
]]

-- vim-terraform
vim.g.terraform_fmt_on_save = 1

-- rust.vim
vim.g.rustfmt_autosave = 1

vim.cmd [[autocmd vimrc FileType rust let termdebugger = "rust-gdb"]]

vim.g.cursorhold_updatetime = 100

-- LSP configs {{{

local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local capabilities = lsp_common.capabilities
local add_bundle_exec = lsp_common.add_bundle_exec

local noremap_silent = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap_silent)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap_silent)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap_silent)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap_silent)

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local lspconfig = require "lspconfig"

require("mason-lspconfig").setup_handlers({
  function(server_name)
    if server_name ~= "jdtls" then
      lspconfig[server_name].setup({
        capabilities = lsp_common.make_lsp_capabilities(),
        on_attach = on_attach,
      })
    end
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })
  end,
  ["clangd"] = function()
    local c = lsp_common.make_lsp_capabilities()
    c.textDocument.completion.editsNearCursor = true
    c.offsetEncoding = "utf-8"
    lspconfig.clangd.setup({
      capabilities = c,
      on_attach = on_attach,
    })
  end,
})

local null_ls = require "null-ls"
null_ls.setup({
  capabilities = capabilities,
  sources = {
    null_ls.builtins.formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ ".stylua.toml" })
      end,
    }),
    null_ls.builtins.diagnostics.rubocop.with({
      prefer_local = ".bundle/bin",
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml" })
      end,
    }),
    null_ls.builtins.diagnostics.luacheck.with({
      extra_args = { "--globals", "vim", "--globals", "awesome" },
    }),
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.commitlint.with({
      condition = function(utils)
        return utils.root_has_file({ "commitlint.config.js" })
      end,
    }),
    null_ls.builtins.formatting.rubyfmt,
    null_ls.builtins.formatting.rubocop.with({
      prefer_local = ".bundle/bin",
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml" })
      end,
    }),
    null_ls.builtins.completion.spell,
  },
})

local dap = require "dap"
dap.adapters.ruby = function(callback, config)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = {
        "exec",
        "rdbg",
        "-n",
        "--open",
        "--port",
        "${port}",
        "-c",
        "--",
        "bundle",
        "exec",
        config.command,
        config.script,
      },
    },
  })
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec line",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = function()
      local linenum = vim.api.nvim_win_get_cursor(0)[1]
      return vim.fn.expand "%:p" .. ":" .. linenum
    end,
  },
}

-- }}}

vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = "never",
    },
  },
}
if vim.g.started_by_firenvim then
  local firenvim_group = vim.api.nvim_create_augroup("Firenvim", {})
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = firenvim_group,
    callback = function()
      vim.opt_local.laststatus = 0
      vim.opt_local.showtabline = 0
    end,
  })
end
