local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local capabilities = lsp_common.capabilities

return {
  filetypes = { "ebuild", "eclass", "PKGBUILD" },
  root_markers = { ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
}
