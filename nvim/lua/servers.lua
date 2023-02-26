local servers = {
  zls = {},
  rust_analyzer = {},
  jsonls = {},
  bashls = {},
  vimls = {},
  marksman = {},
  yamlls = {},
  lua_ls = function()
    return {
      settings = {
        Lua = {
          hint = { enable = true, arrayIndex = 'Disable', setType = true },
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
    }
  end,
}

return function(name)
  local config = servers[name]
  if type(config) == 'function' then config = config() end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  config.capabilities = capabilities
  return config
end
