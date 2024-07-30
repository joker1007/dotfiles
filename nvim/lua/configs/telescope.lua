local wk = require "which-key"

vim.api.nvim_create_user_command("TelescopeWithBufferDir", function(opts)
  local dir = vim.fn.fnamemodify(vim.fn.expand "%:p:h" .. "/" .. opts.args, ":p")
  local cwd = (vim.fn.fnamemodify(dir, ":p"))
  require("telescope.builtin").find_files({ cwd = cwd, prompt_prefix = cwd .. "   " })
end, { nargs = 1 })

require("telescope").load_extension "gh_notifications"
require("telescope").load_extension "gh_collaborators"

local telescope_mappings = {
  { ",s", group = "Telescope" },
  {",sf", group = "Telescope (file+pwd)"},
  {
    ",sff",
    function()
      require("telescope.builtin").find_files({ follow = true })
    end,
    desc = "Find File",
  },
  {
    ",sfi",
    function()
      require("telescope.builtin").find_files({ follow = true, no_ignore = true, no_ignore_parent = true })
    end,
    desc = "Find File",
  },

  {
    ",sfo",
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Find File",
  },
  {
    ",sfr",
    function()
      require("telescope").extensions.frecency.frecency()
    end,
    desc = "Frecency",
  },
  {
    ",sfb",
    function()
      require("telescope").extensions.file_browser.file_browser({
        depth = 5,
        collapse_dirs = true,
        respect_gitignore = false,
        follow_symlinks = true,
      })
    end,
    desc = "File Browser",
  },
  { ",sfd", proxy = ":TelescopeWithBufferDir ", desc = "File Browser (change dir)" },

  {",sF", group = "Telescope (file+filepath)"},
  {
    ",sFF",
    function()
      require("telescope.builtin").find_files({ cwd = vim.fn.expand "%:p:h", follow = true })
    end,
    desc = "Find File (filepath)",
  },
  {
    ",sFI",
    function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.expand "%:p:h",
        follow = true,
        no_ignore = true,
        no_ignore_parent = true,
      })
    end,
    desc = "Find File (filepath)",
  },
  {
    ",sFB",
    function()
      require("telescope").extensions.file_browser.file_browser({
        path = vim.fn.expand "%:p:h",
        depth = 5,
        collapse_dirs = true,
        respect_gitignore = false,
        follow_symlinks = true,
      })
    end,
    desc = "File Browser (filepath)",
  },

  {
    ",sg",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Grep",
  },
  {
    ",sG",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Grep (filepath)",
  },
  {
    ",sb",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffers",
  },
  {
    ",sh",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Help",
  },
  {
    ",sl",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    desc = "Line Finder",
  },
  { ",c", group = "gitcommit"},
  {
    ",scc",
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Commits",
  },
  {
    ",scb",
    function()
      require("telescope.builtin").git_bcommits()
    end,
    desc = "Buffer Commits",
  },
  {
    ",st",
    function()
      require("telescope.builtin").treesitter()
    end,
    desc = "Treesitter",
  },
  {
    ",sr",
    function()
      require("telescope").extensions.repo.list()
    end,
    desc = "Repos",
  },
  {
    ",se",
    function()
      require("telescope").extensions.emoji.emoji()
    end,
    desc = "Emoji",
  },
  {
    ",sp",
    function()
      require("telescope").extensions.luasnip.luasnip()
    end,
    desc = "Luasnip",
  },
  {
    ",ss",
    function()
      require("telescope.builtin").resume()
    end,
    desc = "Resume",
  },
  {
    ",sn",
    function()
      require("telescope").extensions.gh_notifications.gh_notifications()
    end,
    desc = "GH Notifications",
  },
  {
    ",sm",
    function()
      local buf = vim.api.nvim_get_current_buf()
      local bufname = vim.api.nvim_buf_get_name(buf)
      local result = vim.fn.matchlist(bufname, "octo://\\(.\\{-}\\)/\\(.\\{-}\\)/")
      local owner = result[2]
      local repo = result[3]
      if owner ~= "" and repo ~= "" then
        require("telescope").extensions.gh_collaborators.gh_collaborators({ owner = owner, repo = repo })
      else
        require("telescope").extensions.gh_collaborators.gh_collaborators()
      end
    end,
    desc = "GH Org Members",
  },
  {
    ",sz",
    function()
      require("telescope").extensions.zoxide.list()
    end,
    desc = "Zoxide",
  },
}

wk.add(telescope_mappings)

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
    file_browser = {
      prompt_path = true,
    },
  },
})
