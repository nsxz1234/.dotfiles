return {
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    keys = { '<leader>gs' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local neogit = require('neogit')
      neogit.setup({
        disable_signs = false,
        disable_hint = true,
        disable_commit_confirmation = true,
        disable_builtin_notifications = true,
        disable_insert_on_commit = false,
        signs = {
          section = { '', '' }, -- "", ""
          item = { '▸', '▾' },
          hunk = { '樂', '' },
        },
        integrations = {
          diffview = true,
        },
      })
      as.nnoremap('<leader>gs', function() neogit.open() end, 'neogit: open status buffer')
    end,
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
    config = function()
      require('diffview').setup({
        default_args = {
          DiffviewFileHistory = { '%' },
        },
        hooks = {
          diff_buf_read = function() vim.wo.wrap = false end,
        },
        enhanced_diff_hl = true,
        keymaps = {
          view = { q = '<Cmd>DiffviewClose<CR>' },
          file_panel = { q = '<Cmd>DiffviewClose<CR>' },
          file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitsigns').setup({
        _threaded_diff = true,
        _extmark_signs = true,
        _signs_staged_enable = true,
        signs = {
          add = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
          },
          change = {
            hl = 'GitSignsChange',
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
          delete = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
        },
        word_diff = false,
        numhl = false,
        on_attach = function()
          local gs = package.loaded.gitsigns

          local function qf_list_modified() gs.setqflist('all') end

          as.nnoremap('<leader>hu', gs.undo_stage_hunk, 'undo stage')
          as.nnoremap('<leader>hp', gs.preview_hunk_inline, 'preview current hunk')
          as.nnoremap('<leader>h<space>', gs.stage_hunk, 'stage current hunk')
          as.nnoremap('<leader>hr', gs.reset_hunk, 'reset current hunk')
          as.nnoremap('<leader>hb', gs.blame_line, 'blame current hunk')
          as.nnoremap('<leader>hd', gs.toggle_deleted, 'show deleted lines')
          as.nnoremap('<leader>gw', gs.toggle_word_diff, 'gitsigns: toggle word diff')
          as.nnoremap('<leader>g<space>', gs.stage_buffer, 'gitsigns: stage entire buffer')
          as.nnoremap('<leader>gr', gs.reset_buffer, 'gitsigns: reset entire buffer')
          as.nnoremap('gq', qf_list_modified, 'gitsigns: list modified in quickfix')

          -- Navigation
          as.nnoremap('[h', function()
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignor>'
          end, { expr = true, desc = 'go to previous git hunk' })

          as.nnoremap(']h', function()
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'go to next git hunk' })

          as.xnoremap(
            '<leader>h<space>',
            function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
          )
          as.xnoremap(
            '<leader>hr',
            function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
          )

          vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      })
    end,
  },
}
