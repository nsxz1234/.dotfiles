local api = vim.api
local fmt = string.format

if vim.env.DEVELOPING then vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG) end

local FEATURES = {
  FORMATTIN = 'formatting',
  CODELENS = 'codelens',
  DIAGNOSTICS = 'diagnostics',
  REFERENCES = 'references',
}

local get_augroup = function(bufnr, method)
  assert(bufnr, 'A bufnr is required to create an lsp augroup')
  return fmt('LspCommands_%d_%s', bufnr, method)
end

---@param bufnr integer
---@param capability string
---@return table[]
local function clients_by_capability(bufnr, capability)
  return vim.tbl_filter(
    function(c) return c.server_capabilities[capability] end,
    vim.lsp.get_active_clients({ buffer = bufnr })
  )
end

--- TODO: neovim upstream should validate the buffer itself rather than each user having to implement this logic
--- Check that a buffer is valid and loaded before calling a callback
--- it also ensures that a client which supports the capability is attached
---@param callback function
---@param buf integer
local function check_valid_request(callback, buf, capability)
  if not buf or not api.nvim_buf_is_loaded(buf) or not api.nvim_buf_is_valid(buf) then return end
  local clients = clients_by_capability(buf, capability)
  if not next(clients) then return end
  callback()
end

--- Add lsp autocommands
---@param client table<string, any>
---@param bufnr number
local function setup_autocommands(client, bufnr)
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
  if client.server_capabilities.codeLensProvider then
    as.augroup(get_augroup(bufnr, FEATURES.CODELENS), {
      {
        event = { 'BufEnter', 'CursorHold', 'InsertLeave' },
        desc = 'LSP: Code Lens',
        buffer = bufnr,
        command = function(args)
          check_valid_request(vim.lsp.codelens.refresh, args.buf, 'codeLensProvider')
        end,
      },
    })
  end
  -- nvim-lspconfig
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
      if not api.nvim_buf_is_valid(args.buf) or not args.data then return end
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  },
  {
    event = 'LspDetach',
    desc = 'Clean up after detached LSP',
    -- command = function(args) api.nvim_clear_autocmds({ group = get_augroup(args.buf), buffer = args.buf }) end,
    command = function(args)
      -- Only clear autocommands if there are no other clients attached to the buffer
      if next(vim.lsp.get_active_clients({ bufnr = args.buf })) then return end
      as.foreach(
        function(feature)
          as.wrap_err(
            fmt('Failed to clear buffer %d augroup for %s', args.buf, feature),
            api.nvim_clear_autocmds,
            { group = get_augroup(args.buf, feature), buffer = args.buf }
          )
        end,
        FEATURES
      )
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
