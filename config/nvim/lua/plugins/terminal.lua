return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-t>]],
      direction = 'float',
      autochdir = true,
      persist_mode = true,
      auto_scroll = false,
      float_opts = {
        border = 'curved',
      },
    })

    local fn = vim.fn
    local float_handler = function(term)
      if not as.empty(fn.mapcheck('jk', 't')) then
        vim.keymap.del('t', 'jk', { buffer = term.bufnr })
      end
    end
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      count = 2,
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
      float_opts = {
        border = 'curved',
      },
    })
    map('n', '<C-g>', function() lazygit:toggle() end)
  end,
}
