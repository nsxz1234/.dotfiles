return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      -- vim.g.gruvbox_material_transparent_background = 2
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'soft'
      -- vim.cmd.colorscheme('everforest')
    end,
  },
}