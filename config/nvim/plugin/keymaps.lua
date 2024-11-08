local api = vim.api

local recursive_map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  map(mode, lhs, rhs, opts)
end

local imap = function(...) recursive_map('i', ...) end
local noremap = function(...) map({ 'n', 'x', 'o' }, ...) end
local nnoremap = function(...) map('n', ...) end
local vnoremap = function(...) map('x', ...) end
local inoremap = function(...) map('i', ...) end
local cnoremap = function(...) map('c', ...) end
local tnoremap = function(...) map('t', ...) end
local snoremap = function(...) map('s', ...) end

-- Terminal
as.augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  pattern = { 'term://*' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      local opts = { silent = false, buffer = 0 }
      tnoremap('jk', [[<C-\><C-n>]], opts)
      tnoremap('<c-=>', '<Cmd>res +1<CR>', opts)
      tnoremap('<c-->', '<Cmd>res -1<CR>', opts)
    end
  end,
})

-- motions
noremap('<c-j>', '5j')
noremap('<c-k>', '5k')
noremap('<c-h>', '^')
noremap('<c-l>', 'g_')
inoremap('<c-h>', '<Left>')
inoremap('<c-l>', '<Right>')
snoremap('<c-e>', '<esc>A')
noremap('r', '%')

-- basic
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'i', 's' }, 'jk', [[col('.') == 1 ? '<esc>' : '<esc>l']], { expr = true })
snoremap('<space>', '<space><bs>')
nnoremap(';', ':', { silent = false })
nnoremap('<c-q>', '<Cmd>q<cr>')
nnoremap('<c-s>', '<Cmd>w!<cr>')
nnoremap('<c-i>', '<c-i>')
nnoremap('dw', 'diw')
nnoremap('cw', 'ciw')
nnoremap('yw', 'yiw')
nnoremap('vw', 'viw')
nnoremap("c'", "ci'")
nnoremap('yp', ":let @+=expand('%:p')<CR>", { desc = 'yank file path' })
nnoremap('vv', 'V')
nnoremap('V', 'v$')
vnoremap('Y', '"+y')
vnoremap('X', '"+x')
vnoremap('C', '"+c')
vnoremap('<tab>', 'r')
inoremap('<c-;>', '<Right>;<Left><Left>')
inoremap('<c-,>', '<Right>,<Left><Left>')
nnoremap([[<leader>"]], [[ciw"<c-r>""<esc>]])
nnoremap('<leader>`', [[ciw`<c-r>"`<esc>]])
nnoremap("<leader>'", [[ciw'<c-r>"'<esc>]])
nnoremap('<leader>)', [[ciw(<c-r>")<esc>]])
nnoremap('<leader>]', [[ciw[<c-r>"]<esc>]])
nnoremap('<leader>}', [[ciw{<c-r>"}<esc>]])
-- Evaluates whether there is a fold on the current line if so unfold it else return a normal space
nnoremap('<leader><space>', [[@=(foldlevel('.')?'za':"\<Space>")<CR>]], {
  desc = 'toggle fold under cursor',
})

-- search visual selection
vnoremap('//', [[y/<C-R>"<CR>]])
-- make . work with visually selected lines
vnoremap('.', ':norm.<CR>')

-- Smart mappings on the command line
cnoremap('w!!', [[w !sudo tee % >/dev/null]])

-- Conditionally modify character at end of line
local function modify_line_end_delimiter(character)
  local delimiters = { ',', ';', '.' }
  return function()
    local line = api.nvim_get_current_line()
    local last_char = line:sub(-1)
    if last_char == character then
      api.nvim_set_current_line(line:sub(1, #line - 1))
    elseif vim.tbl_contains(delimiters, last_char) then
      api.nvim_set_current_line(line:sub(1, #line - 1) .. character)
    else
      api.nvim_set_current_line(line .. character)
    end
  end
end

nnoremap('<leader>,', modify_line_end_delimiter(','), { desc = "add ',' to end of line" })
nnoremap('<leader>;', modify_line_end_delimiter(';'), { desc = "add ';' to end of line" })
nnoremap('<leader>.', modify_line_end_delimiter('.'), { desc = "add '.' to end of line" })

local function run()
  if vim.bo.filetype == 'markdown' then
    if require('peek').is_open() then
      vim.cmd('PeekClose')
    else
      vim.cmd('PeekOpen')
    end
  end
  if vim.bo.filetype == 'typst' then vim.cmd('TypstPreview') end
end
nnoremap('<leader><cr>', run)

-- buffer
nnoremap('t', '<cmd>e #<cr>', { desc = 'switch to last buffer' })
nnoremap('H', '<cmd>bp <cr>')
nnoremap('L', '<cmd>bn <cr>')

-- Capitalize
nnoremap('U', 'gUiw`]', { desc = 'capitalize word' })

-- tabedit
nnoremap('<leader><tab>', 'gt')

-- window
nnoremap(',', '<C-w>w')
nnoremap('<c-=>', '<C-W>+')
nnoremap('<c-->', '<C-W>-')
nnoremap('<c-,>', '<C-W><')
nnoremap('<c-.>', '<C-W>>')
