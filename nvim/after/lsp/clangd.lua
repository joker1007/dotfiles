local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local clangd_capabilities = lsp_common.make_lsp_capabilities()

clangd_capabilities.textDocument.completion.editsNearCursor = true
clangd_capabilities.offsetEncoding = "utf-8"

return {
  capabilities = clangd_capabilities,
  on_attach = on_attach,
}
