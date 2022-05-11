as.lsp = {}

local function setup_autocommands(client, bufnr)
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
  -- nvim-lspconfig
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          scope = 'line',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
    vim.cmd([[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
          ]])
  end
  -- null-ls
  if client.server_capabilities.documentFormattingProvider then
    as.augroup('LspFormatting', {
      {
        event = { 'BufWritePre' },
        buffer = bufnr,
        command = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      },
    })
  end
end

local function setup_mappings(client, bufnr)
  local opts = { buffer = bufnr }
  as.nnoremap('[e', vim.diagnostic.goto_prev, opts)
  as.nnoremap(']e', vim.diagnostic.goto_next, opts)

  if client.server_capabilities.documentFormattingProvider then
    as.nnoremap('F', function()
      vim.lsp.buf.format({ bufnr = bufnr })
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
end

function as.lsp.on_attach(client, bufnr)
  setup_autocommands(client, bufnr)
  setup_mappings(client, bufnr)
end

return function()
  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = { 'zls' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup({
      on_attach = as.lsp.on_attach,
      capabilities = capabilities,
    })
  end

  -- luadev
  local luadev = require('lua-dev').setup({
    library = { plugins = { 'plenary.nvim' } },
    lspconfig = {
      on_attach = as.lsp.on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          -- format = { enable = false },
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
end
