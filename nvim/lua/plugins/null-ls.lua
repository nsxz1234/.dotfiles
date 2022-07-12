return function()
  local null_ls = require('null-ls')
  null_ls.setup({
    debounce = 150,
    sources = {
      null_ls.builtins.diagnostics.buf,
      null_ls.builtins.diagnostics.zsh,
      -- install stylua
      null_ls.builtins.formatting.stylua.with({
        condition = function() return as.executable('stylua') end,
      }),
      null_ls.builtins.formatting.prettier.with({
        filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
      }), -- install prettier
    },
  })
end
