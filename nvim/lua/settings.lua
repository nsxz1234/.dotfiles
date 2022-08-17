local opt, fn = vim.opt, vim.fn

opt.shortmess = {
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

-- Timings
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 10

-- Window
opt.splitbelow = true
opt.splitright = true
opt.switchbuf = 'useopen,uselast'
opt.fillchars = {
  fold = ' ',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '╱', -- alternatives = ⣿ ░ ─
  msgsep = ' ', -- alternatives: ‾ ─
  foldopen = '▾',
  foldsep = '│',
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
opt.foldenable = false
opt.foldlevelstart = 2
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldmethod = 'expr'

-- Grep
-- Use faster grep alternatives if possible
if as.executable('rg') then
  vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
  opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
elseif as.executable('ag') then
  vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
  opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
end

-- Wild and file globbing stuff in command mode
opt.wildcharm = ('\t'):byte()
opt.wildmode = 'longest:full,full' -- Shows a menu bar as opposed to an enormous list
opt.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
opt.wildignore = {
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
opt.wildoptions = 'pum'

-- Display
opt.breakindentopt = 'sbr'
opt.linebreak = true
opt.signcolumn = 'number'
opt.ruler = false
opt.showbreak = [[↪ ]]

-- List
opt.list = true -- invisible chars
opt.listchars = {
  eol = nil,
  tab = '  ', -- Alternatives: '▷▷',
  extends = '»', -- Alternatives: … ›
  precedes = '«', -- Alternatives: … ‹
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- Indentation
opt.shiftround = true
opt.expandtab = true
opt.shiftwidth = 2

opt.gdefault = true
opt.pumheight = 15
opt.confirm = true
opt.completeopt = { 'menuone', 'noselect' }
opt.hlsearch = true
opt.autowriteall = true
opt.laststatus = 3 -- 全局状态栏
opt.termguicolors = true
opt.guifont = 'FantasqueSansMono Nerd Font:h16'
opt.emoji = false
opt.number = true
opt.cursorline = true
-----------------------------------------------------------------------------//
-- Jumplist
-----------------------------------------------------------------------------//
opt.jumpoptions = { 'stack' } -- make the jumplist behave like a browser stack

-- Backup and swap
opt.undofile = true
opt.swapfile = false

-- Match and search
opt.ic = true
opt.smartcase = true
opt.scrolloff = 9

-- Mouse
opt.mousefocus = true
opt.mousescroll = { 'ver:2', 'hor:6' }

-- Spelling
opt.spell = false
opt.spellsuggest:prepend({ 12 })
opt.spelloptions = 'camel'
opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
opt.fileformats = { 'unix', 'mac', 'dos' }
opt.spelllang:append('programming')

-- Color Scheme
if as.plugin_installed('everforest') then
  vim.g.everforest_background = 'soft'
  vim.cmd.colorscheme('everforest')
end
-- if as.plugin_installed('gruvbox-material') then
--   vim.g.gruvbox_material_background = 'soft'
--   vim.cmd.colorscheme('gruvbox-material')
-- end
