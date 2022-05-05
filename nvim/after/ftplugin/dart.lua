-- remove the "t" option added by dart-vim-plugin which forces lines to autowrap at text
-- width which is very annoying
vim.opt_local.formatoptions:remove('t')

-- TODO: ask treesitter team what the correct way to do this is
-- disable syntax based highlighting for dart and use only treesitter
-- this still lets the syntax file be loaded for things like the LSP.
vim.opt_local.syntax = ''

local success, wk = pcall(require, 'which-key')
if not success then
  return
end

wk.register({
  f = {
    name = '+flutter',
    b = {
      "<cmd>TermExec cmd='flutter pub run build_runner build --delete-conflicting-outputs'<CR>",
      'flutter: run code generation',
    },
    d = { '<Cmd>FlutterDevices<CR>', 'flutter: devices' },
    e = { '<Cmd>FlutterEmulators<CR>', 'flutter: emulators' },
    o = { '<Cmd>FlutterOutlineToggle<CR>', 'flutter: outline' },
    q = { '<Cmd>FlutterQuit<CR>', 'flutter: quit' },
    g = { '<Cmd>FlutterRun<CR>', 'run' },
    r = { '<Cmd>FlutterRestart<CR>', 'restart' },
    c = { '<Cmd>FlutterLogClear<CR>', 'log clear' },
    p = { '<Cmd>FlutterPubGet<CR>', 'flutter: pub get' },
    t = { '<Cmd>FlutterDevTools<CR>', 'flutter: dev tools' },
  },
}, {
  prefix = '<localleader>',
})
