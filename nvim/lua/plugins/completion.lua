local function config()
  local cmp = require('cmp')
  local api, fn = vim.api, vim.fn
  local t = as.replace_termcodes
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
    matching = {
      disallow_partial_fuzzy_matching = false,
    },
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
      ['<C-h>'] = cmp.mapping(
        function(_) api.nvim_feedkeys(fn['copilot#Accept'](t('<Tab>')), 'n', true) end
      ),
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
        vim_item.kind = as.ui.lsp.kinds[vim_item.kind]
        vim_item.dup = ({
          luasnip = 0,
        })[entry.source.name] or 0
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      {
        name = 'rg',
        keyword_length = 4,
        max_item_count = 10,
        option = { additional_arguments = '--max-depth 8' },
      },
      -- { name = 'codeium' },
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
end

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = config,
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'f3fora/cmp-spell' },
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
    event = 'InsertEnter',
    dependencies = { 'nvim-cmp' },
    init = function() vim.g.copilot_no_tab_map = true end,
    config = function()
      as.imap('<Plug>(as-copilot-accept)', "copilot#Accept('<Tab>')", { expr = true })
      as.inoremap('<M-]>', '<Plug>(copilot-next)')
      as.inoremap('<M-[>', '<Plug>(copilot-previous)')
      as.inoremap('<C-\\>', '<Cmd>vertical Copilot panel<CR>')
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