local api = vim.api

local recursive_map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  map(mode, lhs, rhs, opts)
end

local imap = function(...) recursive_map('i', ...) end
local noremap = function(...) map('', ...) end
local nnoremap = function(...) map('n', ...) end
local vnoremap = function(...) map('v', ...) end
local inoremap = function(...) map('i', ...) end
local cnoremap = function(...) map('c', ...) end
local tnoremap = function(...) map('t', ...) end
local snoremap = function(...) map('s', ...) end

-- Terminal
as.augroup('AddTerminalMappings', {
  {
    event = { 'TermOpen' },
    pattern = { 'term://*' },
    command = function()
      if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
        local opts = { silent = false, buffer = 0 }
        tnoremap('jk', [[<C-\><C-n>]], opts)
        tnoremap('<a-=>', '<Cmd>res +1<CR>', opts)
        tnoremap('<a-->', '<Cmd>res -1<CR>', opts)
      end
    end,
  },
})

-- motions
vnoremap('$', 'g_')
noremap('<c-j>', '5j')
noremap('<c-k>', '5k')
noremap('<c-h>', '^')
noremap('<c-l>', 'g_')
inoremap('<c-l>', '<End>')
snoremap('<c-l>', '<esc>A')
snoremap('<space>', '<esc>ea')
-- inoremap('<c-h>', '<Left>')
inoremap('<Tab>', '<Right>')

-- basic
imap('jk', [[col('.') == 1 ? '<esc>' : '<esc>l']], { expr = true })
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
inoremap(';;', '<Right>;<Left><Left>')
inoremap(',,', '<Right>,<Left><Left>')
nnoremap([[<leader>"]], [[ciw"<c-r>""<esc>]])
nnoremap('<leader>`', [[ciw`<c-r>"`<esc>]])
nnoremap("<leader>'", [[ciw'<c-r>"'<esc>]])
nnoremap('<leader>)', [[ciw(<c-r>")<esc>]])
nnoremap('<leader>]', [[ciw[<c-r>"]<esc>]])
nnoremap('<leader>}', [[ciw{<c-r>"}<esc>]])
-- Capitalize
nnoremap('U', 'gUiw`]')
-- Evaluates whether there is a fold on the current line if so unfold it else return a normal space
nnoremap('<leader><space>', [[@=(foldlevel('.')?'za':"\<Space>")<CR>]])

-- search visual selection
vnoremap('//', [[y/<C-R>"<CR>]])
-- find visually selected text
vnoremap('*', [[y/<C-R>"<CR>]])
-- make . work with visually selected lines
vnoremap('.', ':norm.<CR>')

-- Smart mappings on the command line
cnoremap('w!!', [[w !sudo tee % >/dev/null]])

-- Conditionally modify character at end of line
local function modify_line_end_delimiter(character)
  local delimiters = { ',', ';' }
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

nnoremap('<leader>,', modify_line_end_delimiter(','))
nnoremap('<leader>;', modify_line_end_delimiter(';'))

local function run()
  if vim.bo.filetype == 'markdown' then vim.cmd('MarkdownPreviewToggle') end
end

nnoremap('<leader><cr>', run)

-- buffer
map('n', 't', '<c-^>')

-- tabedit
nnoremap('<leader><tab>', 'gt')

-- window
nnoremap(',', '<C-w>w')
nnoremap('<m-h>', '<C-w>h')
nnoremap('<m-j>', '<C-w>j')
nnoremap('<m-k>', '<C-w>k')
nnoremap('<m-l>', '<C-w>l')
nnoremap('<up>', ':res +1<cr>')
nnoremap('<down>', ':res -1<cr>')
nnoremap('<a-=>', '<C-W>+')
nnoremap('<a-->', '<C-W>-')
nnoremap('<a-,>', '<C-W><')
nnoremap('<a-.>', '<C-W>>')

-- hlslens
nnoremap(
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]
)
nnoremap(
  'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]
)
nnoremap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
nnoremap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
