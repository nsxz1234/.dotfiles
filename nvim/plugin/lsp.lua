local api = vim.api
local fmt = string.format

if vim.env.DEVELOPING then vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG) end

local get_augroup = function(bufnr)
  assert(bufnr, 'A bufnr is required to create an lsp augroup')
  return fmt('LspCommands_%d', bufnr)
end

--- Add lsp autocommands
---@param client table<string, any>
---@param bufnr number
local function setup_autocommands(client, bufnr)
  local group = get_augroup(bufnr)
  -- Clear pre-existing buffer autocommands
  pcall(api.nvim_clear_autocmds, { group = group })

  local cmds = {}
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
    table.insert(cmds, {
      event = { 'BufEnter', 'CursorHold', 'InsertLeave' },
      buffer = bufnr,
      command = function(args)
        if api.nvim_buf_is_valid(args.buf) then vim.lsp.codelens.refresh() end
      end,
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
  as.augroup(group, cmds)
end

---@param bufnr number
local function setup_mappings(_, bufnr)
  local function with_desc(desc) return { buffer = bufnr, desc = desc } end

  as.nnoremap('[e', vim.diagnostic.goto_prev, with_desc('lsp: go to prev diagnostic'))
  as.nnoremap(']e', vim.diagnostic.goto_next, with_desc('lsp: go to next diagnostic'))
  as.nnoremap('ge', vim.diagnostic.setqflist, with_desc('lsp: diagnostic list'))

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
  as.nnoremap('gt', vim.lsp.buf.type_definition, with_desc('lsp: go to type definition'))
  as.nnoremap('<leader>cl', vim.lsp.codelens.run, with_desc('lsp: run code lens'))
end

local function on_attach(client, bufnr)
  -- Otherwise, if there is already an attached client then
  -- mappings and other settings should not be re-applied
  local active = vim.lsp.get_active_clients({ bufnr = bufnr })
  local attached = vim.tbl_filter(function(c) return c.attached_buffers[bufnr] end, active)
  if #attached > 0 then return end

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
    command = function(args) api.nvim_clear_autocmds({ group = get_augroup(args.buf), buffer = args.buf }) end,
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
