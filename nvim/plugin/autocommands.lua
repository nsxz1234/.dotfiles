-- last edit position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*' },
  callback = function()
    if vim.fn.line('\'"') > 1 and vim.fn.line('\'"') <= vim.fn.line('$') then
      vim.api.nvim_exec('normal! g\'"', false)
    end
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

as.augroup('Utilities', {
  {
    event = { 'FileType' },
    pattern = {
      'lua',
      'vim',
      'dart',
      'python',
      'javascript',
      'typescript',
      'rust',
      'org',
      'NeogitCommitMessage',
      'go',
      'markdown',
      'zig',
    },
    -- FIXME: spellsitter is slow in large files
    -- TODO: should this be done in ftplugin files
    -- NOTE: setting spell only works using opt_local otherwise it leaks into subsequent windows
    command = function(args) vim.opt_local.spell = vim.api.nvim_buf_line_count(args.buf) < 8000 end,
  },
})
