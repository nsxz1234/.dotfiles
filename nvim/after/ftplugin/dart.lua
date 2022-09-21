vim.bo.syntax = ''
vim.bo.textwidth = 100

if not as then return end

local function with_desc(desc) return { desc = desc } end

as.nnoremap(
  '<localleader>fb',
  "<cmd>TermExec cmd='flutter pub run build_runner build --delete-conflicting-outputs'<CR>",
  'flutter: run code generation'
)
as.nnoremap('<leader>fd', '<Cmd>FlutterDevices<CR>', with_desc('flutter: devices'))
as.nnoremap('<leader>fe', '<Cmd>FlutterEmulators<CR>', with_desc('flutter: emulators'))
as.nnoremap('<leader>fo', '<Cmd>FlutterOutlineToggle<CR>', with_desc('flutter: outline'))
as.nnoremap('<leader>fq', '<Cmd>FlutterQuit<CR>', with_desc('flutter: quit'))
as.nnoremap('<leader>fg', '<Cmd>FlutterRun<CR>', with_desc('flutter: server run'))
as.nnoremap('<leader>fr', '<Cmd>FlutterRestart<CR>', with_desc('flutter: server restart'))
as.nnoremap('<leader>fc', '<Cmd>FlutterLogClear<CR>', with_desc('flutter: log clear'))
as.nnoremap('<leader>fp', '<Cmd>FlutterPubGet<CR>', with_desc('flutter: pub get'))
as.nnoremap('<leader>ft', '<Cmd>FlutterDevTools<CR>', with_desc('flutter: dev tools'))
