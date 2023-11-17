local fzf_lua = as.reqcall('fzf-lua')

local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'AckslD/nvim-neoclip.lua',
        opts = {},
        keys = { { 'fy', function() require('neoclip.fzf')() end } },
      },
    },
    keys = {
      { 'ff', file_picker, desc = 'find files' },
      { 'fo', fzf_lua.oldfiles, desc = 'Most recently used files' },
      { 'fd', fzf_lua.buffers, desc = 'buffers' },
      { 'fg', fzf_lua.live_grep, desc = 'live grep' },
      { 'f;', fzf_lua.commands, desc = 'commands' },
      { 'fc', fzf_lua.command_history, desc = 'command history' },
      { 'fh', fzf_lua.git_bcommits, desc = 'buffer commits' },
      { 'f/', fzf_lua.help_tags, desc = 'help' },
      { 'ft', fzf_lua.lsp_live_workspace_symbols, desc = 'workspace symbols' },
      { 'fa', fzf_lua.lsp_document_symbols, desc = 'document symbols' },
      { 'fb', fzf_lua.grep_curbuf, desc = 'current buffer fuzzy find' },
      { 'fk', fzf_lua.keymaps, desc = 'keymaps' },
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
          preview = { layout = 'vertical', vertical = 'down:60%' },
        },
        keymap = {
          builtin = {
            ['?'] = 'toggle-help',
            ['<c-f>'] = 'preview-page-down',
            ['<c-b>'] = 'preview-page-up',
          },
        },
        oldfiles = {
          cwd_only = true,
        },
        lsp = {
          symbols = {
            winopts = { preview = { hidden = 'hidden' } },
            symbol_icons = lsp_kind.symbols,
          },
        },
      })
    end,
  },
}
