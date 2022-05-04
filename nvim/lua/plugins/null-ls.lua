return function()
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      null_ls.builtins.code_actions.gitsigns, -- dart formatting
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.zigfmt,
      null_ls.builtins.formatting.stylua, -- install stylua
      null_ls.builtins.formatting.prettier.with({
        filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
      }), -- install prettier
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
      end
    end,
  })
end
