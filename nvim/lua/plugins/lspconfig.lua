return function()
  local on_attach = function(client, bufnr)
    if client and client.server_capabilities.codeLensProvider then
      as.augroup('LspCodeLens', {
        {
          event = { 'BufEnter', 'CursorHold', 'InsertLeave' },
          buffer = bufnr,
          command = function()
            vim.lsp.codelens.refresh()
          end,
        },
      })
    end
    if client.server_capabilities.documentHighlightProvider then
      as.augroup('LspCursorCommands', {
        {
          event = { 'CursorHold' },
          buffer = bufnr,
          command = function()
            vim.diagnostic.open_float({ scope = 'line' }, { focus = false })
          end,
        },
      })
      vim.cmd([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
    end

    local opts = { buffer = bufnr }
    as.nnoremap('[e', vim.diagnostic.goto_prev, opts)
    as.nnoremap(']e', vim.diagnostic.goto_next, opts)

    if client.server_capabilities.documentFormattingProvider then
      as.nnoremap('F', function()
        vim.lsp.buf.formatting_sync(nil, 1000)
      end, opts)
    end

    if client.server_capabilities.codeActionProvider then
      as.nnoremap('<leader>a', vim.lsp.buf.code_action, opts)
      as.xnoremap('<leader>a', '<esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    end

    if client.server_capabilities.definitionProvider then
      as.nnoremap('gd', vim.lsp.buf.definition, opts)
    end

    if client.server_capabilities.hoverProvider then
      as.nnoremap('gk', vim.lsp.buf.hover, opts)
    end

    if client.server_capabilities.signatureHelpProvider then
      as.nnoremap('<C-c>', vim.lsp.buf.signature_help, opts)
      as.inoremap('<C-c>', vim.lsp.buf.signature_help, opts)
    end

    if client.server_capabilities.typeDefinitionProvider then
      as.nnoremap('gt', vim.lsp.buf.type_definition, opts)
    end

    if client.server_capabilities.codeLensProvider then
      as.nnoremap('<leader>cl', vim.lsp.codelens.run, opts)
    end

    if client.server_capabilities.renameProvider then
      as.nnoremap('<leader>rn', vim.lsp.buf.rename, opts)
    end

    if client.name ~= 'dartls' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
  end
end

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = { 'zls' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- Make runtime files discoverable to the server
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  -- luadev
  local luadev = require('lua-dev').setup({
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
  })
  require('lspconfig').sumneko_lua.setup(luadev)

  require('flutter-tools').setup({
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
  })
end
