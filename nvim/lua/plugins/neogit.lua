local M = {}

function M.setup()
  require('which-key').register({
    ['<leader>g'] = {
      s = 'neogit: open status buffer',
    },
  })
end

function M.config()
  local neogit = require('neogit')
  neogit.setup({
    disable_signs = false,
    disable_hint = true,
    disable_commit_confirmation = true,
    disable_builtin_notifications = true,
    disable_insert_on_commit = false,
    signs = {
      section = { '', '' }, -- "", ""
      item = { '▸', '▾' },
      hunk = { '樂', '' },
    },
    integrations = {
      diffview = true,
    },
  })
  as.nnoremap('<leader>gs', function()
    neogit.open()
  end)
end

return M
