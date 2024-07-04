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
    version = '2.20.8',
    opts = {
      char = '│', -- │ ┆ ┊ 
      show_foldtext = false,
      show_current_context = false,
      show_current_context_start = false,
      show_current_context_start_on_current_line = false,
      show_trailing_blankline_indent = false,
      -- stylua: ignore
      filetype_exclude = {
        'dbout',
        'neo-tree-popup',
        'log',
        'gitcommit',
        'txt',
        'help',
        'NvimTree',
        'git',
        'flutterToolsOutline',
        'undotree',
        'markdown',
        'norg',
        'org',
        'orgagenda',
        '', -- for all buffers without a file type
      },
    },
  },
}
