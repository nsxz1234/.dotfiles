local function config()
  local notify = require('notify')
  notify.setup({
    timeout = 3000,
    render = 'minimal',
    max_width = function() return math.floor(vim.o.columns * 0.4) end,
  })
  vim.notify = notify
  require('telescope').load_extension('notify')
  as.nnoremap('<leader>n', notify.dismiss, { desc = 'dismiss notifications' })
end

return { { 'rcarriga/nvim-notify', config = config } }
