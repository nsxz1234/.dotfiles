local opt = vim.opt_local

opt.list = false
opt.spelllang = 'en_gb'
opt.colorcolumn = '50,72'

if vim.treesitter.language.register then
  vim.treesitter.language.register('gitcommit', 'NeogitCommitMessage')
end

if not as then return end
as.ftplugin_conf({
  cmp = function(cmp)
    cmp.setup.filetype('NeogitCommitMessage', {
      sources = cmp.config.sources({
        { name = 'git' },
        { name = 'luasnip' },
        { name = 'dictionary' },
        { name = 'spell' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
})
