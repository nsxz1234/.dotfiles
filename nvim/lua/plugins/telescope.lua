local function b() return require('telescope.builtin') end

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { 'ff', function() require('telescope').extensions.menufacture.find_files() end },
    { 'fg', function() require('telescope').extensions.menufacture.live_grep() end },
    { 'fo', function() b().oldfiles() end },
    { 'f;', function() b().commands() end },
    { 'fc', function() b().command_history() end },
    { 'fd', function() b().buffers() end },
    { 'f/', function() b().help_tags() end },
    { 'ft', function() b().lsp_dynamic_workspace_symbols() end },
    { 'fa', function() b().lsp_document_symbols() end },
    { 'fn', function() require('telescope').extensions.notify.notify() end },
    { 'fk', function() b().keymaps() end },
  },
  dependencies = {
    {
      'ilAYAli/scMRU.nvim',
      keys = {
        { 'fr', '<Cmd>Mru<CR>', desc = 'most recently used' },
        { 'fu', '<Cmd>Mfu<CR>', desc = 'most frequently used' },
      },
    },
    { 'molecule-man/telescope-menufacture' },
    { 'natecraddock/telescope-zf-native.nvim' },
  },
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
      extensions = {
        ['zf-native'] = {
          generic = { enable = true, match_filename = true },
        },
      },
      pickers = {
        buffers = {
          initial_mode = 'normal',
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
        colorscheme = { enable_preview = true },
        find_files = { hidden = true },
        keymaps = { layout_config = { height = 18 } },
        lsp_document_symbols = { previewer = false },
      },
    })

    -- Extensions (sometimes need to be explicitly loaded after telescope is setup)
    require('telescope').load_extension('menufacture')
    require('telescope').load_extension('zf-native')
  end,
}
