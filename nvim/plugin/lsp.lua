local lsp = vim.lsp
local api = vim.api
local fmt = string.format

if vim.env.DEVELOPING then vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG) end

local FEATURES = {
  DIAGNOSTICS = { name = 'diagnostics' },
  CODELENS = { name = 'codelens', provider = 'codeLensProvider' },
  FORMATTING = { name = 'formatting', provider = 'documentFormattingProvider' },
  REFERENCES = { name = 'references', provider = 'documentHighlightProvider' },
}

---@param bufnr integer
---@param capability string
---@return table[]
local function clients_by_capability(bufnr, capability)
  return vim.tbl_filter(
    function(c) return c.server_capabilities[capability] end,
    vim.lsp.get_active_clients({ buffer = bufnr })
  )
end

--- Create augroups for each LSP feature and track which capabilities each client
--- registers in a buffer local table
---@param bufnr integer
---@param client table
---@param events table
---@return fun(feature: {provider: string, name: string}, commands: fun(string): ...)
local function augroup_factory(bufnr, client, events)
  return function(feature, commands)
    local provider, name = feature.provider, feature.name
    if not provider or client.server_capabilities[provider] then
      events[name].group_id = as.augroup(fmt('LspCommands_%d_%s', bufnr, name), commands(provider))
      table.insert(events[name].clients, client.id)
    end
  end
end

--- Add lsp autocommands
---@param client table<string, any>
---@param bufnr number
local function setup_autocommands(client, bufnr)
  if not client then
    local msg = fmt('Unable to setup LSP autocommands, client for %d is missing', bufnr)
    return vim.notify(msg, 'error', { title = 'LSP Setup' })
  end

  local b = vim.b[bufnr]
  local events = b.lsp_events
      or {
        [FEATURES.CODELENS.name] = { clients = {}, group_id = nil },
        [FEATURES.FORMATTING.name] = { clients = {}, group_id = nil },
        [FEATURES.DIAGNOSTICS.name] = { clients = {}, group_id = nil },
        [FEATURES.REFERENCES.name] = { clients = {}, group_id = nil },
      }

  local augroup = augroup_factory(bufnr, client, events)
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        scope = 'cursor',
      }
      if vim.b.lsp_hover_win and api.nvim_win_is_valid(vim.b.lsp_hover_win) then return end
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  augroup(FEATURES.CODELENS, function()
    return {
      event = { 'BufEnter', 'CursorHold', 'InsertLeave' },
      desc = 'LSP: Code Lens',
      buffer = bufnr,
      command = function() pcall(lsp.codelens.refresh) end,
    }
  end)

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
          ]])
  end
  b.lsp_events = events
end

---@param bufnr number
local function setup_mappings(_, bufnr)
  local function with_desc(desc) return { buffer = bufnr, desc = desc } end

  map('n', '[e', vim.diagnostic.goto_prev, with_desc('lsp: go to prev diagnostic'))
  map('n', ']e', vim.diagnostic.goto_next, with_desc('lsp: go to next diagnostic'))
  map('n', 'ge', vim.diagnostic.open_float, with_desc('lsp: open diagnostic'))
  map('n', '<leader>le', vim.diagnostic.setqflist, with_desc('lsp: diagnostic list'))
  map({ 'n', 'x' }, 'F', vim.lsp.buf.format, with_desc('lsp: format buffer'))
  map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, with_desc('lsp: code action'))
  map('n', 'gd', vim.lsp.buf.definition, with_desc('lsp: definition'))
  map('n', 'gr', vim.lsp.buf.references, with_desc('lsp: references'))
  map('n', 'gi', vim.lsp.buf.implementation, with_desc('lsp: implementation'))
  map('n', 'gk', vim.lsp.buf.hover, with_desc('lsp: hover'))
  map('n', 'gt', vim.lsp.buf.type_definition, with_desc('lsp: go to type definition'))
  map('n', '<leader>cl', vim.lsp.codelens.run, with_desc('lsp: run code lens'))
end

local function on_attach(client, bufnr)
  local hints_ok, hints = pcall(require, 'lsp-inlayhints')
  if hints_ok then hints.on_attach(client, bufnr) end
  setup_autocommands(client, bufnr)
  setup_mappings(client, bufnr)
end

as.augroup('LspSetupCommands', {
  event = 'LspAttach',
  desc = 'setup the language server autocommands',
  command = function(args)
    local bufnr = args.buf
    -- if the buffer is invalid we should not try and attach to it
    if not api.nvim_buf_is_valid(bufnr) or not args.data then return end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, bufnr)
  end,
}, {
  event = 'LspDetach',
  desc = 'Clean up after detached LSP',
  -- command = function(args) api.nvim_clear_autocmds({ group = get_augroup(args.buf), buffer = args.buf }) end,
  command = function(args)
    local client_id, b = args.data.client_id, vim.b[args.buf]
    if not b.lsp_events or not client_id then return end
    for _, state in pairs(b.lsp_events) do
      if #state.clients == 1 and state.clients[1] == client_id then
        api.nvim_clear_autocmds({ group = state.group_id, buffer = args.buf })
      end
      state.clients = vim.tbl_filter(function(id) return id ~= client_id end, state.clients)
    end
  end,
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

lsp.handlers['textDocument/hover'] = function(...)
  local hover_handler = lsp.with(lsp.handlers.hover, {})
  vim.b.lsp_hover_buf, vim.b.lsp_hover_win = hover_handler(...)
end
