return function()
  require('toggleterm').setup({
    open_mapping = [[<c-t>]],
    direction = 'horizontal',
    autochdir = true,
  })

  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  })

  local btop = Terminal:new({
    cmd = 'btop',
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  })

  as.command('Btop', function()
    btop:toggle()
  end)

  as.nnoremap('<C-g>', function()
    lazygit:toggle()
  end)
end
