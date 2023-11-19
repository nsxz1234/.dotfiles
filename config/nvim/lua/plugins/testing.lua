return {
  'nvim-neotest/neotest',
  lazy = true,
  config = function()
    local neotest = require('neotest')
    neotest.setup({
      discovery = { enabled = true },
      diagnostic = {
        enabled = false,
      },
      floating = { border = as.ui.current.border },
      adapters = {
        require('neotest-plenary'),
        require('neotest-dart')({ command = 'flutter' }),
      },
    })
    local function open() neotest.output.open({ enter = true, short = false }) end

    local function run_file() neotest.run.run(vim.fn.expand('%')) end

    local function run_file_sync()
      require('neotest').run.run({ vim.fn.expand('%'), concurrent = false })
    end

    map('n', '<leader>ts', neotest.summary.toggle, { desc = 'neotest: run suite' })
    map('n', '<leader>to', open, { desc = 'neotest: output' })
    map('n', '<leader>tn', neotest.run.run, { desc = 'neotest: run' })
    map('n', '<leader>tf', run_file, { desc = 'neotest: run file' })
    map('n', '<leader>tF', run_file_sync, { desc = 'neotest: run file synchronously' })
  end,
  dependencies = {
    { 'rcarriga/neotest-plenary', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'sidlatau/neotest-dart' },
  },
}
