return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        zig = { 'zigfmt' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        dart = { 'dart_format' },
      },
      formatters = {
        dart_format = {
          append_args = { '-l', '120' },
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
