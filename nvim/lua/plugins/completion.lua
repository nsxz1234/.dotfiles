return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local function tab(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end

      local function shift_tab(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end

      cmp.setup({
        matching = { disallow_partial_fuzzy_matching = false },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
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
          ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        },
        formatting = {
          deprecated = true,
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = as.ui.lsp.kinds[vim_item.kind]
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
          {
            name = 'rg',
            keyword_length = 4,
            max_item_count = 10,
            option = { additional_arguments = '--max-depth 8' },
          },
        }, {
          {
            name = 'buffer',
            options = {
              get_bufnrs = function() return vim.api.nvim_list_bufs() end,
            },
          },
          { name = 'spell' },
        }),
      })

      local search_sources = {
        sources = cmp.config.sources(
          { { name = 'nvim_lsp_document_symbol' } },
          { { name = 'buffer' } }
        ),
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
    end,
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      {
        'f3fora/cmp-spell',
        ft = { 'gitcommit', 'NeogitCommitMessage', 'markdown', 'norg', 'org' },
      },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'lukas-reineke/cmp-rg' },
      {
        'petertriho/cmp-git',
        opts = { filetypes = { 'gitcommit', 'NeogitCommitMessage' } },
      },
    },
  },
  {
    'github/copilot.vim',
    event = 'VeryLazy',
    dependencies = { 'nvim-cmp' },
    config = function()
      map('i', '<M-]>', '<Plug>(copilot-next)')
      map('i', '<M-[>', '<Plug>(copilot-previous)')
      vim.g.copilot_filetypes = {
        ['*'] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
        DressingInput = false,
        TelescopePrompt = false,
        ['neo-tree-popup'] = false,
        ['dap-repl'] = false,
      }
    end,
  },
}
