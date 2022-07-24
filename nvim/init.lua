-- Ensure all autocommands are cleared
vim.api.nvim_create_augroup('vimrc', {})

vim.g.mapleader = ' ' -- Remap leader key
vim.g.maplocalleader = ',' -- Remap local leader key

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...) return ... end
function R(name)
  RELOAD(name)
  return require(name)
end

R('globals')
R('styles')
R('settings')
R('init')
