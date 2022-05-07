return function()
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.prettier.with({
        filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
      }), -- install prettier
    },
  })
end
