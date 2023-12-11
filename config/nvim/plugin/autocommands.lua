-- last place
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line('$') then
      vim.cmd([[normal! g'"]])
    end
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
})

as.augroup('Utilities', {
  event = { 'FileType' },
  pattern = {
    -- 'lua',
    'NeogitCommitMessage',
    'zig',
  },
  -- NOTE: setting spell only works using opt_local otherwise it leaks into subsequent windows
  command = function() vim.opt_local.spell = true end,
})
