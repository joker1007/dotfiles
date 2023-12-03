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

      vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
      end)
      vim.keymap.set("n", "<F9>", function()
        require("dap").step_over()
      end)
      vim.keymap.set("n", "<F10>", function()
        require("dap").step_into()
      end)
      vim.keymap.set("n", "<F11>", function()
        require("dap").step_out()
      end)
      vim.keymap.set("n", "<Leader>b", function()
        require("dap").toggle_breakpoint()
      end)
      vim.keymap.set("n", "<Leader>B", function()
        require("dap").set_breakpoint(vim.fn.input "condition: ")
      end)

      local wk = require "which-key"
      wk.register({
        ["<leader>d"] = {
          name = "+Debug",
        },
      })
      vim.keymap.set("n", "<Leader>ds", function()
        require("dap").continue()
      end, { desc = "start debugger or continue" })
      vim.keymap.set("n", "<Leader>du", function()
        require("dapui").toggle()
      end, { desc = "toggle UI" })
      vim.keymap.set("n", "<Leader>dr", function()
        require("dap").repl.open()
      end, { desc = "open repl" })
      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end, { desc = "re-run last debug adapter" })
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

  {
    "tyru/eskk.vim",
    dependencies = { "tyru/skkdict.vim" },
    event = { "InsertEnter" },
  },

  {
    "folke/which-key.nvim",
    priority = 60,
    config = function()
      local wk = require "which-key"
      wk.setup({
        window = { border = "double", winblend = 20 },
      })
      wk.register({
        [",g"] = {
          name = "+git",
        },
      })
      wk.register({
        [",o"] = {
          name = "+Octo",
          p = {
            name = "+PullRequest",
          },
          i = {
            name = "+Issue",
          },
        },
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
  "luckasRanarison/tree-sitter-hypr",
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
    init = function()
      vim.keymap.set("n", ",gs", "<cmd>Git<CR>")
      vim.keymap.set("n", ",ga", "<cmd>Gwrite<CR>")
      vim.keymap.set("n", ",gc", "<cmd>Git commit<CR>")
      vim.keymap.set("n", ",gC", "<cmd>Git commit --amend<CR>")
      vim.keymap.set("n", ",gb", "<cmd>Git blame<CR>")
      vim.keymap.set("n", ",gn", "<cmd>Git now<CR>")
      vim.keymap.set("n", ",gN", "<cmd>Git now --all<CR>")
    end,
    config = function()
      vim.cmd [[autocmd vimrc BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif]]
      vim.cmd [[autocmd vimrc BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif]]
      vim.cmd [[autocmd vimrc BufEnter * if expand("%:t") =~ "PULLREQ_EDITMSG" | set ft=gitcommit | endif]]
    end,
  },
  {
    "rhysd/ghpr-blame.vim",
    config = function()
      vim.keymap.set("n", ",gp", ":<C-u>GHPRBlame<CR>")
    end,
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    keys = { ",gl" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    config = function()
      vim.keymap.set("n", ",gl", "<cmd>Flog<CR>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ numhl = true })
    end,
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    init = function()
      vim.keymap.set("n", ",opl", "<cmd>Octo pr list<cr>", { desc = "List PullRequests" })
      vim.keymap.set("n", ",opr", "<cmd>Octo search is:pr review-requested:@me is:open<cr>", {
        desc = "Search PullRequests (review-requested)",
      })
      vim.keymap.set("n", ",opa", "<cmd>Octo search is:pr author:@me is:open<cr>", {
        desc = "Search PullRequests (created)",
      })
      vim.keymap.set("n", ",opc", "<cmd>Octo pr create<cr>", { desc = "Create PullRequest" })
      vim.keymap.set("n", ",oil", "<cmd>Octo issue list<cr>", { desc = "Issue (list)" })
      vim.keymap.set("n", ",oia", "<cmd>Octo search is:issue author:@me is:open<cr>", { desc = "Issue (created)" })
      vim.keymap.set("n", ",os", "<cmd>Octo review start<cr>", { desc = "Start Review" })
      vim.keymap.set("n", ",ou", "<cmd>Octo review submit<cr>", { desc = "Submit Review" })
      vim.keymap.set("n", ",or", "<cmd>Octo review resume<cr>", { desc = "Resume Review" })
      vim.keymap.set("n", ",oc", "<cmd>Octo review comments<cr>", { desc = "View Pending comments" })
      vim.keymap.set("n", ",od", "<cmd>Octo review discard<cr>", { desc = "Discard Pending review" })
      vim.keymap.set("n", ",oo", ":Octo", { desc = "Octo" })
    end,
    config = function()
      require("octo").setup()
    end,
  },

  { "lambdalisue/vim-gista", cmd = { "Gista" } },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    init = function()
      vim.keymap.set("n", ",gd", "<cmd>DiffviewOpen<CR>")
      vim.keymap.set("n", ",gh", "<cmd>DiffviewFileHistory %<CR>")
    end,
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
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require "configs/hop"
    end,
  },
  "t9md/vim-choosewin",

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "AerialOpen", "AerialClose", "AerialToggle", "AerialNext", "AerialPrev" },
    init = function()
      vim.keymap.set("n", "<leader>v", "<cmd>AerialToggle!<CR>")
      vim.keymap.set("n", "<space>o", "<cmd>AerialToggle!<CR>")
    end,
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
    branch = "0.1.x",
    dependencies = {
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
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    keys = { ",sfr" },
    config = function()
      require("telescope").load_extension "frecency"
    end,
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
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
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]]
    end,
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
  -- use {'Shougo/vimproc', run = 'make'}
  "thinca/vim-quickrun",
  "lambdalisue/vim-quickrun-neovim-job",

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

  { "nikvdp/neomux", cmd = "Neomux", keys = "\\sh" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    },
    keys = { ",tf", ",tn", ",tdf", ",tdn", ",tc", ",ts", ",to", ",ta" },
    lazy = true,
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
      end, { desc = "neotest run file" })
      vim.keymap.set("n", ",tn", function()
        require("neotest").run.run()
      end, { desc = "neotest run current line" })
      vim.keymap.set("n", ",tdf", function()
        require("neotest").run.run({ vim.fn.expand "%", strategy = "dap" })
      end, { desc = "neotest run file with dap" })
      vim.keymap.set("n", ",tdn", function()
        require("neotest").run.run({ nil, strategy = "dap" })
      end, { desc = "neotest run current line with dap" })
      vim.keymap.set("n", ",tc", function()
        require("neotest").run.stop()
      end, { desc = "neotest stop" })
      vim.keymap.set("n", ",ts", function()
        require("neotest").summary.toggle()
      end, { desc = "neotest summary" })
      vim.keymap.set("n", ",to", function()
        require("neotest").output.open({ enter = true })
      end, { desc = "neotest output" })
      vim.keymap.set("n", ",ta", function()
        require("neotest").run.attach()
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
    init = function()
      vim.keymap.set("n", ",bd", "<cmd>Bdelete<cr>")
      vim.keymap.set("n", "<A-w>", "<cmd>Bdelete<cr>")
      vim.keymap.set("n", ",bD", "<cmd>Bdelete!<cr>")
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end,
  },

  "kana/vim-submode",
  "simeji/winresizer",

  "andymass/vim-matchup",
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
  },

  "equalsraf/neovim-gui-shim",
  -- "subnut/nvim-ghost.nvim",
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cmd = { "Neotree" },
    keys = { "<leader>tt" },
    config = function()
      vim.keymap.set("n", "<leader>tt", "<cmd>Neotree toggle filesystem reveal<cr>")
      require("neo-tree").setup({
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
  --     if not vim.g.neovide then
  --       require("image").setup({
  --         backend = "ueberzug",
  --         integrations = {
  --           markdown = {
  --             enabled = true,
  --             clear_in_insert_mode = false,
  --             download_remote_images = true,
  --             only_render_image_at_cursor = false,
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
  --         max_width = nil,
  --         max_height = nil,
  --         max_width_window_percentage = nil,
  --         max_height_window_percentage = 50,
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
