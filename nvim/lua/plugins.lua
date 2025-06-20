---@diagnostic disable: missing-parameter
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua;"

require("lazy").setup({
  "nvim-tree/nvim-web-devicons",

  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "NotifyBackground",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = "",
        },
        level = 3,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = false,
      })

      vim.notify = require "notify"
    end,
  },

  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("ssr").setup({
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        adjust_window = true,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      })
      vim.keymap.set({ "n", "x" }, "<leader>sr", function()
        require("ssr").open()
      end)
    end,
  },

  {
    'MagicDuck/grug-far.nvim',
    opts = {},
  },

  "vim-denops/denops.vim",
  -- { "delphinus/skkeleton_indicator.nvim", config = true },

  -- LSP {{{
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({})
    end,
  },

  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        symbol_map = {
          Text = "",
          Method = "ƒ",
          Function = "",
          Constructor = "",
          Variable = "",
          Class = "",
          Interface = "",
          Module = "",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "﬌",
          Color = "",
          File = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure()
    end,
  },

  "folke/neodev.nvim",

  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup({
        controls = {
          icons = {
            disconnect = "",
            play = "",
            pause = "",
            step_back = "",
            step_into = "",
            step_over = "",
            step_out = "",
            run_last = "",
            terminate = "",
          },
        },
        icons = { expanded = "", collapsed = "" },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "suketa/nvim-dap-ruby",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function() end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = "go",
    config = function()
      require("go").setup()
      vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.go" }, callback = require("go.format").gofmt })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  -- }}}

  -- {
  --   "tyru/eskk.vim",
  --   dependencies = { "tyru/skkdict.vim" },
  --   event = { "InsertEnter" },
  -- },
  {
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.fn["skkeleton#config"]({
        globalDictionaries = { "/usr/share/skk/SKK-JISYO.L" },
        userDictionary = "~/.skk-jisyo",
        eggLikeNewline = true,
        immediatelyCancel = false,
        registerConvertResult = true,
      })
      vim.cmd [[
        imap <C-j> <Plug>(skkeleton-toggle)
        cmap <C-j> <Plug>(skkeleton-toggle)
        tmap <C-j> <Plug>(skkeleton-toggle)
      ]]
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "skkeleton-enable-pre" },
        callback = function()
          require("cmp").setup.buffer({ enabled = false })
        end,
      })

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "skkeleton-disable-pre" },
        callback = function()
          require("cmp").setup.buffer({ enabled = true })
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    priority = 60,
    config = function()
      local wk = require "which-key"
      wk.setup({
        win = { border = "double", wo = { winblend = 20 } },
      })
    end,
  },

  {
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
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  -- filetype plugins {{{
  "moro/vim-review",
  "cespare/vim-toml",

  "vim-ruby/vim-ruby",
  "pocke/rbs.vim",
  "leafgarland/typescript-vim",
  "rust-lang/rust.vim",
  "elixir-editors/vim-elixir",
  "hashivim/vim-terraform",
  "tmux-plugins/vim-tmux",
  "moskytw/nginx-contrib-vim",
  "exu/pgsql.vim",
  -- }}}

  -- markdown {{{
  {
    "preservim/vim-markdown",
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  },
  { "mattn/vim-maketable", ft = "markdown" },
  { "kannokanno/previm", ft = "markdown" },
  { "euclio/vim-markdown-composer", build = "cargo build --release" },
  {
    "dhruvasagar/vim-table-mode",
    lazy = true,
    cmd = { "TableModeToggle", "TableModeEnable" },
    init = function()
      vim.g.table_mode_disable_mappings = 1
      vim.g.table_mode_map_prefix = "<Leader>m"
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/Dropbox/Obsidian_Vaults/work",
        },
      },
    },
  },
  -- }}}

  -- colorschemes plugin {{{
  "glepnir/zephyr-nvim",
  "projekt0n/github-nvim-theme",
  "shaunsingh/nord.nvim",
  { "EdenEast/nightfox.nvim", build = ":NightfoxCompile" },
  "folke/tokyonight.nvim",
  "olimorris/onedarkpro.nvim",
  -- }}}

  -- smartchr textobj {{{
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  "kana/vim-smartchr",
  "kana/vim-niceblock",
  -- }}}

  -- html template {{{
  "mattn/emmet-vim",
  "slim-template/vim-slim",
  "tpope/vim-haml",
  "nono/vim-handlebars",
  "juvenn/mustache.vim",
  -- }}}

  -- syntax, visibility {{{
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      "andymass/vim-matchup",
      "RRethy/nvim-treesitter-endwise",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require "configs/treesitter"
    end,
  },
  {
    "luckasRanarison/tree-sitter-hyprlang",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    keys = { "<leader>tp", "<leader>th" },
    config = function()
      vim.keymap.set("n", "<leader>tp", "<cmd>TSPlaygroundToggle<cr>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>th", "<cmd>TSHighlightCapturesUnderCursor<cr>", { silent = true, noremap = true })
      require("nvim-treesitter.configs").setup({
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        min_window_height = 25,
        separator = "-",
      })
    end,
  },

  {
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup({
        disable_virtual_lines_ft = { "yaml" },
      })
    end,
  },

  {
    "m-demare/hlargs.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("hlargs").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowGreen",
        "RainbowOrange",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    keys = { "n", "N", "*", "#", "g*", "g#" },
    lazy = true,
    config = function()
      local kopts = { noremap = true, silent = true }

      vim.keymap.set(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.keymap.set(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
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
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#41AFEF",
        },
      })
      require("scrollbar.handlers.search").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_close = true,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "configs/lualine"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require "configs/bufferline"
    end,
  },

  {
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
  },

  "osyo-manga/vim-over",
  -- }}}

  -- web browse, api {{{
  "tyru/open-browser.vim",
  { "tyru/open-browser-github.vim", dependencies = "tyru/open-browser.vim" },
  -- }}}

  -- git {{{
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Gclog",
    },
  },
  {
    "rhysd/ghpr-blame.vim",
    cmd = { "GHPRBlame" },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    keys = {
      { "<leader>g" },
    },
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    config = function() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ numhl = true })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    config = true,
  },

  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
  },

  { "lambdalisue/vim-gista", cmd = { "Gista" } },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
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
  },
  -- }}}

  -- search, finder {{{
  "rking/ag.vim",
  "thinca/vim-visualstar",

  {
    "smoka7/hop.nvim",
    config = function()
      require "configs/hop"
    end,
    keys = {
      "<leader><leader>f",
      "<leader><leader>F",
      "<leader><leader>w",
      "<leader><leader>W",
      "<leader><leader>t",
      "<leader><leader>T",
      "<leader><leader>/",
      "<leader><leader>?",
    },
  },
  "t9md/vim-choosewin",

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "AerialOpen", "AerialClose", "AerialToggle", "AerialNext", "AerialPrev" },
    config = function()
      require("aerial").setup({
        layout = {
          max_width = { 60, 0.2 },
        },
        filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
          "Property",
          "Variable",
          "Constant",
        },
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      "cljoly/telescope-repo.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "benfowler/telescope-luasnip.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "jvgrootveld/telescope-zoxide",
    },
    config = function()
      require "configs/telescope"
      local telescope = require "telescope"
      telescope.load_extension "project"
      telescope.load_extension "repo"
      telescope.load_extension "emoji"
      telescope.load_extension "luasnip"
      telescope.load_extension "file_browser"
      telescope.load_extension "ui-select"
      telescope.load_extension "zoxide"
    end,
    keys = {
      ",",
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    keys = { ",sfr" },
    config = function()
      require("telescope").load_extension "frecency"
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
    keys = { "," },
  },

  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { "<leader>S", "<leader>sw", "<leader>s", "<leader>sp" },
    config = function()
      vim.keymap.set("n", "<leader>S", function()
        require("spectre").toggle()
      end, { desc = "Toggle Spectre" })

      -- search current word
      vim.keymap.set("n", "<leader>sw", function()
        require("spectre").open_visual({ select_word = true })
      end, { desc = "Spectre (select word)" })
      vim.keymap.set("v", "<leader>s", function()
        require("spectre").open_visual()
      end, { desc = "Spectre" })
      -- search in current file
      vim.keymap.set("n", "<leader>sp", function()
        require("spectre").open_file_search()
      end, { desc = "Spectre (file search)" })

      require("spectre").setup({
        live_update = true,
      })
    end,
  },
  -- }}}

  -- completion, diagnostics {{{
  "dense-analysis/ale",

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.cmd [[
        " press <Tab> to expand or jump in a snippet. These can also be mapped separately
        " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
        imap <silent><expr> <C-L> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-L>'
        " -1 for jumping backwards.
        inoremap <silent> <C-S-L> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <C-L> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <C-S-L> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]]
    end,
    event = "InsertEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "rcarriga/cmp-dap",
      "nvim-lua/plenary.nvim", -- required by cmp-git
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      local cmp = require "cmp"
      local default_config = require "cmp.config.default"()
      cmp.setup({
        enabled = function()
          return default_config.enabled() or require("cmp_dap").is_dap_buffer()
        end,
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
          { name = "dap" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

      cmp.setup.filetype({'ssr'}, {
        completion = {
          autocomplete = false
        }
      })
      require("cmp_git").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  "github/copilot.vim",
  -- }}}

  -- terminal, execution {{{
  {
    "is0n/jaq-nvim",
    cmd = { "Jaq" },
    config = function()
      require("jaq-nvim").setup({
        cmds = {
          -- Uses vim commands
          internal = {
            lua = "luafile %",
            vim = "source %",
          },

          -- Uses shell commands
          external = {
            ruby = "ruby %",
            bundle_ruby = "bundle exec ruby %",
            rspec = "bundle exec rspec %",
            python = "python3 %",
            go = "go run %",
            sh = "sh %",
          },
        },
      })
    end,
  },

  "janko-m/vim-test",

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = "<F12>",
    cmd = { "ToggleTerm" },
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
  },

  {
    "samjwill/nvim-unception",
    init = function()
      -- Optional settings go here!
      vim.g.unception_open_buffer_in_new_tab = true
      vim.g.unception_block_while_host_edits = true
    end,
  },

  {
    "nikvdp/neomux",
    cmd = "Neomux",
    keys = "\\sh",
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    },
    config = function()
      local neotest = require "neotest"
      neotest.setup({
        adapters = {
          require "neotest-rspec"({
            rspec_cmd = function()
              local base_cmd = {
                "bundle",
                "exec",
                "rspec",
              }
              if vim.env.APP_CONTAINER_NAME == nil then
                return vim.tbl_flatten(base_cmd)
              else
                return vim.tbl_flatten({
                  "docker",
                  "compose",
                  "exec",
                  "-i",
                  vim.env.APP_CONTAINER_NAME,
                  "bundle",
                  "exec",
                  "rspec",
                })
              end
            end,
            transform_spec_path = function(path)
              local prefix = require("neotest-rspec").root(path)
              return string.sub(path, string.len(prefix) + 2, -1)
            end,

            results_path = "rspec.output",
          }),
        },
      })

      vim.keymap.set("n", ",tf", function()
        neotest.run.run(vim.fn.expand "%")
      end, { desc = "neotest run file" })
      vim.keymap.set("n", ",tn", function()
        neotest.run.run()
      end, { desc = "neotest run current line" })
      vim.keymap.set("n", ",tdf", function()
        neotest.run.run({ vim.fn.expand "%", strategy = "dap" })
        neotest.summary.open()
      end, { desc = "neotest run file with dap" })
      vim.keymap.set("n", ",tdn", function()
        neotest.run.run({ nil, strategy = "dap" })
        neotest.summary.open()
      end, { desc = "neotest run current line with dap" })
      vim.keymap.set("n", ",tc", function()
        neotest.run.stop()
      end, { desc = "neotest stop" })
      vim.keymap.set("n", ",ts", function()
        neotest.summary.toggle()
      end, { desc = "neotest summary" })
      vim.keymap.set("n", ",to", function()
        neotest.output.open({ enter = true })
      end, { desc = "neotest output" })
      vim.keymap.set("n", ",ta", function()
        neotest.run.attach()
      end, { desc = "neotest attach" })
    end,
  },
  -- }}}

  { "mattn/vim-sonots", cmd = "Sonots" },

  -- other utils {{{
  "gentoo/gentoo-syntax",

  "lambdalisue/suda.vim",

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*",
  },

  {
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end,
  },

  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  "kana/vim-submode",
  "simeji/winresizer",

  "andymass/vim-matchup",
  {
    "echasnovski/mini.align",
    config = true,
  },
  "godlygeek/tabular",
  "Shougo/vinarise.vim",

  { "gabrielpoca/replacer.nvim", ft = { "qf" } },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
  "rhysd/devdocs.vim",
  "mattn/httpstatus-vim",

  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group({
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.new({
            pattern = "%Y/%m/%d",
            default_kind = "day",
          }),
          augend.date.new({
            pattern = "%Y-%m-%d",
            default_kind = "day",
          }),
          augend.date.new({
            pattern = "%m/%d",
            default_kind = "day",
            only_valid = true,
          }),
          augend.date.new({
            pattern = "%H:%M",
            default_kind = "min",
            only_valid = true,
          }),
          augend.date.alias["%Y年%-m月%-d日(%ja)"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  },

  {
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
              { target = "/spec/lib/%1_spec.rb", context = "spec" },
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
            pattern = "/spec/lib/(.*)_spec.rb",
            target = {
              { target = "/lib/%1.rb", context = "lib" },
              { target = "/sig/%1.rbs", context = "sig" },
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
    end,
  },

  "equalsraf/neovim-gui-shim",
  -- "subnut/nvim-ghost.nvim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_gitignored = false,
            always_show = {
              ".gitignore",
              ".envrc",
            },
          },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          window = {
            mappings = {
              ["."] = "toggle_hidden",
            },
          },
        },
        window = {
          mappings = {
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          },
        },
      })
    end,
  },
  -- {
  --   "3rd/image.nvim",
  --   build = "luarocks --local install magick",
  --   config = function()
  --     if not vim.g.neovide and not vim.g.GuiLoaded then
  --       require("image").setup({
  --         backend = "ueberzug",
  --         integrations = {
  --           markdown = {
  --             enabled = true,
  --             clear_in_insert_mode = true,
  --             download_remote_images = true,
  --             only_render_image_at_cursor = true,
  --             filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
  --           },
  --           neorg = {
  --             enabled = true,
  --             clear_in_insert_mode = false,
  --             download_remote_images = true,
  --             only_render_image_at_cursor = false,
  --             filetypes = { "norg" },
  --           },
  --         },
  --         max_width = 480,
  --         max_height = 160,
  --         max_width_window_percentage = nil,
  --         max_height_window_percentage = nil,
  --         window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --         window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --         editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --         tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --         hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  --       })
  --     end
  --   end,
  -- },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "axieax/urlview.nvim",
    cmd = { "UrlView" },
    keys = { ",uv", ",up" },
    config = function()
      require("urlview").setup()
      local wk = require "which-key"
      wk.register({
        [",u"] = {
          name = "+UrlView",
        },
      })
      vim.keymap.set("n", ",uv", "<cmd>UrlView<CR>", { silent = true })
      vim.keymap.set("n", ",up", "<cmd>UrlView lazy<CR>", { silent = true })
    end,
  },
  "antoinemadec/FixCursorHold.nvim",
})
