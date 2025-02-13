local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local lspconfig = require "lspconfig"

lspconfig.ruby_lsp.setup({
  capabilities = lsp_common.make_lsp_capabilities(),
  on_attach = on_attach,
  -- init_options = {
  --   enabledFeatures = {
  --     "documentSymbol",
  --     "documentLink",
  --     "hover",
  --     "foldingRanges",
  --     "selectionRanges",
  --     "semanticHighlighting",
  --     "formatting",
  --     "onTypeFormatting",
  --     "diagnostics",
  --     "codeActions",
  --     "codeActionResolve",
  --     "documentHighlight",
  --     "inlayHints",
  --     "completion",
  --     "codeLens",
  --   },
  -- },
})
