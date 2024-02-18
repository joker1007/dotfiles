local wk = require "which-key"
local noremap_silent = { noremap = true, silent = true }

-- swap ; and :
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", ":", ";", {})
vim.keymap.set("v", ";", ":", {})
vim.keymap.set("v", ":", ";", {})

-- search
vim.keymap.set("n", "<space>/", ":noh<CR>", { silent = true })
vim.keymap.set("n", "*", "<Plug>(visualstar-*)N", { remap = true })
vim.keymap.set("n", "#", "<Plug>(visualstar-#)N", { remap = true })

-- tab
vim.keymap.set("n", "<S-Right>", ":<C-U>tabnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", ":<C-U>tabprevious<CR>", { silent = true })
vim.keymap.set("n", "L", ":<C-U>tabnext<CR>", { silent = true })
vim.keymap.set("n", "H", ":<C-U>tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<C-L>", ":<C-U>tabmove +1<CR>", { silent = true })
vim.keymap.set("n", "<C-H>", ":<C-U>tabmove -1<CR>", { silent = true })

-- completion
vim.keymap.set("i", "<C-X><C-O>", "<C-X><C-O><C-P>")

-- move cursor
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "gj", "j", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "gk", "k", { silent = true })
vim.keymap.set("n", "$", "g$", { silent = true })
vim.keymap.set("n", "g$", "$", { silent = true })
vim.keymap.set("v", "j", "gj", { silent = true })
vim.keymap.set("v", "gj", "j", { silent = true })
vim.keymap.set("v", "k", "gk", { silent = true })
vim.keymap.set("v", "gk", "k", { silent = true })
vim.keymap.set("v", "$", "g$", { silent = true })
vim.keymap.set("v", "g$", "$", { silent = true })

vim.keymap.set("v", "(", "t(", { remap = true })
vim.keymap.set("v", ")", "t)", { remap = true })
vim.keymap.set("v", "]", "t]", { remap = true })
vim.keymap.set("v", "[", "t[", { remap = true })
vim.keymap.set("o", "(", "t(", { remap = true })
vim.keymap.set("o", ")", "t)", { remap = true })
vim.keymap.set("o", "]", "t]", { remap = true })
vim.keymap.set("o", "[", "t[", { remap = true })

-- JとDで半ページ移動
vim.keymap.set("n", "J", "<C-D>", { silent = true })
vim.keymap.set("n", "K", "<C-U>", { silent = true })

-- 編集中のファイルのディレクトリに移動
vim.cmd [[command! CdCurrent execute ":cd" . expand("%:p:h")]]
vim.keymap.set("n", ",c", ":<C-U>CdCurrent<CR>:pwd<CR>", { silent = true })

-- Quickfix
vim.keymap.set("n", ",q", ":<C-U>copen<CR>", { silent = true })
vim.keymap.set("n", "]q", ":<C-U>cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":<C-U>cprev<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":<C-U>clast<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":<C-U>cfirst<CR>", { silent = true })

-- bufdelete
vim.keymap.set("n", ",bd", "<cmd>Bdelete<cr>")
vim.keymap.set("n", "<A-w>", "<cmd>Bdelete<cr>")
vim.keymap.set("n", ",bD", "<cmd>Bdelete!<cr>")

-- vim-test
vim.keymap.set("n", "<space>tn", ":TestNearest<cr>")
vim.keymap.set("n", "<space>tf", ":TestFile<cr>")

-- surround.vim {{{
vim.keymap.set("n", ",(", "csw(", { remap = true })
vim.keymap.set("n", ",)", "csw)", { remap = true })
vim.keymap.set("n", ",{", "csw{", { remap = true })
vim.keymap.set("n", ",}", "csw}", { remap = true })
vim.keymap.set("n", ",[", "csw[", { remap = true })
vim.keymap.set("n", ",]", "csw]", { remap = true })
vim.keymap.set("n", ",'", "csw'", { remap = true })
vim.keymap.set("n", ',"', 'csw"', { remap = true })
--}}}

-- Tabular {{{
wk.register({
  ["<leader>a"] = { name = "+Tabularize" },
})
vim.keymap.set("n", "<Leader>a,", ":Tabularize /,<CR>")
vim.keymap.set("n", "<Leader>a=", ":Tabularize /=<CR>")
vim.keymap.set("n", "<Leader>a>", ":Tabularize /=><CR>")
vim.keymap.set("n", "<Leader>a:", ":Tabularize /:\zs<CR>")
vim.keymap.set("n", "<Leader>a<Bar>", ":Tabularize /<Bar><CR>")

vim.keymap.set("v", "<Leader>a,", ":Tabularize /,<CR>")
vim.keymap.set("v", "<Leader>a=", ":Tabularize /=<CR>")
vim.keymap.set("v", "<Leader>a>", ":Tabularize /=><CR>")
vim.keymap.set("v", "<Leader>a:", ":Tabularize /:\zs<CR>")
vim.keymap.set("v", "<Leader>a<Bar>", ":Tabularize /<Bar><CR>")
-- }}}

-- toggleterm {{{
vim.keymap.set("t", "<A-n>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")
--- }}}

-- vim-choosewin
vim.keymap.set("n", "_", "<Plug>(choosewin)", { remap = true })

-- replacer.nvim
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf" },
  group = "vimrc",
  callback = function()
    vim.keymap.set("n", "r", function()
      require("replacer").run()
    end, { buffer = 0 })
  end,
})

-- lsp
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap_silent)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap_silent)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap_silent)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap_silent)

vim.keymap.set("n", "<leader>v", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<space>o", "<cmd>AerialToggle!<CR>")

-- trouble.nvim
wk.register({
  ["<leader>x"] = {
    name = "+Trouble",
  },
})
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

wk.register({
  [",g"] = {
    name = "+git",
  },
})

-- fugitive
vim.keymap.set("n", ",gs", "<cmd>Git<CR>")
vim.keymap.set("n", ",ga", "<cmd>Gwrite<CR>")
vim.keymap.set("n", ",gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", ",gC", "<cmd>Git commit --amend<CR>")
vim.keymap.set("n", ",gb", "<cmd>Git blame<CR>")
vim.keymap.set("n", ",gn", "<cmd>Git now<CR>")
vim.keymap.set("n", ",gN", "<cmd>Git now --all<CR>")

-- ghpr-blame
vim.keymap.set("n", ",gp", ":<C-u>GHPRBlame<CR>")

-- neogit
wk.register({
  ["<leader>g"] = {
    name = "+Neogit",
    g = {
      function()
        require("neogit").open({ kind = "split_above" })
      end,
      "Neogit",
      silent = true,
    },
  },
})

-- flog
vim.keymap.set("n", ",gl", "<cmd>Flog<CR>")

-- diffview
vim.keymap.set("n", ",gd", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", ",gh", "<cmd>DiffviewFileHistory %<CR>")

-- octo
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

-- dap
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

-- jaq-nvim
vim.keymap.set("n", "<leader>q", "<cmd>Jaq<cr>")

-- neogen
wk.register({
  ["<leader>ng"] = {
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

-- other.nvim
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

-- neotree
vim.keymap.set("n", "<leader>tt", "<cmd>Neotree toggle filesystem reveal<cr>")
