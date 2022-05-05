vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection

vim.g.mapleader = ' ' -- Remap leader key

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
