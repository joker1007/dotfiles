vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    width = 36,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = false,
    },
  },
})

local wk = require "which-key"
wk.register({
  ["<leader>t"] = { name = "+NvimTree" },
})
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>")
