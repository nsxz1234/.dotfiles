vim.g.mapleader = ' ' -- Remap leader key

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...)
  return ...
end
function R(name)
  RELOAD(name)
  return require(name)
end

R 'globals'
R 'keymaps'
R 'plugins'

vim.cmd 'source $HOME/.config/nvim/config.vim'
