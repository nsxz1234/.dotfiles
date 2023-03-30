local fn, opt = vim.fn, vim.opt

vim.g.mapleader = ' ' -- Remap leader key
vim.g.maplocalleader = ',' -- Remap local leader key
-- Global namespace
local namespace = {
  -- for UI elements like the winbar and statusline that need global references
  ui = {},
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = {},
}
_G.as = as or namespace

_G.map = vim.keymap.set
_G.P = vim.print

-- Settings

require('globals')
require('ui')
require('settings')

-- Plugins

local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- If opening from inside neovim terminal then do not load other plugins
if vim.env.NVIM then
  return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } })
end

require('lazy').setup('plugins', {
  defaults = {},
  change_detection = { notify = false },
  rtp = {
    disabled_plugins = { 'netrw', 'netrwPlugin' },
  },
})
-- Lazy
map('n', '<leader>p', '<cmd>Lazy<cr>')
