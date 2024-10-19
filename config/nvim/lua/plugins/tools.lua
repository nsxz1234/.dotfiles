return {
  {
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
      opts = { ui = { height = 0.8 } },
      dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      },
      config = function()
        require('mason').setup()
        require('mason-tool-installer').setup({
          ensure_installed = {
            'bash-language-server',
            'clang-format',
            'json-lsp',
            'lua-language-server',
            'marksman',
            'markdownlint',
            'prettier',
            'stylua',
            'yaml-language-server',
          },
        })
      end,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        'mason.nvim',
        {
          'neovim/nvim-lspconfig',
          dependencies = {
            {
              'folke/lazydev.nvim',
              ft = 'lua', -- only load on lua files
              opts = {},
            },
          },
          config = require('servers'),
        },
      },
      opts = { automatic_installation = true },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        c = { 'clang-format' },
        zig = { 'zigfmt' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        dart = { 'dart_format' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
      },
      formatters = {
        dart_format = {
          append_args = { '-l', '120' },
        },
        ['clang-format'] = {
          append_args = {
            '-style={IndentWidth: 4, ColumnLimit: 100}',
          },
        },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = 'BufReadPre',
    init = function()
      vim.api.nvim_create_autocmd({ 'TextChanged' }, {
        callback = function() require('lint').try_lint() end,
      })
    end,
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'markdownlint' },
      }
    end,
  },
}
