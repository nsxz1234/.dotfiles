return {
  { 'f3fora/cmp-spell', ft = { 'gitcommit', 'NeogitCommitMessage', 'markdown', 'norg', 'org' } },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'lukas-reineke/cmp-rg' },
      { 'petertriho/cmp-git', opts = { filetypes = { 'gitcommit', 'NeogitCommitMessage' } } },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      local function ctrl_j()
        if not cmp.visible() then return cmp.complete() end
        cmp.select_next_item()
      end

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.select_next_item(),
          }),
          ['<C-j>'] = cmp.mapping({
            i = ctrl_j,
            c = cmp.mapping.select_next_item(),
          }),
          ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
          ['<C-n>'] = cmp.mapping(function() luasnip.expand_or_jump() end, { 'i', 's' }),
          ['<C-p>'] = cmp.mapping(function() luasnip.jump(-1) end, { 'i', 's' }),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        },
        formatting = {
          deprecated = true,
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = math.floor(vim.o.columns * 0.5),
            before = function(_, vim_item)
              vim_item.dup = {}
              return vim_item
            end,
            menu = {
              nvim_lsp = 'LSP',
              nvim_lua = 'LUA',
              emoji = 'EMOJI',
              path = 'PATH',
              neorg = 'NEORG',
              luasnip = 'SNIP',
              dictionary = 'DIC',
              buffer = 'BUF',
              spell = 'SPELL',
              orgmode = 'ORG',
              norg = 'NORG',
              rg = 'RG',
              git = 'GIT',
            },
          }),
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip', group_index = 1 },
          { name = 'path', group_index = 1 },
          {
            name = 'buffer',
            options = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
            group_index = 1,
          },
          {
            name = 'rg',
            keyword_length = 4,
            option = { additional_arguments = '--max-depth 8' },
            group_index = 1,
          },
          { name = 'spell', group_index = 2 },
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'cmdline_history', priority = 10, max_item_count = 5 },
        }),
      })
    end,
  },
}
