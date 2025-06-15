vim.opt.termguicolors = true

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1

require "plugins"

vim.api.nvim_create_augroup("vimrc", {})

require "configs/keybinds"

-- enable exrc to load local vimrc
vim.opt.exrc = true

vim.opt.fileencodings = "ucs_bom,utf8,ucs-2le,ucs-2,iso-2022-jp-3,euc-jp,cp932"

vim.cmd [[packadd termdebug]]

vim.g.termdebug_useFloatingHover = 1
vim.g.termdebug_wide = 160

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
if vim.g.neovide then
  vim.opt.guifont = "Monospace:h14"
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_no_idle = true
end

vim.cmd [[
if exists("g:neovide")
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
    let &guifont = substitute(&guifont, 'h\d\+$', 'h14', '')
  endfunction
  nnoremap <C-=> :call FontSizePlus()<CR>
  nnoremap <C--> :call FontSizeMinus()<CR>
  nnoremap <C-0> :call FontSizeReset()<CR>
endif
]]

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

-- completion
vim.opt.complete = ".,w,b,u,t,i,d"

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

-- 最後に編集した場所にカーソルを移動する
vim.cmd [[autocmd! vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- colorscheme
-- 全角スペースをハイライト
vim.cmd [[autocmd! vimrc ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060]]
vim.cmd [[autocmd! vimrc VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')]]

vim.cmd.colorscheme "duskfox"

--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
--If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
--(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- neovim provider
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------}}}

-- filetype setter {{{
vim.filetype.add({
  filename = {
    [".git/COMMIT_EDITMSG"] = "gitcommit",
    [".git/rebase-merge"] = "gitrebase",
    ["PULLREQ_EDITMSG"] = "gitcommit",
  },
  pattern = {
    ["Steepfile"] = "ruby",
    [".*%.vpy"] = "python",
    [".*/hyprland%.conf"] = "hyprlang",
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
})
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

-- fix tree-sitter-ruby indent
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "ruby",
  command = "setlocal indentkeys-=.",
})

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
vim.cmd [[
let test#strategy = 'toggleterm'

let test#ruby#rspec#executable = 'rspec'

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

-- ale {{{
vim.g.ale_linters = { ruby = { "ruby" } }
vim.g.ale_linters_explicit = 1
vim.g.ale_cache_executable_check_failures = 1
-- }}}

-- ag.vim
vim.g.ag_prg = "rg --vimgrep --smart-case"

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

vim.cmd [[
let g:copilot_filetypes = {
\ 'text': v:false,
\ 'markdown': v:false,
\ }
]]

local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local capabilities = lsp_common.capabilities

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local lspconfig = require "lspconfig"

local lsp_config = require "lspconfig.configs"
if not lsp_config.termux_language_server then
  lsp_config.termux_language_server = {
    default_config = {
      cmd = { "termux-language-server" },
      filetypes = { "ebuild", "eclass" },
      root_dir = function(fname)
         return lspconfig.util.find_git_ancestor(fname)
      end,
    },
  }
end

lspconfig.termux_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require("mason-lspconfig").setup()

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

local clangd_capabilities = lsp_common.make_lsp_capabilities()
clangd_capabilities.textDocument.completion.editsNearCursor = true
clangd_capabilities.offsetEncoding = "utf-8"
vim.lsp.config("clangd", {
  capabilities = clangd_capabilities,
  on_attach = on_attach,
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
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.commitlint.with({
      condition = function(utils)
        return utils.root_has_file({ "commitlint.config.js" })
      end,
    }),
    null_ls.builtins.formatting.rubyfmt,
    null_ls.builtins.formatting.sqlfmt,
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
