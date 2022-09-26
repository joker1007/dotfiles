require("bufferline").setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    separator_style = "thick",
    custom_filter = function(buf, buf_nums)
      return vim.bo[buf].filetype ~= "qf"
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

vim.keymap.set("n", "<leader>1", function()
  require("bufferline").go_to_buffer(1, true)
end, { silent = true, desc = "Go To Buffer 1" })
vim.keymap.set("n", "<leader>2", function()
  require("bufferline").go_to_buffer(2, true)
end, { silent = true, desc = "Go To Buffer 2" })
vim.keymap.set("n", "<leader>3", function()
  require("bufferline").go_to_buffer(3, true)
end, { silent = true, desc = "Go To Buffer 3" })
vim.keymap.set("n", "<leader>4", function()
  require("bufferline").go_to_buffer(4, true)
end, { silent = true, desc = "Go To Buffer 4" })
vim.keymap.set("n", "<leader>5", function()
  require("bufferline").go_to_buffer(5, true)
end, { silent = true, desc = "Go To Buffer 5" })
vim.keymap.set("n", "<leader>6", function()
  require("bufferline").go_to_buffer(6, true)
end, { silent = true, desc = "Go To Buffer 6" })
vim.keymap.set("n", "<leader>7", function()
  require("bufferline").go_to_buffer(7, true)
end, { silent = true, desc = "Go To Buffer 7" })
vim.keymap.set("n", "<leader>8", function()
  require("bufferline").go_to_buffer(8, true)
end, { silent = true, desc = "Go To Buffer 8" })
vim.keymap.set("n", "<leader>9", function()
  require("bufferline").go_to_buffer(9, true)
end, { silent = true, desc = "Go To Buffer 9" })

vim.keymap.set("n", "<space>n", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<space>p", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
