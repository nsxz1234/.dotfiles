local function highlights()
  vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { link = 'Normal' })
  -- https://github.com/neovim/neovim/issues/26037#issuecomment-1838548013
  -- if this is merged into master we can delete.
  vim.api.nvim_set_hl(0, 'WinBar', { link = 'NONE' })
end

return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      -- vim.g.gruvbox_material_transparent_background = 2

      vim.cmd.colorscheme('gruvbox-material')
      highlights()
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'soft'

      -- vim.cmd.colorscheme('everforest')
      -- highlights()
    end,
  },
}
