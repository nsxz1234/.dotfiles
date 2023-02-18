local opt = vim.opt_local

opt.list = false
opt.spelllang = 'en_gb'
opt.colorcolumn = '50,72'

as.ftplugin_conf('nvim-treesitter.parsers', function(parsers)
  -- make sure neogit commits use the treesitter parser
  parsers.filetype_to_parsername['NeogitCommitMessage'] = 'gitcommit'
end)

if not as then return end
as.ftplugin_conf(
  'cmp',
  function(cmp)
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
  end
)
