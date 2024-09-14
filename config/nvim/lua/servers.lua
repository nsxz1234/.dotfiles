local servers = {
  zls = {},
  clangd = {},
  rust_analyzer = {},
  jsonls = {},
  bashls = {},
  vimls = {},
  marksman = {},
  yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        codeLens = { enable = true },
        hint = {
          enable = true,
          arrayIndex = 'Disable',
          setType = false,
          paramName = 'Disable',
          paramType = true,
        },
        format = { enable = false },
        diagnostics = {
          globals = {
            'vim',
            'P',
            'describe',
            'it',
            'before_each',
            'after_each',
            'packer_plugins',
            'pending',
          },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
}

return function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for name, config in pairs(servers) do
    if type(config) == 'function' then config = config() end
    config.capabilities = capabilities
    require('lspconfig')[name].setup(config)
  end
end
