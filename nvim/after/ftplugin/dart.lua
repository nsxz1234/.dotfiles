vim.bo.syntax = ''
vim.bo.textwidth = 100

if not as then return end

local function with_desc(desc) return { desc = desc } end

as.nnoremap(
  '<localleader>fb',
  "<cmd>TermExec cmd='flutter pub run build_runner build --delete-conflicting-outputs'<CR>",
  'flutter: run code generation'
)
as.nnoremap('<localleader>fd', '<Cmd>FlutterDevices<CR>', with_desc('flutter: devices'))
as.nnoremap('<localleader>fe', '<Cmd>FlutterEmulators<CR>', with_desc('flutter: emulators'))
as.nnoremap('<localleader>fo', '<Cmd>FlutterOutlineToggle<CR>', with_desc('flutter: outline'))
as.nnoremap('<localleader>fq', '<Cmd>FlutterQuit<CR>', with_desc('flutter: quit'))
as.nnoremap('<localleader>fg', '<Cmd>FlutterRun<CR>', with_desc('flutter: server run'))
as.nnoremap('<localleader>fr', '<Cmd>FlutterRestart<CR>', with_desc('flutter: server restart'))
as.nnoremap('<localleader>fc', '<Cmd>FlutterLogClear<CR>', with_desc('flutter: log clear'))
as.nnoremap('<localleader>fp', '<Cmd>FlutterPubGet<CR>', with_desc('flutter: pub get'))
as.nnoremap('<localleader>ft', '<Cmd>FlutterDevTools<CR>', with_desc('flutter: dev tools'))
