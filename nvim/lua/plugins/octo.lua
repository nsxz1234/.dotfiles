return function()
  require('octo').setup()
  require('which-key').register({
    oi = { '<Cmd>Octo issue list<CR>', 'issues' },
    op = { '<Cmd>Octo pr list<CR>', 'pull requests' },
  }, { prefix = '<leader>' })

  as.augroup('OctoFT', {
    {
      event = 'FileType',
      pattern = 'octo',
      command = function()
        -- require('as.highlights').clear_hl 'OctoEditable'
        as.nnoremap('q', '<Cmd>Bwipeout<CR>', { buffer = 0 })
      end,
    },
  })
end
