return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      char = '┊', -- │ ┆ ┊ 
      show_foldtext = false,
      show_current_context = false,
      show_current_context_start = false,
      show_current_context_start_on_current_line = false,
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      filetype_exclude = {
        'neo-tree-popup',
        'dap-repl',
        'startify',
        'dashboard',
        'log',
        'fugitive',
        'gitcommit',
        'packer',
        'vimwiki',
        'markdown',
        'txt',
        'vista',
        'help',
        'NvimTree',
        'git',
        'TelescopePrompt',
        'undotree',
        'flutterToolsOutline',
        'norg',
        'org',
        'orgagenda',
        '', -- for all buffers without a file type
      },
      buftype_exclude = { 'terminal', 'nofile' },
    },
  },
  {
    'rcarriga/nvim-notify',
    init = function()
      local notify = require('notify')
      notify.setup({
        timeout = 3000,
        render = 'minimal',
        max_width = function() return math.floor(vim.o.columns * 0.4) end,
        max_height = function() return math.floor(vim.o.lines * 0.4) end,
      })
      vim.notify = notify
      require('telescope').load_extension('notify')
      as.nnoremap(
        '<leader>n',
        function() notify.dismiss({ silent = true, pending = true }) end,
        { desc = 'dismiss notifications' }
      )
    end,
  },
}
