return function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua',
      'dart',
      'comment',
      'markdown',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>', -- maps in normal mode to init the node/scope selection
        node_incremental = '<CR>', -- increment to the upper named parent
        node_decremental = '<BS>', -- decrement to the previous node
      },
    },
    indent = {
      enable = true,
      disable = { 'yaml' },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['iB'] = '@block.inner',
          ['aB'] = '@block.outer',
          ['ic'] = '@call.inner',
          ['ac'] = '@call.outer',
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [']a'] = '@parameter.inner',
        },
        swap_previous = {
          ['[a'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[['] = '@class.outer',
        },
      },
    },
    rainbow = {
      enable = true,
      colors = {
        'royalblue3',
        'darkorange3',
        'seagreen3',
        'firebrick',
        'darkorchid3',
      },
    },
    autopairs = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = false,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
  })
end
