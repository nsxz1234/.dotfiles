return {
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'mtdl9/vim-log-highlighting',
  'romainl/vim-cool',
  'onsails/lspkind.nvim',
  {
    'lukas-reineke/virt-column.nvim',
    event = 'VimEnter',
    opts = { char = '▕' },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        indent = {
          char = '┊', -- ┊ ▏
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = { 'Function', 'Label' },
        },
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    opts = {},
  },
  {
    'toppair/peek.nvim',
    event = 'VeryLazy',
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({
        app = { 'firefox', '-new-window' },
        theme = 'light',
      })
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {
    'chomosuke/typst-preview.nvim',
    version = '1.*',
    build = function() require('typst-preview').update() end,
    opts = {
      open_cmd = 'firefox -new-window %s --class typst-preview',
    },
  },
  {
    'cbochs/grapple.nvim',
    keys = {
      { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
      { '<leader>1', '<cmd>Grapple select index=1<cr>' },
      { '<leader>2', '<cmd>Grapple select index=2<cr>' },
      { '<leader>3', '<cmd>Grapple select index=3<cr>' },
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {
      select = {
        backend = { 'fzf_lua', 'builtin' },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      map('n', '-', '<cmd>Oil<CR>')
      require('oil').setup({
        keymaps = {
          ['<C-s>'] = false,
          ['<C-h>'] = false,
          ['<C-l>'] = false,
          ['<C-t>'] = false,
        },
        view_options = {
          show_hidden = true,
        },
        delete_to_trash = true,
      })
    end,
  },
  {
    'stevearc/quicker.nvim',
    opts = {},
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      preview = {
        winblend = 0,
        border = as.ui.current.border,
      },
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
      }
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
      map('n', '<leader>so', '<cmd>lua require("spectre").open()<CR>')
      map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
      map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
    end,
  },
  {
    'ziglang/zig.vim',
    config = function() vim.g.zig_fmt_autosave = 0 end,
  },
  {
    'willothy/flatten.nvim',
    priority = 1001,
    opts = {
      window = { open = 'alternate' },
      callbacks = {
        block_end = function() require('toggleterm').toggle() end,
        post_open = function(_, winnr)
          require('toggleterm').toggle()
          vim.api.nvim_set_current_win(winnr)
        end,
      },
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    opts = {},
    keys = {
      {
        'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      {
        'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
  { 'nacro90/numb.nvim', event = 'CmdlineEnter', opts = {} },
  {
    'kylechui/nvim-surround',
    version = '*',
    opts = { keymaps = { visual = 's' } },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        dart = { 'string' },
      },
    },
  },
  {
    'smjonas/inc-rename.nvim',
    opts = {},
    keys = {
      {
        '<leader>r',
        function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
        expr = true,
        silent = false,
        desc = 'lsp: incremental rename',
      },
    },
  },
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'voldikss/vim-translator',
    config = function()
      map({ 'n', 'x' }, '<leader>t', ':TranslateW<cr>')
      vim.g.translator_default_engines = { 'haici' }
    end,
  },
  {
    'Shatur/neovim-session-manager',
    keys = {
      { 'fp', '<cmd>SessionManager load_session<cr>' },
      { '<leader>ss', '<cmd>SessionManager save_current_session<cr>', silent = false },
      { '<leader>sd', '<cmd>SessionManager delete_session<cr>' },
    },
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_ignore_not_normal = false,
      })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
    keys = {
      { 's', function() require('flash').jump() end, mode = { 'n', 'o' } },
      { 'S', function() require('flash').treesitter() end, mode = { 'n', 'o', 'x' } },
    },
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'undotree: toggle' } },
    config = function()
      vim.g.undotree_TreeNodeShape = '◦' -- Alternative: '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffpanelHeight = 8
      vim.g.undotree_SplitWidth = 24
    end,
  },
  {
    'uga-rosa/ccc.nvim',
    event = 'VeryLazy',
    opts = {
      highlighter = { auto_enable = true, excludes = { 'dart', 'lazy', 'toggleterm' } },
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          max_height = 3,
        },
      },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false },
    keys = {
      { 'gs', '<Cmd>TSJSplit<CR>', desc = 'split expression to multiple lines' },
      { 'gj', '<Cmd>TSJJoin<CR>', desc = 'join expression to single line' },
    },
  },
  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    opts = {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', 'pubspec.yaml', 'build.zig' },
    },
  },
  {
    'akinsho/pubspec-assist.nvim',
    ft = { 'dart' },
    event = 'BufEnter pubspec.yaml',
    opts = {},
  },
  {
    'andrewferrier/debugprint.nvim',
    opts = {
      keymaps = {
        normal = {
          plain_below = '<leader>dp',
          variable_below = '<leader>dv',
        },
        visual = {
          variable_below = '<leader>dv',
        },
      },
    },
  },
  --
  -- TPOPE
  --
  { 'tpope/vim-eunuch', event = 'VeryLazy' },
  { 'tpope/vim-sleuth', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  {
    'johmsalas/text-case.nvim',
    event = 'VeryLazy',
    -- "&" Repeat last substitute with flags
    keys = {
      { '<leader>/', ':%s/<C-r><C-w>//g<left><left>', mode = 'n', silent = false },
      { '<leader>/', [["zy:%s/<C-r><C-o>"//g<left><left>]], mode = 'x', silent = false },
    },
  },
}
--------------------------
-- vim:foldmethod=marker nospell
