-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'tyru/eskk.vim', event = {'InsertEnter'}}
  use 'tyru/skkdict.vim'

  use 'kyazdani42/nvim-web-devicons'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = '\\cc',
          block = '\\cb',
        },
        opleader = {
          line = '\\cc',
          block = '\\cb',
        },
      })
    end
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  -- filetype plugins {{{
  use 'moro/vim-review'
  use 'cespare/vim-toml'

  use 'vim-ruby/vim-ruby'
  use 'leafgarland/typescript-vim'
  use 'rust-lang/rust.vim'
  use 'elixir-editors/vim-elixir'
  use 'fatih/vim-go'
  use 'hashivim/vim-terraform'
  use 'tmux-plugins/vim-tmux'
  use 'moskytw/nginx-contrib-vim'
  use 'exu/pgsql.vim'
  -- }}}

  -- markdown {{{
  use {'mattn/vim-maketable', ft = 'markdown'}
  use 'plasticboy/vim-markdown'
  use {'kannokanno/previm', ft = 'markdown'}
  use {'euclio/vim-markdown-composer', run = 'cargo build --release'}
  -- }}}

  -- colorschemes plugin {{{
  use 'glepnir/zephyr-nvim'
  use 'projekt0n/github-nvim-theme'
  use 'shaunsingh/nord.nvim'
  use {"EdenEast/nightfox.nvim", run = ":NightfoxCompile",}
  -- }}}

  -- smartchr textobj {{{
  use 'vim-scripts/surround.vim'
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

  -- syntax, visibility {{{
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require'my-treesitter-setup'
  end}

  use {'lukas-reineke/indent-blankline.nvim',
    setup = function()
      vim.cmd[[hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd[[hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd[[hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd[[hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd[[hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd[[hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
    end,
    config = function()
      require("indent_blankline").setup({
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
        show_current_context = true,
      })
    end
  }

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
    require("scrollbar").setup({
      handle = {
        color = '#41AFEF',
      },
    })
    require("scrollbar.handlers.search").setup()
  end}

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_open = true,
        auto_close = true,
      })

      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
        {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
        {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
        {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
        {silent = true, noremap = true}
      )
    end
  }

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

  use 'octol/vim-cpp-enhanced-highlight'

  use 'osyo-manga/vim-over'
-- }}}

  -- web browse, api {{{
  use 'tyru/open-browser.vim'
  use 'mattn/webapi-vim'
  -- }}}

  -- tweetvim {{{
  use 'basyura/bitly.vim'
  use 'basyura/twibill.vim'
  use 'basyura/TweetVim'
  -- }}}

  -- git {{{
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
  use {'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup({numhl = true})
  end}

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }

  use {'lambdalisue/vim-gista', cmd = {"Gista"}}
  use {'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim'}, config = function()
    require'diffview'.setup()
  end}
  -- }}}

  -- denite {{{
  use 'Shougo/neomru.vim'
  use 'Shougo/denite.nvim'
  -- }}}

  -- search, finder {{{
  use 'rking/ag.vim'
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

  use 'liuchengxu/vista.vim'

  use {
    'nvim-telescope/telescope.nvim',  branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      'cljoly/telescope-repo.nvim',
      'xiyaowong/telescope-emoji.nvim',
      'benfowler/telescope-luasnip.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      require'my-telescope-setup'
      require'telescope'.load_extension('project')
      require'telescope'.load_extension('repo')
      require'telescope'.load_extension('emoji')
      require'telescope'.load_extension('luasnip')
      require'telescope'.load_extension('file_browser')
    end
  }

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
  -- }}}

  -- completion, diagnostics {{{
  use {'autozimu/LanguageClient-neovim', branch = 'next', run = 'bash install.sh'}
  use 'dense-analysis/ale'

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
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'nvim-lua/plenary.nvim', -- required by cmp-git
      'petertriho/cmp-git',
    },
    config = function ()
      local cmp = require'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },

        sources = cmp.config.sources({
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
          {name = 'cmdline'},
          {name = 'git'},
          {name = 'emoji'},
        }),

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

      }

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })

      require'cmp_git'.setup()
    end
  }
  -- }}}

  -- terminal, execution {{{
  use {'Shougo/vimproc', run = 'make'}
  use 'thinca/vim-quickrun'

  use 'kassio/neoterm'
  use 'janko-m/vim-test'

  use {'nikvdp/neomux', cmd = "Neomux", keys = '\\sh'}
  -- }}}

  use {'mattn/vim-sonots', cmd = "Sonots"}

  -- other utils {{{
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {
        snippet_engine = "luasnip",
      }
      vim.keymap.set("n", "<Leader>nf", function() require('neogen').generate() end, {silent = true})
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    tag = "*",
  }
  use 'kana/vim-submode'
  use 'simeji/winresizer'

  use 'andymass/vim-matchup'
  use 'godlygeek/tabular'
  use 'rhysd/ghpr-blame.vim'
  use 'Shougo/vinarise.vim'

  use {'thinca/vim-qfreplace', ft = {'qf'}}
  use {'kevinhwang91/nvim-bqf', ft = {'qf'}}
  use 'rhysd/devdocs.vim'
  use 'osyo-manga/shabadou.vim'
  use 'mattn/httpstatus-vim'

  use 'AndrewRadev/switch.vim'

  use 'kana/vim-altr'

  use 'equalsraf/neovim-gui-shim'
  use 'brettanomyces/nvim-editcommand'
  use 'subnut/nvim-ghost.nvim'
  use {'kyazdani42/nvim-tree.lua', config = function()
    require'my-nvim-tree-setup'
  end}
  -- }}}
end)
