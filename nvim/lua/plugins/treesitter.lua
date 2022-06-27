as.treesitter = as.treesitter or {
  install_attempted = {},
}

-- When visiting a file with a type we don't have a parser for, ask me if I want to install it.
function as.treesitter.ensure_parser_installed()
  local WAIT_TIME = 6000
  local parsers = require('nvim-treesitter.parsers')
  local lang = parsers.get_buf_lang()
  local fmt = string.format
  if parsers.get_parser_configs()[lang]
      and not parsers.has_parser(lang)
      and not as.treesitter.install_attempted[lang]
  then
    vim.schedule(function()
      vim.cmd('TSInstall ' .. lang)
      as.treesitter.install_attempted[lang] = true
      vim.notify(fmt('Installing Treesitter parser for %s', lang), 'info', {
        title = 'Nvim Treesitter',
        icon = as.style.icons.misc.down,
        timeout = WAIT_TIME,
      })
    end)
  end
end

return function()
  as.augroup('TSParserCheck', {
    {
      event = 'FileType',
      desc = 'Treesitter: install missing parsers',
      command = as.treesitter.ensure_parser_installed,
    },
  })

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua',
      'dart',
      'comment',
      'markdown',
    },
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
      disable = { 'dart', 'yaml' },
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
      lsp_interop = {
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
