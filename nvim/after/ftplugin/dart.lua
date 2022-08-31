vim.bo.syntax = ''

if not as then return end
as.ftplugin_conf(
  'which-key',
  function(wk)
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
  end
)
