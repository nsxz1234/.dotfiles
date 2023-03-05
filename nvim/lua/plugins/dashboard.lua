return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.opts.hl = 'String'
    dashboard.section.header.val = {
      '██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗',
      '██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝',
      '██║   ██║███████╗    ██║     ██║   ██║██║  ██║█████╗  ',
      '╚██╗ ██╔╝╚════██║    ██║     ██║   ██║██║  ██║██╔══╝  ',
      ' ╚████╔╝ ███████║    ╚██████╗╚██████╔╝██████╔╝███████╗',
      '  ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝',
    }
    alpha.setup(dashboard.config)
  end,
}
