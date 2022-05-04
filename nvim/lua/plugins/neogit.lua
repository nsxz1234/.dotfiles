local M = {}

function M.setup()
  require('which-key').register({
    ['<leader>g'] = {
      s = 'neogit: open status buffer',
      c = 'neogit: open commit buffer',
      p = 'neogit: open pull popup',
      P = 'neogit: open push popup',
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
  as.nnoremap('<leader>gc', function()
    neogit.open({ 'commit' })
  end)
  as.nnoremap('<leader>gp', neogit.popups.pull.create)
  as.nnoremap('<leader>gP', neogit.popups.push.create)
end

return M
