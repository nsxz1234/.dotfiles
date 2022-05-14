vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection

-- Stop loading built in plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1

vim.g.mapleader = ' ' -- Remap leader key
vim.g.maplocalleader = ',' -- Remap local leader key

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...)
  return ...
end
function R(name)
  RELOAD(name)
  return require(name)
end

R('globals')
R('styles')
R('settings')
R('init')

vim.cmd('source $HOME/.config/nvim/config.vim')
