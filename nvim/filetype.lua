if not vim.filetype then return end

vim.filetype.add({
  extension = {
    lock = 'yaml',
  },
  filename = {
    ['NEOGIT_COMMIT_EDITMSG'] = 'NeogitCommitMessage',
    ['.gitignore'] = 'conf',
    ['launch.json'] = 'jsonc',
  },
  pattern = {
    ['.*%.conf'] = 'conf',
    ['.*%.theme'] = 'conf',
    ['.*%.gradle'] = 'groovy',
    ['.*%.env%..*'] = 'env',
  },
})
