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
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      local actions = require('telescope.actions')

      require('telescope').setup({
        defaults = {
          borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          mappings = {
            i = {
              ['<c-c>'] = function() vim.cmd.stopinsert() end,
              ['<esc>'] = actions.close,
              ['<c-j>'] = actions.move_selection_next,
              ['<c-k>'] = actions.move_selection_previous,
              ['<c-n>'] = actions.cycle_history_next,
              ['<c-p>'] = actions.cycle_history_prev,
              ['?'] = actions.which_key,
              ['<Tab>'] = actions.toggle_selection,
            },
          },
          dynamic_preview_title = true,
          file_ignore_patterns = {
            '%.jpg',
            '%.jpeg',
            '%.png',
            '%.otf',
            '%.ttf',
            '%.DS_Store',
            '^.git/',
            'node%_modules/.*',
            '^site-packages/',
            '%.yarn/.*',
          },
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.90,
            height = 0.90,
            preview_cutoff = 1, -- Preview should always show
            vertical = { mirror = true, prompt_position = 'top' },
            horizontal = { mirror = false, prompt_position = 'top' },
          },
        },
        pickers = {
          buffers = {
            sort_mru = true,
            sort_lastused = true,
            show_all_buffers = true,
            ignore_current_buffer = true,
            previewer = false,
            mappings = {
              i = { ['<c-x>'] = 'delete_buffer' },
              n = { ['<c-x>'] = 'delete_buffer' },
            },
          },
          lsp_document_symbols = { previewer = false },
        },
      })
    end,
    dependencies = {
      {
        'ilAYAli/scMRU.nvim',
        dependencies = 'kkharji/sqlite.lua',
        keys = {
          { 'fr', '<cmd>lua require("mru").display_cache({})<CR>', desc = 'most recently used' },
        },
      },
    },
  },
}
