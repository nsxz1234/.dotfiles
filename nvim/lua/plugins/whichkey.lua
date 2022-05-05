return function()
  local wk = require('which-key')
  wk.setup({
    plugins = {
      spelling = {
        enabled = true,
      },
    },
    triggers_blacklist = {
      i = { ',', ';' },
      n = { 'v' },
    },
  })

  wk.register({
    ['<leader>'] = {
      f = {
        p = 'neoclip: open yank history',
      },
      a = 'lsp: code action',
      rn = 'lsp: rename',
      cl = 'lsp: run code lens',
    },
    g = {
      d = 'lsp: definition',
      k = 'lsp: hover',
      t = 'lsp: go to type definition',
    },
  })
end
