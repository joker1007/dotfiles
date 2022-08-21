-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'Shougo/vimproc', run = 'make'}
  use 'tyru/eskk.vim'
  use 'tyru/skkdict.vim'

  use 'scrooloose/nerdcommenter'

  use 'thinca/vim-prettyprint'
  use 'mhinz/vim-startify'
  use 'kyazdani42/nvim-web-devicons'
  use 'junegunn/vim-emoji'

  use 'moro/vim-review'
  use 'cespare/vim-toml'

  use 'kana/vim-submode'

  use 'simeji/winresizer'

  use 'plasticboy/vim-markdown'

  use {'mattn/vim-maketable', ft = 'markdown'}

  -- colorschemes plugin {{{
  use 'glepnir/zephyr-nvim'
  use 'projekt0n/github-nvim-theme'
  use 'shaunsingh/nord.nvim'
  use {"EdenEast/nightfox.nvim", run = ":NightfoxCompile",}
  -- }}}

  -- ruby rails develop {{{
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'thinca/vim-quickrun'

  use 'leafgarland/typescript-vim'
  -- }}}

  -- vim-scripts {{{
  use 'vim-scripts/surround.vim'
  use 'vim-scripts/errormarker.vim'
  -- }}}

  -- smartchr textobj {{{
  use 'kana/vim-smartchr'
  use 'kana/vim-textobj-user'
  use 'kana/vim-niceblock'
  use {'nelstrom/vim-textobj-rubyblock', ft = 'ruby'}
  use 'kana/vim-textobj-indent'
  -- }}}


  -- html template {{{
  use 'mattn/emmet-vim'
  use 'slim-template/vim-slim'
  use 'tpope/vim-haml'
  use 'nono/vim-handlebars'
  use 'juvenn/mustache.vim'
  -- }}}

  -- visibility {{{
  use {'lukas-reineke/indent-blankline.nvim', config = function()
    require("indent_blankline").setup({
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
      },
      show_current_context = true,
    })
  end}

  use {'kevinhwang91/nvim-hlslens', config = function()
    local kopts = {noremap = true, silent = true}

    vim.api.nvim_set_keymap('n', 'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', 'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

    require("hlslens").setup({
      build_position_cb = function(plist, _, _, _)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
      end,
    })
    vim.cmd([[
      augroup scrollbar_search_hide
      autocmd!
      autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
      augroup END
    ]])
  end}
  use {'petertriho/nvim-scrollbar', config = function()
    require("scrollbar").setup()
  end}

  use 'LeafCage/foldCC'

  use {'nvim-lualine/lualine.nvim', config = function()
    require'my-lualine-setup'
  end}

  use {'nanozuki/tabby.nvim', config = function()
    require("tabby").setup({
      tabline = require("tabby.presets").active_wins_at_end,
    })
  end}

  use {'NvChad/nvim-colorizer.lua', config = function()
    require'colorizer'.setup(
      {}, 
      {
        RGB      = true;         -- #RGB hex codes
        RRGGBB   = true;         -- #RRGGBB hex codes
        names    = true;         -- "Name" codes like Blue oe blue
        RRGGBBAA = false;        -- #RRGGBBAA hex codes
        rgb_fn   = true;        -- CSS rgb() and rgba() functions
        hsl_fn   = false;        -- CSS hsl() and hsla() functions
        css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background, virtualtext
        mode     = 'background'; -- Set the display mode.
      }
    )
  end}
  use 'osyo-manga/vim-over'
-- }}}

  -- haskell develop {{{
  use 'dag/vim2hs'
  -- }}}

  -- web browse, api {{{
  use 'tyru/open-browser.vim'
  use 'mattn/webapi-vim'
  use {'kannokanno/previm', ft = 'markdown'}
  -- }}}

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require'my-treesitter-setup'
  end}
  use 'andymass/vim-matchup'
  use 'godlygeek/tabular'
  use 'dense-analysis/ale'
  use 'rhysd/github-complete.vim'
  use 'rhysd/ghpr-blame.vim'
  use 'hashivim/vim-terraform'
  use 'Shougo/vinarise.vim'
  use {'autozimu/LanguageClient-neovim', branch = 'next', run = 'bash install.sh'}

  use 'rking/ag.vim'
  use {'thinca/vim-qfreplace', cmd = {'Qfreplace'}}
  use 'octol/vim-cpp-enhanced-highlight'
  use 'derekwyatt/vim-scala'
  use 'rust-lang/rust.vim'
  use 'derekwyatt/vim-sbt'
  use 'elixir-lang/vim-elixir'
  use 'fatih/vim-go'
  use 'rhysd/devdocs.vim'
  use 'othree/html5.vim'
  use 'moskytw/nginx-contrib-vim'
  use 'osyo-manga/shabadou.vim'
  use 'mattn/httpstatus-vim'
  use 'tmux-plugins/vim-tmux'
  use {'windwp/nvim-spectre', requires = {'nvim-lua/plenary.nvim'}, config = function()
    vim.keymap.set('n', '<leader>S', function() require('spectre').open() end)

    -- search current word
    vim.keymap.set('n', '<leader>sw', function() require('spectre').open_visual({select_word=true}) end)
    vim.keymap.set('v', '<leader>s', function() require('spectre').open_visual() end)
    -- search in current file
    vim.keymap.set('n', '<leader>sp', function() require('spectre').open_file_search() end)

    require('spectre').setup({
      live_update = true,
    })
  end}

  use 'exu/pgsql.vim'

  use 'AndrewRadev/switch.vim'

  use 'kana/vim-altr'

  -- tweetvim {{{
  use 'basyura/bitly.vim'
  use 'basyura/twibill.vim'
  use 'basyura/TweetVim'
  -- }}}

  -- cursor move {{{
  use 'thinca/vim-visualstar'

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      vim.keymap.set('', '<leader><leader>f', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true }) end)
      vim.keymap.set('', '<leader><leader>F', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true }) end)
      vim.keymap.set('', '<leader><leader>w', function() require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR }) end)
      vim.keymap.set('', '<leader><leader>W', function() require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR }) end)
      vim.keymap.set('', '<leader><leader>/', function() require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR }) end)
      vim.keymap.set('', '<leader><leader>?', function() require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR }) end)
      require'hop'.setup {}
    end
  }
  use 't9md/vim-choosewin'
  use 'sunjon/shade.nvim'
  -- }}}

  -- git {{{
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
 use {'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup({numhl = true})
  end}
  use 'ldelossa/litee.nvim'
  use 'ldelossa/gh.nvim'

  use {'lambdalisue/vim-gista', cmd = {"Gista"}}
  -- }}}

  -- denite {{{
  use 'Shougo/neomru.vim'

  use 'Shougo/denite.nvim'
  use 'liuchengxu/vista.vim'
  -- }}}

  -- finder {{{
  use {
    'nvim-telescope/telescope.nvim',  branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      'cljoly/telescope-repo.nvim',
      'xiyaowong/telescope-emoji.nvim',
      'benfowler/telescope-luasnip.nvim',
    },
    config = function()
      require'my-telescope-setup'
      require'telescope'.load_extension('project')
      require'telescope'.load_extension('repo')
      require'telescope'.load_extension('emoji')
      require'telescope'.load_extension('luasnip')
    end
  }
  -- }}}

  -- completion {{{
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'rafamadriz/friendly-snippets'
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.cmd[[
        " press <Tab> to expand or jump in a snippet. These can also be mapped separately
        " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]]
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function ()
      require'cmp'.setup {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },

        sources = {
          {name = 'path'},
          {name = 'buffer', option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          }},
          {name = 'nvim_lua'},
          {name = 'luasnip'},
        },
      }
    end
  }
  -- }}}

  use 'mattn/vim-sonots'

  -- neovim {{{
  use 'equalsraf/neovim-gui-shim'
  use 'kassio/neoterm'
  use 'janko-m/vim-test'
  use 'brettanomyces/nvim-editcommand'
  use {'euclio/vim-markdown-composer', run = 'cargo build --release'}
  use 'subnut/nvim-ghost.nvim'
  use {'kyazdani42/nvim-tree.lua', config = function()
    require'my-nvim-tree-setup'
  end}
end)
