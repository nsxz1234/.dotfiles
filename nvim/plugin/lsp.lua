if vim.env.DEVELOPING then
  vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
end

--- Add lsp autocommands
---@param client table<string, any>
---@param bufnr number
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
          scope = 'cursor',
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
          vim.lsp.buf.format()
        end,
      },
    })
  end
end

local function setup_mappings(_)
  local function with_desc(desc)
    return { buffer = 0, desc = desc }
  end

  as.nnoremap('[e', vim.diagnostic.goto_prev, with_desc('lsp: go to prev diagnostic'))
  as.nnoremap(']e', vim.diagnostic.goto_next, with_desc('lsp: go to next diagnostic'))

  as.nnoremap('F', vim.lsp.buf.format, with_desc('lsp: format buffer'))
  as.nnoremap('<leader>a', vim.lsp.buf.code_action, with_desc('lsp: code action'))
  as.xnoremap(
    '<leader>a',
    '<esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>',
    with_desc('lsp: code action')
  )
  as.nnoremap('gd', vim.lsp.buf.definition, with_desc('lsp: definition'))
  as.nnoremap('gr', vim.lsp.buf.references, with_desc('lsp: references'))
  as.nnoremap('gi', vim.lsp.buf.implementation, with_desc('lsp: implementation'))
  as.nnoremap('gk', vim.lsp.buf.hover, with_desc('lsp: hover'))
  as.nnoremap('<C-c>', vim.lsp.buf.signature_help, with_desc('lsp: signature_help'))
  as.inoremap('<C-c>', vim.lsp.buf.signature_help, with_desc('lsp: signature_help'))
  as.nnoremap('gt', vim.lsp.buf.type_definition, with_desc('lsp: go to type definition'))
  as.nnoremap('<leader>cl', vim.lsp.codelens.run, with_desc('lsp: run code lens'))
end

local function on_attach(client, bufnr)
  setup_autocommands(client, bufnr)
  setup_mappings(client)
end

as.augroup('LspSetupCommands', {
  {
    event = 'LspAttach',
    desc = 'setup the language server autocommands',
    command = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  },
})

--
-- Signs
--
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--
-- Diagnostic Configuration
--
vim.diagnostic.config({
  virtual_text = false,
})
