return function()
  local on_attach = function(client, bufnr)
    if client and client.resolved_capabilities.code_lens then
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

    local opts = { buffer = bufnr }
    as.nnoremap('[e', vim.diagnostic.goto_prev, opts)
    as.nnoremap(']e', vim.diagnostic.goto_next, opts)

    if client.resolved_capabilities.document_formatting then
      as.nnoremap('F', vim.lsp.buf.formatting_sync, opts)
    end

    if client.resolved_capabilities.code_action then
      as.nnoremap('<leader>a', vim.lsp.buf.code_action, opts)
      as.xnoremap('<leader>a', '<esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    end

    if client.resolved_capabilities.goto_definition then
      as.nnoremap('gd', vim.lsp.buf.definition, opts)
    end

    if client.resolved_capabilities.hover then
      as.nnoremap('gk', vim.lsp.buf.hover, opts)
    end

    if client.resolved_capabilities.signature_help then
      as.nnoremap('<C-c>', vim.lsp.buf.signature_help, opts)
      as.inoremap('<C-c>', vim.lsp.buf.signature_help, opts)
    end

    if client.resolved_capabilities.type_definition then
      as.nnoremap('gt', vim.lsp.buf.type_definition, opts)
    end

    if client.resolved_capabilities.code_lens then
      as.nnoremap('<leader>cl', vim.lsp.codelens.run, opts)
    end

    if client.supports_method('textDocument/rename') then
      as.nnoremap('<leader>rn', vim.lsp.buf.rename, opts)
    end

    if client.name ~= 'dartls' then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
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
