local function command(c) return ('<cmd>FzfLua %s<CR>'):format(c) end

local file_picker = function(cwd) require('fzf-lua').files({ cwd = cwd }) end

local function git_files_cwd_aware(opts)
  opts = opts or {}
  local fzf_lua = require('fzf-lua')
  -- git_root() will warn us if we're not inside a git repo
  -- so we don't have to add another warning here, if
  -- you want to avoid the error message change it to:
  -- local git_root = fzf_lua.path.git_root(opts, true)
  local git_root = fzf_lua.path.git_root(opts)
  if not git_root then return fzf_lua.files(opts) end
  local relative = fzf_lua.path.relative(vim.loop.cwd(), git_root)
  opts.fzf_opts = { ['--query'] = git_root ~= relative and relative or nil }
  return fzf_lua.git_files(opts)
end

return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'AckslD/nvim-neoclip.lua',
        opts = {},
        keys = { { 'fp', function() require('neoclip.fzf')() end } },
      },
    },
    keys = {
      { '<c-p>', git_files_cwd_aware, desc = 'find files' },
      { 'ff', file_picker, desc = 'find files' },
      { 'fg', command('live_grep'), desc = 'live grep' },
      { 'fo', command('oldfiles'), desc = 'Most recently used files' },
      { 'f;', command('commands'), desc = 'commands' },
      { 'fc', command('command_history'), desc = 'command history' },
      { 'fh', command('git_bcommits'), desc = 'buffer commits' },
      { 'fd', command('buffers'), desc = 'buffers' },
      { 'f/', command('help_tags'), desc = 'help' },
      { 'ft', command('lsp_live_workspace_symbols'), desc = 'workspace symbols' },
      { 'fa', command('lsp_document_symbols'), desc = 'document symbols' },
      { 'fk', command('keymaps'), desc = 'keymaps' },
    },
    config = function()
      require('fzf-lua').setup({
        fzf_opts = {
          ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-history',
        },
        winopts = {
          height = 0.90,
          width = 0.90,
          preview = { layout = 'vertical', vertical = 'down:60%' },
        },
        border = as.ui.border.rectangle,
        keymap = {
          builtin = {
            ['?'] = 'toggle-help',
          },
        },
        oldfiles = {
          cwd_only = true,
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
    end,
    dependencies = {
      {
        'ilAYAli/scMRU.nvim',
        keys = {
          { 'fr', '<Cmd>Mru<CR>', desc = 'most recently used' },
        },
      },
    },
  },
}
