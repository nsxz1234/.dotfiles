local fzf_lua = as.reqcall('fzf-lua')

local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'AckslD/nvim-neoclip.lua',
      opts = {
        keys = {
          fzf = {
            paste_behind = 'default',
          },
        },
      },
      keys = { { 'fy', function() require('neoclip.fzf')() end } },
    },
  },
  keys = {
    { 'ff', file_picker, desc = 'find files' },
    { 'fd', fzf_lua.oldfiles, desc = 'Most recently used files' },
    { 'fg', fzf_lua.live_grep, desc = 'live grep' },
    { 'fc', fzf_lua.commands, desc = 'commands' },
    { 'fh', fzf_lua.git_bcommits, desc = 'buffer commits' },
    { 'f?', fzf_lua.help_tags, desc = 'help' },
    { 'ft', fzf_lua.lsp_live_workspace_symbols, desc = 'workspace symbols' },
    { 'fs', fzf_lua.lsp_document_symbols, desc = 'document symbols' },
    { 'fb', fzf_lua.grep_curbuf, desc = 'current buffer fuzzy find' },
    { 'fk', fzf_lua.keymaps, desc = 'keymaps' },
    { 'fm', fzf_lua.marks, desc = 'marks' },
  },
  config = function()
    local lsp_kind = require('lspkind')

    require('fzf-lua').setup({
      fzf_opts = {
        ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-history',
      },
      winopts = {
        border = as.ui.border.rectangle,
        height = 0.90,
        width = 0.90,
        preview = { layout = 'vertical', vertical = 'down:50%' },
      },
      keymap = {
        builtin = {
          ['?'] = 'toggle-help',
          ['<c-f>'] = 'preview-page-down',
          ['<c-b>'] = 'preview-page-up',
        },
      },
      oldfiles = {
        cwd_only = false,
        include_current_session = true,
      },
      grep = {
        rg_opts = '--column --hidden --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
      },
      lsp = {
        symbols = {
          winopts = { preview = { hidden = 'hidden' } },
          symbol_icons = lsp_kind.symbols,
        },
      },
    })
  end,
}
