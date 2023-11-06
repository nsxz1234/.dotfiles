local fn = vim.fn

return {
  { 'f3fora/cmp-spell', ft = { 'gitcommit', 'NeogitCommitMessage', 'markdown', 'norg', 'org' } },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
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

      local function copilot()
        vim.api.nvim_feedkeys(fn['copilot#Accept'](as.replace_termcodes('<Tab>')), 'n', true)
      end

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.select_next_item(),
          }),
          ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
          ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
          ['<C-n>'] = cmp.mapping(function() luasnip.expand_or_jump() end, { 'i', 's' }),
          ['<C-p>'] = cmp.mapping(function() luasnip.jump(-1) end, { 'i', 's' }),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ['<m-space>'] = cmp.mapping(copilot),
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
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip', group_index = 1 },
          { name = 'path', group_index = 1 },
          {
            name = 'rg',
            keyword_length = 4,
            option = { additional_arguments = '--max-depth 8' },
            group_index = 1,
          },
          {
            name = 'buffer',
            options = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
            group_index = 2,
          },
          { name = 'spell', group_index = 2 },
        },
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
  },
  {
    'github/copilot.vim',
    enabled = false,
    event = 'VeryLazy',
    dependencies = { 'nvim-cmp' },
    init = function() vim.g.copilot_no_tab_map = true end,
    config = function()
      local function accept_word()
        fn['copilot#Accept']('')
        local output = fn['copilot#TextQueuedForInsertion']()
        return fn.split(output, [[[ .]\zs]])[1]
      end

      local function accept_line()
        fn['copilot#Accept']('')
        local output = fn['copilot#TextQueuedForInsertion']()
        return fn.split(output, [[[\n]\zs]])[1]
      end
      map('i', '<Plug>(as-copilot-accept)', "copilot#Accept('<Tab>')", {
        expr = true,
        remap = true,
        silent = true,
      })
      map('i', '<m-]>', '<Plug>(copilot-next)')
      map('i', '<m-[>', '<Plug>(copilot-previous)')
      map('i', '<m-w>', accept_word, { expr = true, remap = false, desc = 'accept word' })
      map('i', '<m-l>', accept_line, { expr = true, remap = false, desc = 'accept line' })
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
