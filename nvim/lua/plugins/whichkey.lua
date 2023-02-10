local function config()
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
      a = 'lsp: code action',
      rn = 'lsp: rename',
      cl = 'lsp: run code lens',
    },
    f = {
      p = 'neoclip: open yank history',
    },
    g = {
      d = 'lsp: definition',
      k = 'lsp: hover',
      t = 'lsp: go to type definition',
    },
    ['['] = {
      e = 'lsp: go to prev diagnostic',
    },
    [']'] = {
      e = 'lsp: go to next diagnostic',
    },
  })
end

return { {
  'folke/which-key.nvim',
  enabled = false,
  event = 'VeryLazy',
  config = config,
} }
