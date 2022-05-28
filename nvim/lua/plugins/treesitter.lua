return function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
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
    },
    textobjects = {
      select = {
        disable = { 'dart' },
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
        disable = { 'dart' },
        enable = true,
        swap_next = {
          [']a'] = '@parameter.inner',
        },
        swap_previous = {
          ['[a'] = '@parameter.inner',
        },
      },
      move = {
        disable = { 'dart' },
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
      lsp_interop = {
        disable = { 'dart' },
        enable = true,
        border = 'rounded',
        peek_definition_code = {
          ['<leader>df'] = '@function.outer',
          ['<leader>dF'] = '@class.outer',
        },
      },
    },
    endwise = {
      enable = true,
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
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
    refactor = {
      navigation = {
        enable = true,
        keymaps = {
          goto_next_usage = '<C-n>',
          goto_previous_usage = '<C-p>',
        },
      },
    },
  })
end
