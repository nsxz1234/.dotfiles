return function()
  -- this plugin is not safe to reload
  if vim.g.packer_compiled_loaded then
    return
  end
  local notify = require('notify')
  notify.setup({
    timeout = 3000,
  })
  vim.notify = notify
  require('telescope').load_extension('notify')
  as.nnoremap('<leader>n', notify.dismiss, { desc = 'dismiss notifications' })
end
