return function()
  local wk = require 'which-key'
  wk.setup {
    plugins = {
      spelling = {
        enabled = true,
      },
    },
    triggers_blacklist = {
      i = { ',', ';' },
    },
  }

  wk.register {
    -- ['<leader>'] = {
    --   n = { '<cmd>noh<cr>', 'noh' },
    -- },
  }
end
