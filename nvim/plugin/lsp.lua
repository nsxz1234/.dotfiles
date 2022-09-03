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

---@param buf integer
---@return boolean
local function is_buffer_valid(buf)
  return buf and api.nvim_buf_is_loaded(buf) and api.nvim_buf_is_valid(buf)
end

--- TODO: neovim upstream should validate the buffer itself rather than each user having to implement this logic
--- Check that a buffer is valid and loaded before calling a callback
--- it also ensures that a client which supports the capability is attached
---@param buf integer
---@return boolean, table[]
local function check_valid_client(buf, capability)
  if not is_buffer_valid(buf) then return false, {} end
  local clients = clients_by_capability(buf, capability)
  return next(clients) ~= nil, clients
end

--- Create augroups for each LSP feature and track which capabilities each client
--- registers in a buffer local table
---@param bufnr integer
---@param client table
---@param events table
---@return fun(feature: string, commands: fun(string): Autocommand[])
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

  local events = vim.F.if_nil(vim.b.lsp_events, {
    [FEATURES.CODELENS.name] = { clients = {}, group_id = nil },
    [FEATURES.FORMATTING.name] = { clients = {}, group_id = nil },
    [FEATURES.DIAGNOSTICS.name] = { clients = {}, group_id = nil },
    [FEATURES.REFERENCES.name] = { clients = {}, group_id = nil },
  })

  local lsp_augroup = augroup_factory(bufnr, client, events)

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

  lsp_augroup(FEATURES.CODELENS, function(provider)
    return {
      {
        event = { 'BufEnter', 'CursorHold', 'InsertLeave' },
        desc = 'LSP: Code Lens',
        buffer = bufnr,
        command = function(args)
          if check_valid_client(args.buf, provider) then lsp.codelens.refresh() end
        end,
      },
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
  vim.b[bufnr].lsp_events = events
end

---@param bufnr number
local function setup_mappings(_, bufnr)
  local function with_desc(desc) return { buffer = bufnr, desc = desc } end

  as.nnoremap('[e', vim.diagnostic.goto_prev, with_desc('lsp: go to prev diagnostic'))
  as.nnoremap(']e', vim.diagnostic.goto_next, with_desc('lsp: go to next diagnostic'))
  as.nnoremap('ge', vim.diagnostic.setqflist, with_desc('lsp: diagnostic list'))

  as.nnoremap('F', vim.lsp.buf.format, with_desc('lsp: format buffer'))
  vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, with_desc('lsp: code action'))
  as.nnoremap('gd', vim.lsp.buf.definition, with_desc('lsp: definition'))
  as.nnoremap('gr', vim.lsp.buf.references, with_desc('lsp: references'))
  as.nnoremap('gi', vim.lsp.buf.implementation, with_desc('lsp: implementation'))
  as.nnoremap('gk', vim.lsp.buf.hover, with_desc('lsp: hover'))
  as.nnoremap('gt', vim.lsp.buf.type_definition, with_desc('lsp: go to type definition'))
  as.nnoremap('<leader>cl', vim.lsp.codelens.run, with_desc('lsp: run code lens'))
end

local function on_attach(client, bufnr)
  local hints_ok, hints = pcall(require, 'lsp-inlayhints')
  if hints_ok then hints.on_attach(client, bufnr) end
  setup_autocommands(client, bufnr)
  setup_mappings(client, bufnr)
end

as.augroup('LspSetupCommands', {
  {
    event = 'LspAttach',
    desc = 'setup the language server autocommands',
    command = function(args)
      local bufnr = args.buf
      -- if the buffer is invalid we should not try and attach to it
      if not api.nvim_buf_is_valid(bufnr) or not args.data then return end
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  },
  {
    event = 'LspDetach',
    desc = 'Clean up after detached LSP',
    -- command = function(args) api.nvim_clear_autocmds({ group = get_augroup(args.buf), buffer = args.buf }) end,
    command = function(args)
      local client_id = args.data.client_id
      if not vim.b.lsp_events or not client_id then return end
      for _, state in pairs(vim.b.lsp_events) do
        if #state.clients == 1 and state.clients[1] == client_id then
          api.nvim_clear_autocmds({ group = state.group_id, buffer = args.buf })
        end
        vim.tbl_filter(function(id) return id ~= client_id end, state.clients)
      end
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
