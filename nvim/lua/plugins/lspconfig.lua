as.lsp = {}

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
  local luadev = require('lua-dev').setup({
    library = { plugins = { 'plenary.nvim' } },
    lspconfig = {
      on_attach = as.lsp.on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
          },
          completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        },
      },
    },
  })
  require('lspconfig').sumneko_lua.setup(luadev)
end
