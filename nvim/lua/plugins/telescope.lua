local function b() return require('telescope.builtin') end
local function t() return require('telescope') end

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { 'ff', function() b().find_files() end, desc = 'find files' },
    { 'fo', '<cmd>Telescope oldfiles<cr>' },
    { 'fg', function() b().live_grep() end, desc = 'live grep' },
    { 'f;', function() b().commands() end, desc = 'commands' },
    { 'fc', function() b().command_history() end, desc = 'command_history' },
    { 'fd', function() b().buffers() end, desc = 'buffers' },
    { 'f/', function() b().help_tags() end, desc = 'help' },
    {
      'ft',
      function() b().lsp_dynamic_workspace_symbols() end,
      desc = 'workspace symbols',
    },
    { 'fa', function() b().lsp_document_symbols() end, desc = 'document symbols' },
    { 'fn', function() t().extensions.notify.notify() end, desc = 'notify' },
    { 'fk', function() b().keymaps() end, desc = 'keymaps' },
  },
  dependencies = {
    {
      'natecraddock/telescope-zf-native.nvim',
      config = function() require('telescope').load_extension('zf-native') end,
    },
    {
      'ilAYAli/scMRU.nvim',
      init = function()
        map('n', 'fr', '<Cmd>Mru<CR>', { desc = 'most recently used' })
        map('n', 'fu', '<Cmd>Mfu<CR>', { desc = 'most frequently used' })
      end,
    },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<c-c>'] = function() vim.cmd.stopinsert() end,
            ['<esc>'] = actions.close,
            ['<c-j>'] = actions.move_selection_next,
            ['<c-k>'] = actions.move_selection_previous,
            ['<c-n>'] = actions.cycle_history_next,
            ['<c-p>'] = actions.cycle_history_prev,
            ['<c-/>'] = actions.which_key,
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
          '^node_modules/',
          '^site-packages/',
          '^.yarn/',
        },
        path_display = { 'truncate' },
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.90,
          height = 0.90,
          preview_cutoff = 1, -- Preview should always show
          vertical = {
            mirror = true,
            prompt_position = 'top',
          },
          horizontal = {
            mirror = false,
            prompt_position = 'top',
          },
        },
      },
      extensions = {},
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
        live_grep = {
          file_ignore_patterns = { '.git/', '%.svg', '%.lock' },
          max_results = 2000,
        },
        colorscheme = {
          enable_preview = true,
        },
        find_files = {
          hidden = true,
        },
        keymaps = {
          layout_config = {
            height = 18,
          },
        },
        lsp_document_symbols = {
          previewer = false,
        },
      },
    })
  end,
}
