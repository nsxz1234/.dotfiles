return function()
  -- this plugin is not safe to reload
  if vim.g.packer_compiled_loaded then
    return
  end
  local notify = require('notify')
  ---@type table<string, fun(bufnr: number, notif: table, highlights: table)>
  local renderer = require('notify.render')
  notify.setup({
    stages = 'fade_in_slide_out',
    timeout = 3000,
    render = function(bufnr, notif, highlights)
      local style = notif.title[1] == '' and 'minimal' or 'default'
      renderer[style](bufnr, notif, highlights)
    end,
  })
  vim.notify = notify
  require('telescope').load_extension('notify')
  as.nnoremap('<leader>n', notify.dismiss, { desc = 'dismiss notifications' })
end
