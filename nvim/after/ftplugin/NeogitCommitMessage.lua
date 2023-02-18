vim.opt_local.list = false
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.bo.spelllang = 'en_gb'
--  Set color column at maximum commit summary length
vim.opt_local.colorcolumn = '50,72'

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
