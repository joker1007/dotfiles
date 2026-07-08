return {
  on_attach = function(client, bufnr)
    -- Disable semantic tokens to stop high CPU freezes
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
