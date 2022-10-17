vim.api.nvim_buf_set_keymap(0, "n", ",rt", "<cmd>Octo review start<cr>", { silent = true, noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", ",rs", "<cmd>Octo review submit<cr>", { silent = true, noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", ",rr", "<cmd>Octo review resume<cr>", { silent = true, noremap = true })
