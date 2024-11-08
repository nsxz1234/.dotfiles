vim.bo.syntax = ''

if not as then return end

local function with_desc(desc) return { buffer = 0, desc = desc } end

map(
  'n',
  '<leader>fb',
  "<cmd>TermExec cmd='flutter pub run build_runner build --delete-conflicting-outputs'<CR>",
  with_desc('flutter: run code generation')
)
map('n', '<leader>fd', '<Cmd>FlutterDevices<CR>', with_desc('flutter: devices'))
map('n', '<leader>fe', '<Cmd>FlutterEmulators<CR>', with_desc('flutter: emulators'))
map('n', '<leader>fc', '<Cmd>FlutterLogClear<CR>', with_desc('flutter: log clear'))
map('n', '<leader>fg', '<Cmd>FlutterPubGet<CR>', with_desc('flutter: pub get'))
map('n', '<leader>fu', '<Cmd>FlutterPubUpgrade<CR>', with_desc('flutter: pub upgrade'))
map('n', '<leader>ft', '<Cmd>FlutterDevTools<CR>', with_desc('flutter: dev tools'))
map('n', '<leader>r', '<Cmd>FlutterRename<CR>', with_desc('flutter: rename'))
