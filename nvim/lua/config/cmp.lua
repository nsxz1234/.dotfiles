return function()
  local cmp = require 'cmp'

  local api = vim.api
  local t = as.replace_termcodes

  cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    mapping = {
      ['<c-h>'] = cmp.mapping(function()
        api.nvim_feedkeys(vim.fn['copilot#Accept'](t '<Tab>'), 'n', true)
      end),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { select = false },
      ['jj'] = cmp.mapping.confirm { select = true },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'spell' },
    }, {
      { name = 'buffer' },
    }),
  }
  local search_sources = {
    view = {
      entries = { name = 'custom', direction = 'bottom_up' },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
    }, {
      { name = 'buffer' },
    }),
  }

  cmp.setup.cmdline('/', search_sources)
  cmp.setup.cmdline('?', search_sources)
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources {
      { name = 'cmdline', keyword_pattern = [=[[^[:blank:]\!]*]=] },
    },
  })
end
