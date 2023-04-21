vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local on_attach = function(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
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
