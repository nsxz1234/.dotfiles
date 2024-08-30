local o, opt = vim.o, vim.opt

o.bg = 'dark'

opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  S = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}

-- Timings
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10

-- Window
-- bqf cursor position issue
-- o.splitkeep = 'screen'
o.splitbelow = true
o.splitright = true
o.switchbuf = 'useopen,uselast'
opt.fillchars = {
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '╱', -- alternatives = ⣿ ░ ─
  msgsep = ' ', -- alternatives: ‾ ─
  fold = ' ',
  foldopen = '▾',
  foldsep = ' ',
  foldclose = '▸',
}

-- Diff
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }

-- Format
opt.formatoptions = {
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

-- Fold
-- o.foldenable = false
-- o.foldcolumn = '0' -- '0' is not bad
-- o.foldlevel = 99
o.foldlevelstart = 999

-- Grep
-- Use faster grep alternatives if possible
if as and not as.falsy(vim.fn.executable('rg')) then
  vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
  opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
elseif as and not as.falsy(vim.fn.executable('ag')) then
  vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
  opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
end

-- Wild and file globbing stuff in command mode
o.wildcharm = ('\t'):byte()
o.wildmode = 'list:full' -- Shows a menu bar as opposed to an enormous list
o.wildignorecase = true -- Ignore case when completing file names and directories
opt.wildignore = {
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
  '*.swp',
  '.lock',
  '.DS_Store',
  'tags.lock',
}
opt.wildoptions = 'pum'

-- Display
o.breakindentopt = 'sbr'
o.linebreak = false
o.signcolumn = 'yes'
o.cursorline = true
o.ruler = false
o.cmdheight = 0
o.showbreak = '↪ '

-- List
o.list = true -- invisible chars
opt.listchars = {
  eol = nil,
  tab = '  ', -- Alternatives: '▷▷',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- Indentation
o.shiftround = true
o.expandtab = true
o.shiftwidth = 2

o.pumheight = 15
o.confirm = true
opt.completeopt = { 'menuone', 'noselect' }
o.hlsearch = true
o.autowriteall = true
o.laststatus = 3 -- 全局状态栏
o.termguicolors = true
o.emoji = false

-- GUI settings
o.guifont = 'FantasqueSansM Nerd Font:h18'
o.linespace = 4
-----------------------------------------------------------------------------//
-- Jumplist
-----------------------------------------------------------------------------//
opt.jumpoptions = { 'stack' } -- make the jumplist behave like a browser stack

-- Backup and swap
o.undofile = true
o.swapfile = false

-- Match and search
o.ic = true
o.smartcase = true
o.scrolloff = 8

-- Mouse
o.mousefocus = true
opt.mousescroll = { 'ver:2', 'hor:6' }

-- Spelling
opt.spellsuggest:prepend({ 12 })
opt.spelloptions:append({ 'camel', 'noplainbuffer' })
opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
