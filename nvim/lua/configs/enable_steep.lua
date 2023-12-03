local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local lspconfig = require "lspconfig"

lspconfig.steep.setup({
  capabilities = lsp_common.make_lsp_capabilities(),
  filetypes = { "ruby", "eruby", "rbs" },
  cmd = { "steep", "--log-output=/tmp/steep.log", "langserver" },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<space>ct", function()
      client.request("$/typecheck", { guid = "typecheck-" .. os.time() }, function() end, bufnr)
    end, { silent = true, buffer = bufnr })
  end,
})
