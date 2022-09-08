return function()
  local neotest = require('neotest')
  neotest.setup({
    discovery = { enabled = true },
    diagnostic = {
      enabled = false,
    },
    icons = {
      running = as.style.icons.misc.clock,
    },
    adapters = {
      require('neotest-plenary'),
      -- require('neotest-vim-test')({ ignore_filetypes = { 'python', 'lua', 'go' } }),
    },
    floating = {
      border = as.style.current.border,
    },
  })
  local function open() neotest.output.open({ enter = true, short = false }) end

  local function run_file() neotest.run.run(vim.fn.expand('%')) end

  local function run_file_sync()
    require('neotest').run.run({ vim.fn.expand('%'), concurrent = false })
  end

  as.nnoremap('<leader>ts', neotest.summary.toggle, 'neotest: run suite')
  as.nnoremap('<leader>to', open, 'neotest: output')
  as.nnoremap('<leader>tn', neotest.run.run, 'neotest: run')
  as.nnoremap('<leader>tf', run_file, 'neotest: run file')
  as.nnoremap('<localleader>tF', run_file_sync, 'neotest: run file synchronously')
end
