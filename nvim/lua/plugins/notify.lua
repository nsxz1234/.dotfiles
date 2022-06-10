return function()
  local notify = require('notify')
  notify.setup({
    timeout = 3000,
  })
  vim.notify = notify
  require('telescope').load_extension('notify')
  as.nnoremap('<leader>n', notify.dismiss, { desc = 'dismiss notifications' })
end
