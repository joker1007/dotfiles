local M = {}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

M.capabilities = capabilities

function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

function M.make_lsp_capabilities()
  local c = {}
  tableMerge(c, capabilities)
  tableMerge(c, cmp_capabilities)
  return c
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
end

function M.gemfile_exists(dir)
  if dir == "/" then
    return false
  end
  return vim.fn.filereadable(dir .. "/Gemfile") or M.gemfile_exists(vim.fn.fnamemodify(dir, ":h"))
end

function M.add_bundle_exec(config)
  if config.cmd[1] == "bundle" then
    return
  end
  table.insert(config.cmd, 1, "exec")
  table.insert(config.cmd, 1, "bundle")
end

return M
