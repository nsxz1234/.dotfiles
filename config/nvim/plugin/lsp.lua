local icons = as.ui.icons.lsp
local lsp = vim.lsp

if vim.env.DEVELOPING then vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG) end

local provider = {
  HOVER = 'hoverProvider',
  RENAME = 'renameProvider',
  CODELENS = 'codeLensProvider',
  CODEACTIONS = 'codeActionProvider',
  FORMATTING = 'documentFormattingProvider',
  REFERENCES = 'documentHighlightProvider',
  DEFINITION = 'definitionProvider',
}

---@param buf integer
local function setup_autocommands(client, buf)
  if client.server_capabilities[provider.CODELENS] then
    as.augroup(('LspCodeLens%d'):format(buf), {
      event = { 'BufEnter', 'InsertLeave', 'BufWritePost' },
      desc = 'LSP: Code Lens',
      buffer = buf,
      command = function() lsp.codelens.refresh() end,
    })
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
          ]])
  end
end

---@param bufnr integer
local function setup_mappings(_, bufnr)
  local function with_desc(desc) return { buffer = bufnr, desc = desc } end

  map('n', '[e', vim.diagnostic.goto_prev, with_desc('lsp: go to prev diagnostic'))
  map('n', ']e', vim.diagnostic.goto_next, with_desc('lsp: go to next diagnostic'))
  map('n', 'ge', vim.diagnostic.open_float, with_desc('lsp: open diagnostic'))
  map('n', '<leader>le', vim.diagnostic.setqflist, with_desc('lsp: diagnostic list'))
  map({ 'n', 'x' }, '<c-f>', require('conform').format, with_desc('lsp: format buffer'))
  map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, with_desc('lsp: code action'))
  map('n', 'gd', vim.lsp.buf.definition, with_desc('lsp: definition'))
  map('n', 'gr', vim.lsp.buf.references, with_desc('lsp: references'))
  map('n', 'gi', vim.lsp.buf.implementation, with_desc('lsp: implementation'))
  map('n', 'gt', vim.lsp.buf.type_definition, with_desc('lsp: go to type definition'))
  map('n', 'K', vim.lsp.buf.hover, with_desc('lsp: hover'))
  map('n', '<leader>cl', vim.lsp.codelens.run, with_desc('lsp: run code lens'))
end

local function on_attach(client, bufnr)
  setup_autocommands(client, bufnr)
  setup_mappings(client, bufnr)
end

as.augroup('LspSetupCommands', {
  event = 'LspAttach',
  desc = 'setup the language server autocommands',
  command = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    on_attach(client, args.buf)
  end,
})

--
-- Signs
--
local signs = { Error = icons.error, Warn = icons.warn, Hint = icons.hint, Info = icons.info }
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

lsp.handlers['textDocument/hover'] = function(...)
  local hover_handler = lsp.with(lsp.handlers.hover, {})
  vim.b.lsp_hover_buf, vim.b.lsp_hover_win = hover_handler(...)
end
