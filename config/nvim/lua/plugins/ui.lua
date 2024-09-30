local lspkind = require('lspkind')

return {
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    keys = { { '<leader>w', function() require('dropbar.api').pick() end, desc = 'winbar: pick' } },
    opts = {
      icons = {
        ui = { bar = { separator = '  ' } },
        kinds = {
          symbols = vim.tbl_map(function(value) return value .. ' ' end, lspkind.symbol_map),
        },
      },
    },
  },
  {
    'lukas-reineke/virt-column.nvim',
    event = 'VimEnter',
    opts = { char = '▕' },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        indent = {
          char = '┊', -- ┊ ▏
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = { 'Function', 'Label' },
        },
      })
    end,
  },
}
