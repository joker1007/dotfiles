local wk = require "which-key"

vim.api.nvim_create_user_command(
  'TelescopeWithBufferDir',
  function(opts)
    local dir = vim.fn.fnamemodify(vim.fn.expand("%:p:h") .. "/" .. opts.args, ":p")
    local cwd = (vim.fn.fnamemodify(dir, ":p"))
    require("telescope.builtin").find_files({cwd = cwd, prompt_prefix = cwd .. "   "})
  end,
  { nargs = 1 }
)

local telescope_mappings = {
  name = "+Telescope",
  f = {
    name = "+Telescope (file+pwd)",
    f = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find File",
    },
    i = {
      function()
        require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true })
      end,
      "Find File",
    },
    o = {
      function()
        require("telescope.builtin").oldfiles()
      end,
      "Find File",
    },
    r = {
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      "Frecency",
    },
    b = {
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
      "File Browser",
    },
    d = {":TelescopeWithBufferDir ", "File Browser (change dir)"},
  },
  F = {
    name = "+Telescope (file+filepath)",
    F = {
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.expand "%:p:h" })
      end,
      "Find File (filepath)",
    },
    I = {
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.expand "%:p:h",
          no_ignore = true,
          no_ignore_parent = true,
        })
      end,
      "Find File (filepath)",
    },
    B = {
      function()
        require("telescope").extensions.file_browser.file_browser({ path = vim.fn.expand "%:p:h" })
      end,
      "File Browser (filepath)",
    },
  },
  g = {
    function()
      require("telescope.builtin").live_grep()
    end,
    "Grep",
  },
  G = {
    function()
      require("telescope.builtin").live_grep()
    end,
    "Grep (filepath)",
  },
  b = {
    function()
      require("telescope.builtin").buffers()
    end,
    "Buffers",
  },
  h = {
    function()
      require("telescope.builtin").help_tags()
    end,
    "Help",
  },
  l = {
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    "Line Finder",
  },
  c = {
    name = "+gitcommit",
    c = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "Commits",
    },
    b = {
      function()
        require("telescope.builtin").git_bcommits()
      end,
      "Buffer Commits",
    },
  },
  t = {
    function()
      require("telescope.builtin").treesitter()
    end,
    "Treesitter",
  },
  r = {
    function()
      require("telescope").extensions.repo.list()
    end,
    "Repos",
  },
  e = {
    function()
      require("telescope").extensions.emoji.emoji()
    end,
    "Emoji",
  },
  p = {
    function()
      require("telescope").extensions.luasnip.luasnip()
    end,
    "Luasnip",
  },
  s = {
    function()
      require("telescope.builtin").resume()
    end,
    "Resume",
  },
}

wk.register({
  ["<leader>f"] = telescope_mappings,
  [",s"] = telescope_mappings,
})

-- vim.keymap.set('n', ',sff', function() require('telescope.builtin').find_files() end)
-- vim.keymap.set('n', ',sfb', function() require('telescope').extensions.file_browser.file_browser() end)
-- vim.keymap.set('n', ',sFF', function() require('telescope.builtin').find_files({cwd = vim.fn.expand("%:p:h")}) end)
-- vim.keymap.set('n', ',sFB', function() require('telescope').extensions.file_browser.file_browser({path = vim.fn.expand("%:p:h")}) end)
-- vim.keymap.set('n', ',sfr', function() require('telescope.builtin').oldfiles() end)
-- vim.keymap.set('n', ',sg', function() require('telescope.builtin').live_grep() end)
-- vim.keymap.set('n', ',sG', function() require('telescope.builtin').live_grep({cwd = vim.fn.expand("%:p:h")}) end)
-- vim.keymap.set('n', ',sb', function() require('telescope.builtin').buffers() end)
-- vim.keymap.set('n', ',sh', function() require('telescope.builtin').help_tags() end)
-- vim.keymap.set('n', ',sl', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
-- vim.keymap.set('n', ',scc', function() require('telescope.builtin').git_commits() end)
-- vim.keymap.set('n', ',scb', function() require('telescope.builtin').git_bcommits() end)
-- vim.keymap.set('n', ',st', function() require('telescope.builtin').treesitter() end)
-- vim.keymap.set('n', ',sr', function() require'telescope'.extensions.repo.list() end)
-- vim.keymap.set('n', ',se', function() require'telescope'.extensions.emoji.emoji() end)
-- vim.keymap.set('n', ',ss', function() require'telescope'.extensions.luasnip.luasnip() end)

vim.keymap.set("n", "<C-p>", function()
  require("telescope").extensions.project.project()
end, { silent = true })
vim.keymap.set("c", "<C-T>", function()
  require("telescope.builtin").commands()
end)
vim.keymap.set("c", "<C-H>", function()
  require("telescope.builtin").command_history()
end)
vim.keymap.set("i", "<C-E>", function()
  require("telescope").extensions.luasnip.luasnip()
end, { silent = true })

require("telescope").setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
      },
    },
    prompt_prefix = "   ",
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    winblend = 10,
    layout_config = {
      horizontal = {
        prompt_position = "top",
        width = 0.87,
      },
      vertical = {
        prompt_position = "top",
        preview_cutoff = 1,
        mirror = true,
      },
      width = 0.87,
      height = 0.80,
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker

    buffers = {
      theme = "dropdown",
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["d"] = "delete_buffer",
        },
      },
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    emoji = {
      action = function(emoji)
        vim.fn.setreg("+", emoji.value)
        print([[Press p or "+p to paste this emoji]] .. emoji.value)
      end,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
})
