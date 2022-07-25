return function()
  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = { 'zls' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup({
      capabilities = capabilities,
    })
  end

  -- luadev
  require('lspconfig').sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        -- workspace = {
        --   library = vim.api.nvim_get_runtime_file('', true),
        -- },
      },
    },
  })
end
