return function()
  local cmp = require('cmp')

  local function tab(fallback)
    local ok, luasnip = as.require('luasnip', { silent = true })
    if ok and luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end

  local function shift_tab(fallback)
    local ok, luasnip = as.require('luasnip', { silent = true })
    if ok and luasnip.jumpable(-1) then
      luasnip.jump(-1)
    elseif cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(tab, { 's', 'c' }),
      ['<C-n>'] = cmp.mapping(tab, { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(shift_tab, { 'i', 's' }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['jj'] = cmp.mapping.confirm({ select = true }),
      ['<C-q>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    },
    formatting = {
      deprecated = true,
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        vim_item.kind = as.style.lsp.kinds[vim_item.kind]
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
    }, {
      { name = 'buffer' },
      { name = 'spell' },
    }),
  })

  local search_sources = {
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
    }, {
      { name = 'buffer' },
    }),
  }

  cmp.setup.cmdline('/', search_sources)
  cmp.setup.cmdline('?', search_sources)
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'cmdline', keyword_pattern = [=[[^[:blank:]\!]*]=] },
      { name = 'path' },
      { name = 'cmdline_history', priority = 10, max_item_count = 5 },
    }),
  })
end
