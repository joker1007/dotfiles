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
  local bufopts = function(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts "LSP declaration")
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts "LSP saga peek_definition")
  vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", bufopts "LSP saga hover_doc")
  vim.keymap.set("n", "gs", "<cmd>Lspsaga lsp_finder<CR>", bufopts "LSP saga lsp_finder")
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts "LSP implementation")
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts "LSP references")
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts "LSP type_definition")
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts "LSP signature_help")
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts "LSP add_workspace_folder")
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts "LSP remove_workspace_folder")
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts "LSP list_workspace_folders")
  vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", bufopts "LSP saga rename")
  vim.keymap.set("n", "<F6>", "<cmd>Lspsaga rename<CR>", bufopts "LSP saga rename")
  vim.keymap.set("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", bufopts "LSP saga code_action")
  vim.keymap.set("v", "<space>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", bufopts "LSP saga range_code_action")
  vim.keymap.set("n", "<space>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts "LSP saga show_line_diagnostics")
  vim.keymap.set("n", "<space>cl", vim.lsp.codelens.refresh, bufopts "LSP codelens refresh")
  vim.keymap.set("n", "<space>cL", vim.lsp.codelens.clear, bufopts "LSP codelens clear")
  vim.keymap.set("n", "<space>cr", vim.lsp.codelens.run, bufopts "LSP codelens run")
  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts "LSP saga diagnostic_jump_next")
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts "LSP saga diagnostic_jump_prev")
  vim.keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, bufopts "LSP saga diagnostic_jump_prev(ERROR)")
  vim.keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, bufopts "LSP saga diagnostic_jump_next(ERROR)")
  vim.keymap.set("n", "<space>cf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts "LSP format")
end

function M.bundle_installed(cmd, dir)
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle exec which " .. cmd, {
    cwd = dir,
    on_exit = function(_, data)
      ret_code = data
    end,
  })
  vim.fn.jobwait({ jid }, 5000)
  return ret_code == 0
end

function M.add_bundle_exec(config, cmd, dir)
  if config.cmd[1] == "bundle" then
    return
  end
  if M.bundle_installed(cmd, dir) then
    table.insert(config.cmd, 1, "exec")
    table.insert(config.cmd, 1, "bundle")
  end
end

return M
