return function()
  require('toggleterm').setup({
    open_mapping = [[<c-t>]],
    direction = 'horizontal',
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

  local htop = Terminal:new({
    cmd = 'htop',
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  })

  as.command('Htop', function()
    htop:toggle()
  end)

  as.nnoremap('<C-g>', function()
    lazygit:toggle()
  end)
end
