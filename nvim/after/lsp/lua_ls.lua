local lsp_common = require "lsp_common"
local on_attach = lsp_common.on_attach
local capabilities = lsp_common.make_lsp_capabilities()

local libraries = {
  "/usr/share/hypr/stubs",
}
vim.list_extend(libraries, vim.api.nvim_get_runtime_file("lua", true))

return {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "hl" },
      },
      workspace = {
        library = libraries,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
