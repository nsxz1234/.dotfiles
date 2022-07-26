return function()
  local fn, api = vim.fn, vim.api

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
  local lib = vim.tbl_filter(function(p)
    if p:match('emmy') then return true end
    return not vim.startswith(p, fn.stdpath('data') .. '/site/')
  end, api.nvim_get_runtime_file('', true))

  require('lspconfig').sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        workspace = {
          library = lib,
        },
      },
    },
  })
end
