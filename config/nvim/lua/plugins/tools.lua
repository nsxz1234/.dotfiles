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
}