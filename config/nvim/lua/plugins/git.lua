return {
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', function() require('neogit').open() end, desc = 'open status buffer' },
    },
    opts = {
      disable_signs = false,
      disable_hint = true,
      disable_commit_confirmation = true,
      disable_builtin_notifications = true,
      disable_insert_on_commit = false,
      signs = { section = { '▸', '▾' }, item = { '▸', '▾' } },
      integrations = {
        diffview = true,
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<Cmd>DiffviewOpen<CR>', desc = 'diffview: open', mode = 'n' },
      {
        '<leader>gh',
        '<Cmd>DiffviewFileHistory<CR>',
        desc = 'diffview: file history',
        mode = 'n',
      },
      {
        '<leader>gh',
        [[:'<'>DiffviewFileHistory<CR>]],
        desc = 'diffview: file history',
        mode = 'x',
      },
    },
    opts = {
      default_args = { DiffviewFileHistory = { '%' } },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function() vim.wo.wrap = false end,
      },
      file_history_panel = {
        win_config = {
          height = 12,
        },
      },
      keymaps = {
        view = { q = '<Cmd>DiffviewClose<CR>' },
        file_panel = { q = '<Cmd>DiffviewClose<CR>' },
        file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        changedelete = { text = '~' },
        untracked = { text = '░' },
      },
      _inline2 = false,
      on_attach = function()
        local gs = package.loaded.gitsigns

        map('n', '<leader>gs', gs.stage_hunk, { desc = 'stage current hunk' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo stage' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'reset current hunk' })
        map('n', '<leader>gp', gs.preview_hunk_inline, { desc = 'preview current hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'gitsigns: stage entire buffer' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'gitsigns: reset entire buffer' })
        map('n', '<leader>gP', gs.toggle_deleted, { desc = 'show deleted lines' })
        map('n', '<leader>gb', gs.blame_line, { desc = 'blame current hunk' })
        map('n', '<leader>gw', gs.toggle_word_diff, { desc = 'gitsigns: toggle word diff' })
        map(
          'n',
          '<leader>lg',
          function() gs.setqflist('all') end,
          { desc = 'list modified in quickfix' }
        )
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

        map(
          'x',
          '<leader>gs',
          function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
        )
        map('x', '<leader>gr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)

        map('n', '[h', function()
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignor>'
        end, { expr = true, desc = 'go to previous git hunk' })

        map('n', ']h', function()
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'go to next git hunk' })
      end,
    },
  },
  {
    'akinsho/git-conflict.nvim',
    event = 'VeryLazy',
    opts = {
      default_mappings = true,
      disable_diagnostics = true,
    },
    keys = {
      { '<leader>co', '<Plug>(git-conflict-ours)' },
      { '<leader>cb', '<Plug>(git-conflict-both)' },
      { '<leader>cn', '<Plug>(git-conflict-none)' },
      { '<leader>ct', '<Plug>(git-conflict-theirs)' },
      { ']c', '<Plug>(git-conflict-next-conflict)' },
      { '[c', '<Plug>(git-conflict-prev-conflict)' },
    },
  },
}
