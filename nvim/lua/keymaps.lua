local noisy = { silent = false }

local api = vim.api
local imap = as.imap
local noremap = as.noremap
local nnoremap = as.nnoremap
local xnoremap = as.xnoremap
local vnoremap = as.vnoremap
local inoremap = as.inoremap
local snoremap = as.snoremap
local cnoremap = as.cnoremap
local tnoremap = as.tnoremap

-- motions
vnoremap('$', 'g_')
noremap('<c-j>', '5j')
noremap('<c-k>', '5k')
noremap('<c-h>', '^')
noremap('<c-l>', 'g_')
inoremap('<c-l>', '<esc>A')
snoremap('<c-l>', '<esc>A')
inoremap('<c-j>', '<Left>')
inoremap('<c-k>', '<Right>')

-- basic
imap('jk', [[col('.') == 1 ? '<esc>' : '<esc>l']], { expr = true })
nnoremap(';', ':', noisy)
nnoremap('<c-q>', ':q<cr>')
nnoremap('<c-s>', ':w!<cr>')
tnoremap(',,', '<C-\\><C-n>')
nnoremap('dw', 'diw')
nnoremap('cw', 'ciw')
nnoremap('yw', 'yiw')
nnoremap('vw', 'viw')
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
-- Paste in visual mode multiple times
xnoremap('p', 'pgvy')
-- Evaluates whether there is a fold on the current line if so unfold it else return a normal space
nnoremap('<space><space>', [[@=(foldlevel('.')?'za':"\<Space>")<CR>]])

-- search visual selection
vnoremap('//', [[y/<C-R>"<CR>]])
-- find visually selected text
vnoremap('*', [[y/<C-R>"<CR>]])
-- make . work with visually selected lines
vnoremap('.', ':norm.<CR>')

-- Smart mappings on the command line
cnoremap('w!!', [[w !sudo tee % >/dev/null]])
-- insert path of current file into a command
cnoremap('%%', "<C-r>=fnameescape(expand('%'))<cr>")
cnoremap('::', "<C-r>=fnameescape(expand('%:p:h'))<cr>/")

nnoremap('<leader>l', [[<cmd>nohlsearch<cr><cmd>diffupdate<cr><cmd>syntax sync fromstart<cr><c-l>]])

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

-- buffer
-- nnoremap('fd', ':bd<cr>')
nnoremap('fD', ':BufferLinePickClose<cr>')
nnoremap('H', ':BufferLineCyclePrev<cr>')
nnoremap('L', ':BufferLineCycleNext<cr>')
nnoremap('<m-H>', ':BufferLineMovePrev<CR>')
nnoremap('<m-L>', ':BufferLineMoveNext<CR>')
-- Switch between the last two files
nnoremap(',,', [[<c-^>]])

-- tabedit
nnoremap('te', ':tabe<cr>')
nnoremap('<leader><tab>', 'gt')

-- window
nnoremap('<m-h>', '<C-w>h')
nnoremap('<m-j>', '<C-w>j')
nnoremap('<m-k>', '<C-w>k')
nnoremap('<m-l>', '<C-w>l')
nnoremap('<up>', ':res +1<cr>')
nnoremap('<down>', ':res -1<cr>')
nnoremap('<left>', ':vertical res -1<cr>')
nnoremap('<right>', ':vertical res +1<cr>')

-- Telescope
nnoremap('ff', ':Telescope find_files<cr>')
nnoremap('fo', ':Telescope oldfiles<cr>')
nnoremap('fg', ':Telescope live_grep<cr>')
nnoremap('fw', ':Telescope grep_string<cr>')
nnoremap('fh', ':Telescope search_history<cr>')
nnoremap('f;', ':Telescope commands<cr>')
nnoremap('fc', ':Telescope command_history<cr>')
nnoremap('fb', ':Telescope buffers<cr>')
nnoremap('f/', ':Telescope current_buffer_fuzzy_find<cr>')
nnoremap('f?', ':Telescope help_tags<cr>')
nnoremap('fm', ':Telescope marks<cr>')
nnoremap('ft', ':Telescope lsp_dynamic_workspace_symbols<cr>')
nnoremap('fn', ':Telescope notify<cr>')

-- trouble.nvim
nnoremap('gr', '<cmd>TroubleToggle lsp_references<cr>')
nnoremap('gi', '<cmd>TroubleToggle lsp_implementations<cr>', noisy)
nnoremap('gq', '<cmd>TroubleToggle workspace_diagnostics<cr>')

-- flutter
nnoremap('<leader>fr', ':FlutterRestart<cr>', noisy)
nnoremap('<leader>fq', ':FlutterQuit<cr>', noisy)
nnoremap('<leader>fg', ':FlutterPubGet<cr>', noisy)
nnoremap('<leader>fu', ':FlutterPubUpgrade<cr>', noisy)
nnoremap('<leader>fo', ':FlutterOutlineToggle<cr>', noisy)
nnoremap('<leader>fc', ':FlutterLogClear<cr>', noisy)
nnoremap('<leader>fd', ':FlutterDevices<cr>', noisy)
nnoremap('<leader>ft', ':FlutterDevTools<cr>', noisy)
nnoremap('<leader>fp', ':FlutterVisualDebug<cr>', noisy)

-- dap
nnoremap('<leader>dd', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
nnoremap('<leader>dc', '<cmd>lua require("dap").continue()<cr>')
nnoremap('<leader>di', '<cmd>lua require("dap").step_into()<cr>')
nnoremap('<leader>du', '<cmd>lua require("dap").step_out()<cr>')
nnoremap('<leader>do', '<cmd>lua require("dap").step_over()<cr>')
nnoremap('<leader>dl', '<cmd>lua require("dap").run_last()<cr>')
nnoremap('<leader>dr', '<cmd>lua require("dap").repl.toggle()<cr>')

-- dap-ui
nnoremap('<leader>dt', '<cmd>lua require("dapui").toggle()<cr>')
