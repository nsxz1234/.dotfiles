local keymap = vim.keymap.set
local nor = { noremap = true }
local opts = { noremap = true, silent = true }

-- basic map
keymap('n', ';', ':', nor)
keymap('', '<c-q>', ':q<cr>', nor)
keymap('', '<c-s>', ':w!<cr>', nor)
keymap('', '<leader>nh', ':noh<cr>', nor)
keymap('i', 'jk', '<esc>', nor)
keymap('t', ',,', '<C-\\><C-n>', nor)
keymap('n', 'dw', 'diw', nor)
keymap('n', 'cw', 'ciw', nor)
keymap('n', 'yw', 'yiw', nor)
keymap('n', 'vw', 'viw', nor)
keymap('n', 'vv', 'V', nor)
keymap('n', 'V', 'v$', nor)
keymap('n', 'Y', 'y$', nor)
keymap('v', 'Y', '"+y', nor)
keymap('v', 'X', '"+x', nor)

-- motions
keymap('', '<c-j>', '5j', nor)
keymap('', '<c-k>', '5k', nor)
keymap('', '<c-h>', '^', nor)
keymap('', '<c-l>', '$', nor)
keymap('i', '<c-l>', '<esc>A', nor)
keymap('i', '<c-j>', '<Left>', nor)
keymap('i', '<c-k>', '<Right>', nor)
keymap('i', ';;', '<Right>;<Left><Left>', nor)
keymap('i', ',,', '<Right>,<Left><Left>', nor)
keymap('s', '<c-l>', '<esc>A', nor)

-- buffer management
keymap('n', 'fd', ':bdelete %<cr>', nor)
keymap('n', 'fD', ':BufferLinePickClose<cr>', nor)
keymap('n', 'H', ':BufferLineCyclePrev<cr>', opts)
keymap('n', 'L', ':BufferLineCycleNext<cr>', opts)
keymap('n', '<m-H>', ':BufferLineMovePrev<CR>', opts)
keymap('n', '<m-L>', ':BufferLineMoveNext<CR>', opts)

-- tabedit
keymap('n', 'te', ':tabe<cr>', opts)

-- window navigation
keymap('n', '<m-h>', '<C-w>h', opts)
keymap('n', '<m-j>', '<C-w>j', opts)
keymap('n', '<m-k>', '<C-w>k', opts)
keymap('n', '<m-l>', '<C-w>l', opts)

-- resize
keymap('n', '<up>', ':res +5<cr>', nor)
keymap('n', '<down>', ':res -5<cr>', nor)
keymap('n', '<left>', ':vertical res -5<cr>', nor)
keymap('n', '<right>', ':vertical res +5<cr>', nor)

-- Telescope
keymap('n', 'ff', ':Telescope find_files<cr>', opts)
keymap('n', 'fo', ':Telescope oldfiles<cr>', opts)
keymap('n', 'fg', ':Telescope live_grep<cr>', opts)
keymap('n', 'fw', ':Telescope grep_string<cr>', opts)
keymap('n', 'f;', ':Telescope commands<cr>', opts)
keymap('n', 'fc', ':Telescope command_history<cr>', opts)
keymap('n', 'fb', ':Telescope buffers<cr>', opts)
keymap('n', 'f/', ':Telescope current_buffer_fuzzy_find<cr>', opts)
keymap('n', 'fh', ':Telescope help_tags<cr>', opts)
keymap('n', 'fm', ':Telescope marks<cr>', opts)
keymap('n', 'ft', ':Telescope lsp_dynamic_workspace_symbols<cr>', opts)

-- neoclip
keymap('n', 'fp', '<cmd>lua require("telescope").extensions.neoclip.default()<cr>', opts)

-- neovim-session-manager
keymap('n', 'fs', ':SessionManager load_session<cr>', opts)
keymap('n', '<leader>ss', ':SessionManager save_current_session<cr>', nor)
keymap('n', '<leader>sd', ':SessionManager delete_session<cr>', nor)

-- trouble.nvim
keymap('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', opts)
keymap('n', 'gi', '<cmd>TroubleToggle lsp_implementations<cr>', nor)
keymap('n', 'gq', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)

-- nvim-tree
keymap('n', 'tt', '<cmd>lua require("nvim-tree").toggle()<CR>', opts)

-- symbols-outline
keymap('n', 'ts', ':SymbolsOutline<cr>', opts)

-- Undotree
keymap('n', 'tu', ':UndotreeToggle<cr>', opts)

-- vim-translator
keymap({ 'n', 'v' }, 'tr', ':TranslateW<cr>', opts)

-- flutter
keymap('n', '<leader>fr', ':FlutterRestart<cr>', nor)
keymap('n', '<leader>fq', ':FlutterQuit<cr>', nor)
keymap('n', '<leader>fg', ':FlutterPubGet<cr>', nor)
keymap('n', '<leader>fu', ':FlutterPubUpgrade<cr>', nor)
keymap('n', '<leader>fo', ':FlutterOutlineToggle<cr>', nor)
keymap('n', '<leader>fc', ':FlutterLogClear<cr>', nor)
keymap('n', '<leader>fd', ':FlutterDevices<cr>', nor)
keymap('n', '<leader>ft', ':FlutterDevTools<cr>', nor)
keymap('n', '<leader>fp', ':FlutterVisualDebug<cr>', nor)

-- hop.nvim
keymap('n', 's', '<cmd>lua require("hop").hint_words()<cr>', opts)

-- dap
keymap('n', '<leader>dd', '<cmd>lua require("dap").toggle_breakpoint()<cr>', opts)
keymap('n', '<leader>dc', '<cmd>lua require("dap").continue()<cr>', opts)
keymap('n', '<leader>di', '<cmd>lua require("dap").step_into()<cr>', opts)
keymap('n', '<leader>du', '<cmd>lua require("dap").step_out()<cr>', opts)
keymap('n', '<leader>do', '<cmd>lua require("dap").step_over()<cr>', opts)
keymap('n', '<leader>dl', '<cmd>lua require("dap").run_last()<cr>', opts)
keymap('n', '<leader>dr', '<cmd>lua require("dap").repl.toggle()<cr>', opts)

-- dap-ui
keymap('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<cr>', opts)
