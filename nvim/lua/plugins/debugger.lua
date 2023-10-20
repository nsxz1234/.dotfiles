return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>b', '<cmd>lua require("dap").toggle_breakpoint()<cr>' },
      { '<leader>1', '<cmd>lua require("dap").continue()<cr>' },
      { '<leader>2', '<cmd>lua require("dap").step_into()<cr>' },
      { '<leader>3', '<cmd>lua require("dap").step_over()<cr>' },
      { '<leader>4', '<cmd>lua require("dap").step_out()<cr>' },
      { '<leader>5', '<cmd>lua require("dap").repl.toggle()<cr>' },
      { '<leader>6', '<cmd>lua require("dap").run_last()<cr>' },
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
