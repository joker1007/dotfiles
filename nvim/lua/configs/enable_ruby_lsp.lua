local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local lspconfig = require "lspconfig"

lspconfig.ruby_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    enabledFeatures = {
      "documentSymbol",
      "documentLink",
      "hover",
      "foldingRanges",
      "selectionRanges",
      "semanticHighlighting",
      "formatting",
      "onTypeFormatting",
      "diagnostics",
      "codeActions",
      "codeActionResolve",
      "documentHighlight",
      "inlayHints",
      "completion",
      "codeLens",
    },
  },
})
