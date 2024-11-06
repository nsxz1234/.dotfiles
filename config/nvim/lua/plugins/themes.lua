local function highlights()
  vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { link = 'Normal' })
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
}
