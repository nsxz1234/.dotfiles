return function()
  local on_attach = function(client, bufnr)
    if client.name ~= 'dartls' then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end

    -- Highlight symbol under cursor
    if client.resolved_capabilities.document_highlight then
      vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
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
