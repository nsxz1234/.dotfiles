local fn = vim.fn

vim.opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}
--
-- Timings
--
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
--
-- Window
--
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = 'useopen,uselast'
--
-- Diff
--
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
vim.opt.diffopt = vim.opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }
--
-- Format
--
vim.opt.formatoptions = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq"
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}
--
-- Fold
--
-- vim.opt.foldopen = vim.opt.foldopen + 'search'
-- vim.opt.foldlevelstart = 3
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldmethod = 'expr'
--
-- Grep
--
-- Use faster grep alternatives if possible
if as.executable 'rg' then
  vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
  vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
elseif as.executable 'ag' then
  vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
  vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end
--
-- Wild and file globbing stuff in command mode
--
vim.opt.wildcharm = fn.char2nr(as.replace_termcodes [[<Tab>]])
vim.opt.wildmode = 'longest:full,full' -- Shows a menu bar as opposed to an enormous list
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
vim.opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '.DS_Store',
  'tags.lock',
}
vim.opt.wildoptions = 'pum'
--
-- Display
--
vim.opt.breakindentopt = 'sbr'
vim.opt.linebreak = true
vim.opt.signcolumn = 'number'
vim.opt.ruler = false
vim.opt.showbreak = [[↪ ]]
--
-- List
--
vim.opt.list = true -- invisible chars
vim.opt.listchars = {
  eol = nil,
  tab = '  ', -- Alternatives: '▷▷',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}
--
-- Indentation
--
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.gdefault = true
vim.opt.pumheight = 15
vim.opt.confirm = true
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.hlsearch = true
vim.opt.autowriteall = true
vim.opt.clipboard = { 'unnamedplus' }
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.guifont = 'FantasqueSansMono Nerd Font:h16'
vim.opt.emoji = false
vim.opt.cursorlineopt = 'screenline,number'
--
-- Backup and swap
--
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
--
-- Match and search
--
vim.opt.ic = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 9
--
-- Mouse
--
vim.opt.mouse = 'a'
vim.opt.mousefocus = true
-----------------------------------------------------------------------------//
-- Spelling {{{1
-----------------------------------------------------------------------------//
vim.opt.spell = true
vim.opt.spellsuggest:prepend { 12 }
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
vim.opt.fileformats = { 'unix', 'mac', 'dos' }
vim.opt.spelllang:append 'programming'
