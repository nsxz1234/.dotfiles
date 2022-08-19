return function()
  local file_name = {
    'filename',
    path = 1, -- 0: Just the filename  1: Relative path  2: Absolute path
    shorting_target = 0,
  }
  local diff = {
    'diff',
    colored = true,
    symbols = { added = ' ', modified = ' ', removed = ' ' },
  }
  require('lualine').setup({
    options = {
      theme = 'auto',
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'toggleterm' },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { file_name },
      lualine_x = { diff },
      lualine_y = { 'progress' },
      lualine_z = { { 'location', padding = {} } },
    },
  })
end
