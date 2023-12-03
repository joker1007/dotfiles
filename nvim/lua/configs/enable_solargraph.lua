local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local lspconfig = require "lspconfig"

lspconfig.solargraph.setup({
  capabilities = lsp_common.make_lsp_capabilities(),
  on_attach = on_attach,
})
