return function()
  require('gitsigns').setup({
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
    _threaded_diff = true, -- NOTE: experimental but I'm curious
    word_diff = false,
    numhl = false,
    on_attach = function()
      local gs = package.loaded.gitsigns

      local function qf_list_modified() gs.setqflist('all') end

      as.nnoremap('<leader>hu', gs.undo_stage_hunk, 'undo stage')
      as.nnoremap('<leader>hp', gs.preview_hunk, 'preview current hunk')
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
end
