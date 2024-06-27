return {
  'akinsho/flutter-tools.nvim',
  commit = '3e3577300e2f83d22c7f98813444dd77531ff667',
  opts = {
    ui = { border = 'rounded' },
    debugger = {
      enabled = false,
      exception_breakpoints = {},
    },
    outline = {
      open_cmd = '30vnew',
      auto_open = false,
    },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    widget_guides = { enabled = true, debug = false },
    dev_log = { enabled = true, open_cmd = 'tabedit' },
    closing_tags = {
      prefix = '>', -- character to use for close tag e.g. > Widget
      enabled = true, -- set to false to disable
    },
    lsp = {
      color = {
        enabled = true,
        virtual_text = true,
        virtual_text_str = '●',
      },
      settings = {
        analysisExcludedFolders = {
          vim.fn.expand('$HOME/flutter'),
          vim.fn.expand('$HOME/.pub-cache'),
          vim.fn.expand('$HOME/workspace/app-music-player-flutter/build'),
        },
        showTodos = false,
        renameFilesWithClasses = 'always',
        updateImportsOnRename = true,
        completeFunctionCalls = true,
        lineLength = 120,
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'RobertBrunhage/flutter-riverpod-snippets',
  },
}
