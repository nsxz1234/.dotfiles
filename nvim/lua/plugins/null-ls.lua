return function()
  local null_ls = require('null-ls')
  null_ls.setup({
    on_attach = as.lsp.on_attach,
    sources = {
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.stylua, -- install stylua
      null_ls.builtins.formatting.prettier.with({
        filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
      }), -- install prettier
    },
  })
end
