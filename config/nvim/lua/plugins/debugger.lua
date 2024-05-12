return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>b', '<cmd>lua require("dap").toggle_breakpoint()<cr>' },
      { '<c-1>', '<cmd>lua require("dap").continue()<cr>' },
      { '<c-2>', '<cmd>lua require("dap").step_into()<cr>' },
      { '<c-3>', '<cmd>lua require("dap").step_over()<cr>' },
      { '<c-4>', '<cmd>lua require("dap").step_out()<cr>' },
      { '<c-5>', '<cmd>lua require("dap").repl.toggle()<cr>' },
      { '<c-6>', '<cmd>lua require("dap").run_last()<cr>' },
      { '<leader>d', '<cmd>lua require("dapui").toggle()<cr>' },
    },
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        opts = {},
      },
      { 'theHamsta/nvim-dap-virtual-text', opts = { all_frames = true } },
    },
    config = function()
      local dap = require('dap')

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      local configurations = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      dap.configurations.c = configurations
      dap.configurations.zig = configurations
    end,
  },
}
