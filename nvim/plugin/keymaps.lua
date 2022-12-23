local noisy = { silent = false }

local api = vim.api
local imap = as.imap
local noremap = as.noremap
local nnoremap = as.nnoremap
local vnoremap = as.vnoremap
local inoremap = as.inoremap
local snoremap = as.snoremap
local cnoremap = as.cnoremap
local tnoremap = as.tnoremap

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
inoremap('<c-h>', '<Left>')
inoremap('<Tab>', '<Right>')

-- basic
imap('jk', [[col('.') == 1 ? '<esc>' : '<esc>l']], { expr = true })
nnoremap(';', ':', noisy)
nnoremap('<c-q>', '<Cmd>q<cr>')
nnoremap('<c-s>', '<Cmd>w!<cr>')
nnoremap('<c-i>', '<c-i>')
nnoremap('dw', 'diw')
nnoremap('cw', 'ciw')
nnoremap('yw', 'yiw')
nnoremap('vw', 'viw')
nnoremap('yp', [[:let @+=expand("%:p")<CR>]], 'yank file path')
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
nnoremap('d<space>', ':BufferLinePickClose<cr>')
nnoremap('H', ':BufferLineCyclePrev<cr>')
nnoremap('L', ':BufferLineCycleNext<cr>')
nnoremap('<m-H>', ':BufferLineMovePrev<CR>')
nnoremap('<m-L>', ':BufferLineMoveNext<CR>')
nnoremap('t', '<c-^>')

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

-- Telescope
nnoremap('ff', ':Telescope find_files<cr>')
nnoremap('fo', ':Telescope oldfiles<cr>')
nnoremap('fg', ':Telescope live_grep<cr>')
nnoremap('fw', ':Telescope grep_string<cr>')
nnoremap('fh', ':Telescope search_history<cr>')
nnoremap('f;', ':Telescope commands<cr>')
nnoremap('fc', ':Telescope command_history<cr>')
nnoremap('fd', ':Telescope buffers<cr>')
nnoremap('f/', ':Telescope current_buffer_fuzzy_find<cr>')
nnoremap('f?', ':Telescope help_tags<cr>')
nnoremap('fm', ':Telescope marks<cr>')
nnoremap('ft', ':Telescope lsp_dynamic_workspace_symbols<cr>')
nnoremap('fa', ':Telescope lsp_document_symbols<cr>')
nnoremap('fn', ':Telescope notify<cr>')
nnoremap('fk', ':Telescope keymaps<cr>')

-- dap
nnoremap('<leader>b', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
nnoremap('<leader>1', '<cmd>lua require("dap").continue()<cr>')
nnoremap('<leader>2', '<cmd>lua require("dap").step_into()<cr>')
nnoremap('<leader>3', '<cmd>lua require("dap").step_over()<cr>')
nnoremap('<leader>4', '<cmd>lua require("dap").step_out()<cr>')
nnoremap('<leader>5', '<cmd>lua require("dap").repl.toggle()<cr>')
nnoremap('<leader>6', '<cmd>lua require("dap").run_last()<cr>')
-- dap-ui
nnoremap('<leader>d', '<cmd>lua require("dapui").toggle()<cr>')
