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
    },
  })
end
