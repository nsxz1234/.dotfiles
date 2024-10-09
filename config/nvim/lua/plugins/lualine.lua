return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = 'auto',
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'toggleterm' },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filetype',
          colored = true,
          icon_only = true,
          padding = { left = 1 },
        },
        {
          'filename',
          path = 0, -- 0: Just the filename  1: Relative path  2: Absolute path
          shorting_target = 0,
        },
        {
          'diagnostics',
          symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌶 ' },
        },
      },
      lualine_x = {
        'selectioncount',
        'searchcount',
        'filesize',
        {
          'diff',
          colored = true,
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          padding = { right = 1 },
        },
      },
      lualine_y = { 'progress' },
      lualine_z = { { 'location', padding = {} } },
    },
  },
}
