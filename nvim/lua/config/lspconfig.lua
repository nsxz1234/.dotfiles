return function()
  local keymap = vim.keymap.set
  keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
  keymap('n', '_', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  keymap('n', '+', '<cmd>lua vim.diagnostic.goto_next()<CR>')

  local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap('n', 'gk', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    keymap({ 'n', 'i' }, '<c-a>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    keymap('v', '<leader>a', '<esc><cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    keymap(
      'n',
      '<space>wl',
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      opts
    )
    keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap('n', 'F', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)

    if client.name ~= 'dartls' then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end

    -- Highlight symbol under cursor
    if client.resolved_capabilities.document_highlight then
      as.augroup('LspCursorCommands', {
        {
          event = { 'CursorHold' },
          buffer = bufnr,
          command = function()
            vim.diagnostic.open_float({ scope = 'line' }, { focus = false })
          end,
        },
        {
          event = { 'CursorHold', 'CursorHoldI' },
          buffer = bufnr,
          description = 'LSP: Document Highlight',
          command = function()
            pcall(vim.lsp.buf.document_highlight)
          end,
        },
        {
          event = 'CursorMoved',
          description = 'LSP: Document Highlight (Clear)',
          buffer = bufnr,
          command = function()
            vim.lsp.buf.clear_references()
          end,
        },
      })
    end
  end

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = { 'rust_analyzer', 'tsserver' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

  -- Make runtime files discoverable to the server
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  -- luadev
  local luadev = require('lua-dev').setup {
    library = {
      plugins = { 'plenary.nvim' },
    },
    lspconfig = {
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              'vim',
              'describe',
              'it',
              'before_each',
              'after_each',
              'pending',
              'teardown',
              'packer_plugins',
            },
          },
          completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        },
      },
    },
  }
  require('lspconfig').sumneko_lua.setup(luadev)

  require('flutter-tools').setup {
    ui = { border = 'rounded' },
    debugger = {
      enabled = true,
      run_via_dap = true,
    },
    outline = { auto_open = false },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    -- widget_guides = { enabled = true, debug = true },
    dev_log = { enabled = false, open_cmd = 'tabedit' },
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
        showTodos = true,
        renameFilesWithClasses = 'prompt',
      },
      on_attach = on_attach,
    },
  }
end
