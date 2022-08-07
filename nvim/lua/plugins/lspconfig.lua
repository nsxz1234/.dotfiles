return function()
  local fn = vim.fn

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
  local plugins = ('%s/site/pack/packer'):format(fn.stdpath('data'))
  local emmy = ('%s/start/emmylua-nvim'):format(plugins)
  local plenary = ('%s/start/plenary.nvim'):format(plugins)
  local packer = ('%s/opt/packer.nvim'):format(plugins)

  require('lspconfig').sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        hint = { enable = true, arrayIndex = 'Disable', setType = true },
        diagnostics = {
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        workspace = {
          library = { fn.expand('$VIMRUNTIME/lua'), emmy, packer, plenary },
          checkThirdParty = false,
        },
      },
    },
  })
end
