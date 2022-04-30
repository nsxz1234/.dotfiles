return function()
  local branch = {
    'branch',
    icon = { '' },
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
  local function get_short_cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  end
  local neo_tree = {
    sections = { lualine_a = { get_short_cwd } },
    filetypes = { 'neo-tree' },
  }
  require('lualine').setup {
    options = {
      theme = 'everforest',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { branch },
      lualine_c = { file_name },
      lualine_x = { diff },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { neo_tree, 'symbols-outline', 'toggleterm' },
  }
end
