require("nvim-treesitter").install({
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "embedded_template",
  "haskell",
  "html",
  "java",
  "javascript",
  "json",
  "git_config",
  "gitcommit",
  "go",
  "graphql",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "perl",
  "php",
  "proto",
  "query",
  "regex",
  "rst",
  "ruby",
  "rust",
  "scala",
  "sql",
  "tsx",
  "toml",
  "typescript",
  "vim",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    pcall(vim.treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- treesitter-textobjects keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "af", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)
vim.keymap.set({ "x", "o" }, "ab", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ib", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
end)

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "TSUpdate",
--   callback = function()
--     require("nvim-treesitter.parsers").rbs.install_info.revision = "5282e2f36d4109f5315c1d9486b5b0c2044622bb"
--   end,
-- })
