return function()
  local cmp = require 'cmp'

  local api = vim.api
  local t = as.replace_termcodes

  local function tab(fallback)
    local ok, luasnip = as.safe_require('luasnip', { silent = true })
    if cmp.visible() then
      cmp.select_next_item()
    elseif ok and luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end

  local function shift_tab(fallback)
    local ok, luasnip = as.safe_require('luasnip', { silent = true })
    if cmp.visible() then
      cmp.select_prev_item()
    elseif ok and luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<c-h>'] = cmp.mapping(function()
        api.nvim_feedkeys(vim.fn['copilot#Accept'](t '<Tab>'), 'n', true)
      end),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<Tab>'] = cmp.mapping(tab, { 'i', 'c' }),
      ['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { select = false },
      ['jj'] = cmp.mapping.confirm { select = true },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.dup = ({
          luasnip = 0,
        })[entry.source.name] or 0
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'spell' },
    }, {
      { name = 'buffer' },
    }),
  }

  cmp.setup.filetype('NeogitCommitMessage', {
    sources = cmp.config.sources({
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  })

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
