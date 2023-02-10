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

-- Global namespace
local namespace = {
  -- for UI elements like the winbar and statusline that need global references
  ui = {},
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = {},
}
_G.as = as or namespace

R('globals')
R('styles')
R('settings')
R('plugins')
