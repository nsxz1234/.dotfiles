local icons = as.ui.icons.lsp
return {
  {
    'lukas-reineke/virt-column.nvim',
    event = 'VimEnter',
    opts = { char = '▕' },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊', -- │ ┆ ┊ 
      show_foldtext = false,
      show_current_context = false,
      show_current_context_start = false,
      show_current_context_start_on_current_line = false,
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
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
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      notify.setup({
        background_colour = '#333333',
        timeout = 3000,
        render = 'minimal',
        max_width = function() return math.floor(vim.o.columns * 0.4) end,
        max_height = function() return math.floor(vim.o.lines * 0.4) end,
      })
      vim.notify = notify
      map(
        'n',
        '<leader>n',
        function() notify.dismiss({ silent = true, pending = true }) end,
        { desc = 'dismiss notifications' }
      )
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'UIEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup({
        options = {
          debug = { logging = true },
          mode = 'buffers', -- tabs
          sort_by = 'insert_after_current',
          move_wraps_at_ends = true,
          right_mouse_command = 'vert sbuffer %d',
          show_close_icon = false,
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level)
            level = level:match('warn') and 'warn' or level
            return (icons[level] or '?') .. ' ' .. count
          end,
          diagnostics_update_in_insert = false,
          offsets = {
            {
              text = ' DIFF VIEW',
              filetype = 'DiffviewFiles',
              highlight = 'PanelHeading',
            },
            {
              text = ' FLUTTER OUTLINE',
              filetype = 'flutterToolsOutline',
              highlight = 'PanelHeading',
            },
          },
          groups = {
            options = { toggle_hidden_on_enter = true },
          },
        },
      })

      map('n', 'd<space>', ':BufferLinePickClose<cr>')
      map('n', 'H', ':BufferLineCyclePrev<cr>')
      map('n', 'L', ':BufferLineCycleNext<cr>')
      map('n', '<m-H>', ':BufferLineMovePrev<CR>')
      map('n', '<m-L>', ':BufferLineMoveNext<CR>')
    end,
  },
}
