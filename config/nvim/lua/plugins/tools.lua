return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim', 'none-ls.nvim' },
    config = function()
      require('mason-null-ls').setup({
        automatic_setup = true,
        automatic_installation = true,
        ensure_installed = { 'buf', 'stylua', 'prettier' },
        handlers = {},
      })
      require('null-ls').setup()
    end,
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
