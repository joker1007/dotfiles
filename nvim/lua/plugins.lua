---@diagnostic disable: missing-parameter
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local packer = require "packer"

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local sfile = debug.getinfo(1, "S").short_src

vim.api.nvim_create_user_command("PackerReload", function()
  vim.cmd("luafile " .. sfile)
end, {})

vim.api.nvim_create_user_command("PackerReloadI", function()
  vim.cmd("luafile " .. sfile)
  packer.install()
end, {})

vim.api.nvim_create_user_command("PackerReloadS", function()
  vim.cmd("luafile " .. sfile)
  packer.sync()
end, {})

vim.api.nvim_create_user_command("PackerReloadC", function()
  vim.cmd("luafile " .. sfile)
  packer.compile()
end, {})

return packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "kyazdani42/nvim-web-devicons"
  use({ "ray-x/guihua.lua", run = "cd lua/fzy && make" })
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  })

  -- LSP {{{
  use "neovim/nvim-lspconfig"
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    requires = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require "lspsaga"

      saga.init_lsp_saga()
    end,
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  })

  use({
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure()
    end,
  })

  use "folke/lua-dev.nvim"

  use "mfussenegger/nvim-dap"
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  use({
    "theHamsta/nvim-dap-virtual-text",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  })
  use({
    "ray-x/go.nvim",
    requires = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
      vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.go" }, callback = require("go.format").gofmt })
    end,
  })
  use({
    "mfussenegger/nvim-jdtls",
  })
  -- }}}

  use({ "tyru/eskk.vim", event = { "InsertEnter" } })
  use "tyru/skkdict.vim"

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        window = { border = "double", winblend = 20 },
      })
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "\\cc",
          block = "\\cb",
        },
        opleader = {
          line = "\\cc",
          block = "\\cb",
        },
        ignore = "^$",
      })
    end,
  })

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  })

  -- filetype plugins {{{
  use "moro/vim-review"
  use "cespare/vim-toml"
  use "jlcrochet/vim-rbs"

  use "vim-ruby/vim-ruby"
  use "leafgarland/typescript-vim"
  use "rust-lang/rust.vim"
  use "elixir-editors/vim-elixir"
  use "hashivim/vim-terraform"
  use "tmux-plugins/vim-tmux"
  use "moskytw/nginx-contrib-vim"
  use "exu/pgsql.vim"
  -- }}}

  -- markdown {{{
  use({ "mattn/vim-maketable", ft = "markdown" })
  use({ "kannokanno/previm", ft = "markdown" })
  use({ "euclio/vim-markdown-composer", run = "cargo build --release" })
  use({
    "dhruvasagar/vim-table-mode",
    setup = function()
      vim.g.table_mode_disable_mappings = 1
    end,
  })
  -- }}}

  -- colorschemes plugin {{{
  use "glepnir/zephyr-nvim"
  use "projekt0n/github-nvim-theme"
  use "shaunsingh/nord.nvim"
  use({ "EdenEast/nightfox.nvim", run = ":NightfoxCompile" })
  use "folke/tokyonight.nvim"
  use "olimorris/onedarkpro.nvim"
  -- }}}

  -- smartchr textobj {{{
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })
  use "kana/vim-smartchr"
  use "kana/vim-niceblock"
  -- }}}

  -- html template {{{
  use "mattn/emmet-vim"
  use "slim-template/vim-slim"
  use "tpope/vim-haml"
  use "nono/vim-handlebars"
  use "juvenn/mustache.vim"
  -- }}}

  -- syntax, visibility {{{
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "p00f/nvim-ts-rainbow",
      "andymass/vim-matchup",
      "RRethy/nvim-treesitter-endwise",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    run = ":TSUpdate",
    config = function()
      require "configs/treesitter"
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({})
    end,
  })

  use({
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup()
    end,
  })

  -- watch https://github.com/m-demare/hlargs.nvim/issues/43
  -- use({
  --   "m-demare/hlargs.nvim",
  --   requires = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --   end,
  -- })

  use({
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      vim.cmd [[hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
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
    end,
  })

  use({
    "kevinhwang91/nvim-hlslens",
    config = function()
      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      require("hlslens").setup({
        build_position_cb = function(plist, _, _, _)
          require("scrollbar.handlers.search").handler.show(plist.start_pos)
        end,
      })
      vim.cmd [[
      augroup scrollbar_search_hide
      autocmd!
      autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
      augroup END
    ]]
    end,
  })

  use({
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#41AFEF",
        },
      })
      require("scrollbar.handlers.search").setup()
    end,
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_close = true,
      })

      local wk = require "which-key"
      wk.register({
        ["<leader>x"] = {
          name = "+Trouble",
        },
      })
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require "configs/lualine"
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "configs/bufferline"
    end,
  })

  use({
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue oe blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background, virtualtext
        mode = "background", -- Set the display mode.
      })
    end,
  })

  use "octol/vim-cpp-enhanced-highlight"

  use "osyo-manga/vim-over"
  -- }}}

  -- web browse, api {{{
  use "tyru/open-browser.vim"
  use "tyru/open-browser-github.vim"
  use "mattn/webapi-vim"
  -- }}}

  -- tweetvim {{{
  use "basyura/bitly.vim"
  use "basyura/twibill.vim"
  use "basyura/TweetVim"
  -- }}}

  -- git {{{
  use "tpope/vim-fugitive"
  use "rbong/vim-flog"
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ numhl = true })
    end,
  })
  use "rhysd/committia.vim"

  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  })

  use({ "lambdalisue/vim-gista", cmd = { "Gista" } })
  use({
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup({
        default_args = {
          DiffviewOpen = { "--untracked-files=no" },
        },
        keymaps = {
          view = {
            ["gq"] = require("diffview.config").actions.close,
          },
          panel = {
            ["gq"] = require("diffview.config").actions.close,
          },
        },
      })
    end,
  })
  -- }}}

  -- search, finder {{{
  use "rking/ag.vim"
  use "thinca/vim-visualstar"

  use({
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      local hop = require "hop"
      local hint = require "hop.hint"
      local wk = require "which-key"

      wk.register({
        ["<leader><leader>"] = {
          f = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
            end,
            "Hint char (forward)",
          },
          F = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
            end,
            "Hint char (backward)",
          },
          t = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end,
            "Hint char (forward)",
          },
          T = {
            function()
              hop.hint_char1({
                direction = hint.HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = -1,
              })
            end,
            "Hint char (backward)",
          },
          w = {
            function()
              hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
            end,
            "Hint words (forward)",
          },
          W = {
            function()
              hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
            end,
            "Hint words (backward)",
          },
          ["/"] = {
            function()
              hop.hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR })
            end,
            "Hint patterns (forward)",
          },
          ["?"] = {
            function()
              hop.hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR })
            end,
            "Hint patterns (forward)",
          },
        },
      })
      wk.register({
        ["<leader><leader>"] = {
          f = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
            end,
            "Hint char (forward)",
          },
          F = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
            end,
            "Hint char (backward)",
          },
          t = {
            function()
              hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end,
            "Hint char (forward)",
          },
          T = {
            function()
              hop.hint_char1({
                direction = hint.HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = -1,
              })
            end,
            "Hint char (backward)",
          },
          w = {
            function()
              hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
            end,
            "Hint words (forward)",
          },
          W = {
            function()
              hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
            end,
            "Hint words (backward)",
          },
          ["/"] = {
            function()
              hop.hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR })
            end,
            "Hint patterns (forward)",
          },
          ["?"] = {
            function()
              hop.hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR })
            end,
            "Hint patterns (forward)",
          },
        },
      }, { mode = "v" })
      hop.setup({})
    end,
  })
  use "t9md/vim-choosewin"

  use "liuchengxu/vista.vim"

  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      "cljoly/telescope-repo.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "benfowler/telescope-luasnip.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require "configs/telescope"
      require("telescope").load_extension "project"
      require("telescope").load_extension "repo"
      require("telescope").load_extension "emoji"
      require("telescope").load_extension "luasnip"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "ui-select"
    end,
  })
  use({
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
    requires = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  })

  use({
    "windwp/nvim-spectre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>S", function()
        require("spectre").open()
      end)

      -- search current word
      vim.keymap.set("n", "<leader>sw", function()
        require("spectre").open_visual({ select_word = true })
      end)
      vim.keymap.set("v", "<leader>s", function()
        require("spectre").open_visual()
      end)
      -- search in current file
      vim.keymap.set("n", "<leader>sp", function()
        require("spectre").open_file_search()
      end)

      require("spectre").setup({
        live_update = true,
      })
    end,
  })
  -- }}}

  -- completion, diagnostics {{{
  use "dense-analysis/ale"

  use({
    "L3MON4D3/LuaSnip",
    requires = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.cmd [[
        " press <Tab> to expand or jump in a snippet. These can also be mapped separately
        " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]]
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "nvim-lua/plenary.nvim", -- required by cmp-git
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          {
            name = "buffer",
            option = {
              keyword_length = 5,
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "git" },
          { name = "emoji" },
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "buffer",
            option = {
              keyword_length = 5,
            },
          },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
      require("cmp_git").setup()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  })
  -- }}}

  -- terminal, execution {{{
  -- use {'Shougo/vimproc', run = 'make'}
  -- use 'thinca/vim-quickrun'

  use "janko-m/vim-test"

  use({
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 30
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = "<F12>",
      })
    end,
  })

  use({ "nikvdp/neomux", cmd = "Neomux", keys = "\\sh" })

  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require "neotest-rspec"({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end,
          }),
        },
      })

      vim.keymap.set("n", ",tf", function()
        require("neotest").run.run(vim.fn.expand "%")
      end, {})
      vim.keymap.set("n", ",tn", function()
        require("neotest").run.run()
      end, {})
      vim.keymap.set("n", ",tdf", function()
        require("neotest").run.run({ vim.fn.expand "%", strategy = "dap" })
      end, {})
      vim.keymap.set("n", ",tdn", function()
        require("neotest").run.run({ nil, strategy = "dap" })
      end, {})
      vim.keymap.set("n", ",tc", function()
        require("neotest").run.stop()
      end, {})
      vim.keymap.set("n", ",ts", function()
        require("neotest").summary.toggle()
      end, {})
      vim.keymap.set("n", ",to", function()
        require("neotest").output.open({ enter = true })
      end, {})
      vim.keymap.set("n", ",ta", function()
        require("neotest").run.attach()
      end, {})
    end,
  })
  -- }}}

  use({ "mattn/vim-sonots", cmd = "Sonots" })

  -- other utils {{{
  use({
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
      local wk = require "which-key"
      wk.register({
        ["<leader>g"] = {
          name = "+Neogen",
          f = {
            function()
              require("neogen").generate()
            end,
            "Neogen",
            silent = true,
          },
        },
      })
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    tag = "*",
  })

  use({
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end,
  })

  use({
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bdelete!", "Bwipeout", "Bwipeout!" },
    setup = function()
      vim.keymap.set("n", ",bd", "<cmd>Bdelete<cr>")
      vim.keymap.set("n", "<A-w>", "<cmd>Bdelete<cr>")
      vim.keymap.set("n", ",bD", "<cmd>Bdelete!<cr>")
    end,
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  use({
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end,
  })

  use "kana/vim-submode"
  use "simeji/winresizer"

  use "andymass/vim-matchup"
  use "godlygeek/tabular"
  use "rhysd/ghpr-blame.vim"
  use "Shougo/vinarise.vim"

  use({ "thinca/vim-qfreplace", ft = { "qf" } })
  use({ "kevinhwang91/nvim-bqf", ft = { "qf" } })
  use "rhysd/devdocs.vim"
  use "mattn/httpstatus-vim"

  use "AndrewRadev/switch.vim"

  use({
    "rgroli/other.nvim",
    config = function()
      local rails_controller_patterns = {
        { target = "/spec/controllers/%1_spec.rb", context = "spec" },
        { target = "/spec/requests/%1_spec.rb", context = "spec" },
        { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
        { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
        { target = "/app/views/%1/**/*.html.*", context = "view" },
      }
      require("other-nvim").setup({
        mappings = {
          {
            pattern = "/app/models/(.*).rb",
            target = {
              { target = "/spec/models/%1_spec.rb", context = "spec" },
              { target = "/spec/factories/%1.rb", context = "factories", transformer = "pluralize" },
              { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
              { target = "/app/views/%1/**/*.html.*", context = "view", transformer = "pluralize" },
            },
          },
          {
            pattern = "/spec/models/(.*)_spec.rb",
            target = {
              { target = "/app/models/%1.rb", context = "models" },
            },
          },
          {
            pattern = "/spec/factories/(.*).rb",
            target = {
              { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
              { target = "/spec/models/%1_spec.rb", context = "spec", transformer = "singularize" },
            },
          },
          {
            pattern = "/app/services/(.*).rb",
            target = {
              { target = "/spec/services/%1_spec.rb", context = "spec" },
            },
          },
          {
            pattern = "/spec/services/(.*)_spec.rb",
            target = {
              { target = "/app/services/%1.rb", context = "services" },
            },
          },
          {
            pattern = "/app/controllers/.*/(.*)_controller.rb",
            target = rails_controller_patterns,
          },
          {
            pattern = "/app/controllers/(.*)_controller.rb",
            target = rails_controller_patterns,
          },
          {
            pattern = "/app/views/(.*)/.*.html.*",
            target = {
              { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
              { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
              { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
            },
          },
          {
            pattern = "/lib/(.*).rb",
            target = {
              { target = "/spec/%1_spec.rb", context = "spec" },
              { target = "/sig/%1.rbs", context = "sig" },
            },
          },
          {
            pattern = "/sig/(.*).rbs",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/%1.rb" },
            },
          },
          {
            pattern = "/spec/(.*)_spec.rb",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/sig/%1.rbs", context = "sig" },
            },
          },
        },
      })

      local wk = require "which-key"
      wk.register({
        ["<leader>o"] = {
          name = "+Other",
        },
      })
      vim.keymap.set("n", "<F2>", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<F3>", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<leader>oo", "<cmd>OtherClear<CR><cmd>:Other<CR>")
      vim.keymap.set("n", "<leader>os", "<cmd>OtherClear<CR><cmd>:OtherSplit<CR>")
      vim.keymap.set("n", "<leader>ov", "<cmd>OtherClear<CR><cmd>:OtherVSplit<CR>")
      vim.keymap.set("n", "<leader>oc", "<cmd>OtherClear<CR><cmd>:OtherClear<CR>")
    end,
  })

  use "equalsraf/neovim-gui-shim"
  use "brettanomyces/nvim-editcommand"
  use "subnut/nvim-ghost.nvim"
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "configs/nvim-tree"
    end,
  })
  use({
    "axieax/urlview.nvim",
    config = function()
      require("urlview").setup()
      local wk = require "which-key"
      wk.register({
        [",u"] = {
          name = "+UrlView",
        },
      })
      vim.keymap.set("n", ",uv", "<cmd>UrlView<CR>", { silent = true })
      vim.keymap.set("n", ",up", "<cmd>UrlView packer<CR>", { silent = true })
    end,
  })
  use "antoinemadec/FixCursorHold.nvim"
  -- }}}
end)
