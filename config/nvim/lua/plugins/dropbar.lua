return {
  'Bekaboo/dropbar.nvim',
  event = 'VeryLazy',
  keys = { { '<leader>w', function() require('dropbar.api').pick() end } },
  config = function()
    local enable = require('dropbar.configs').opts.bar.enable
    require('dropbar').setup({
      bar = {
        -- show breadcrumb in oil.nvim
        enable = function(buf, win) return enable(buf, win) or vim.bo[buf].ft == 'oil' end,
      },
      icons = {
        ui = { bar = { separator = '  ' } },
        kinds = {
          symbols = vim.tbl_map(
            function(value) return value .. ' ' end,
            require('lspkind').symbol_map
          ),
        },
      },
    })
  end,
}
