return {
  'Bekaboo/dropbar.nvim',
  event = 'VeryLazy',
  keys = { { '<leader>w', function() require('dropbar.api').pick() end, desc = 'winbar: pick' } },
  opts = {
    general = {
      -- show breadcrumb in oil.nvim
      enable = true,
    },
    icons = {
      ui = { bar = { separator = '  ' } },
      kinds = {
        symbols = vim.tbl_map(
          function(value) return value .. ' ' end,
          require('lspkind').symbol_map
        ),
      },
    },
  },
}
