return function()
  require('gitsigns').setup({
    _threaded_diff = true, -- NOTE: experimental but I'm curious
    word_diff = false,
    numhl = false,
    on_attach = function()
      local gs = package.loaded.gitsigns

      local function qf_list_modified()
        gs.setqflist('all')
      end
      require('which-key').register({
        ['<leader>h'] = {
          name = '+gitsigns hunk',
          ['<space>'] = { gs.stage_hunk, 'stage' },
          u = { gs.undo_stage_hunk, 'undo stage' },
          r = { gs.reset_hunk, 'reset hunk' },
          p = { gs.preview_hunk, 'preview current hunk' },
          b = 'blame current line',
        },
        ['<leader>g'] = {
          name = '+git',
          ['<space>'] = { gs.stage_buffer, 'gitsigns: stage entire buffer' },
          r = { gs.reset_buffer, 'gitsigns: reset entire buffer' },
          b = { gs.blame_line, 'gitsigns: blame current line' },
          w = { gs.toggle_word_diff, 'gitsigns: toggle word diff' },
        },
        ['[h'] = 'go to previous git hunk',
        [']h'] = 'go to next git hunk',
        ['<leader>gq'] = { qf_list_modified, 'gitsigns: list modified in quickfix' },
      })

      -- Navigation
      as.nnoremap('[h', function()
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      as.nnoremap(']h', function()
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      vim.keymap.set('v', '<leader>h<space>', function()
        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)
      vim.keymap.set('v', '<leader>hr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      vim.keymap.set({ 'n' }, '<leader>h<space>', '<cmd>Gitsigns stage_hunk<CR>')
      vim.keymap.set({ 'n' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
    end,
  })
end
