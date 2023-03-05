local function config()
  local filetype = {
    'filetype',
    colored = true,
    icon_only = true,
    padding = { left = 1 },
  }
  local file_name = {
    'filename',
    path = 0, -- 0: Just the filename  1: Relative path  2: Absolute path
    shorting_target = 0,
  }
  local diff = {
    'diff',
    colored = true,
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    padding = { right = 1 },
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
      lualine_c = { filetype, file_name },
      lualine_x = { 'searchcount', diff },
      lualine_y = { 'progress' },
      lualine_z = { { 'location', padding = {} } },
    },
  })
end

return { { 'nvim-lualine/lualine.nvim', config = config } }
