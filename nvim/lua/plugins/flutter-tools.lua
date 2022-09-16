return function()
  require('flutter-tools').setup({
    ui = { border = 'rounded' },
    -- debugger = {
    --   enabled = true,
    --   run_via_dap = true,
    --   exception_breakpoints = {},
    -- },
    outline = {
      open_cmd = '30vnew',
      auto_open = false,
    },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    -- widget_guides = { enabled = true, debug = true },
    dev_log = { enabled = true, open_cmd = 'tabedit' },
    closing_tags = {
      prefix = '>', -- character to use for close tag e.g. > Widget
      enabled = true, -- set to false to disable
    },
    lsp = {
      color = {
        enabled = true,
        background = true,
        virtual_text = false,
      },
      settings = {
        showTodos = false,
        renameFilesWithClasses = 'prompt',
        updateImportsOnRename = true,
        completeFunctionCalls = true,
        lineLength = 100,
      },
    },
  })
end
