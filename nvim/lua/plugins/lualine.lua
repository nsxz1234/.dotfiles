return function()
  local branch = {
    'branch',
    icon = { '' },
  }
  local filetype = {
    'filetype',
    colored = true,
    icon_only = true,
    padding = { left = 1 },
  }
  local file_name = {
    'filename',
    path = 1, -- 0: Just the filename  1: Relative path  2: Absolute path
  }
  local diff = {
    'diff',
    colored = true,
    symbols = { added = ' ', modified = ' ', removed = ' ' },
  }
  local progress = {
    'progress',
    padding = { right = 1 },
  }
  require('lualine').setup({
    options = {
      theme = 'auto',
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'toggleterm' },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {},
      lualine_c = { filetype, file_name },
      lualine_x = { diff, branch },
      lualine_y = { progress },
      lualine_z = { 'location' },
    },
  })
end
