return function()
  local function get_short_cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  end
  local neotree = {
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
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = { 'diff' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { neotree, 'symbols-outline', 'toggleterm' },
  }
end
