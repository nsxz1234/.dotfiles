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
    },
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        keys = {
          { '<leader>d', '<cmd>lua require("dapui").toggle()<cr>' },
        },
        config = true,
      },
      { 'theHamsta/nvim-dap-virtual-text', opts = { all_frames = true } },
    },
  },
}
