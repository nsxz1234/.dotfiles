return {
  'nvim-lua/plenary.nvim',
  {
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
      build = ':MasonUpdate',
      opts = { ui = { height = 0.8 } },
    },
    {
      'williamboman/mason-lspconfig.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        'mason.nvim',
        {
          'neovim/nvim-lspconfig',
          dependencies = {
            {
              'folke/neodev.nvim',
              ft = 'lua',
              opts = { library = { plugins = { 'nvim-dap-ui' } } },
            },
          },
          config = require('servers'),
        },
      },
      opts = { automatic_installation = true },
    },
  },
  'nvim-tree/nvim-web-devicons',
  { 'wellle/targets.vim', event = 'VeryLazy' },
  'mtdl9/vim-log-highlighting',
  'romainl/vim-cool',
  { 'onsails/lspkind.nvim' },
  {
    'ThePrimeagen/harpoon',
    config = function ()
      map('n', '<leader>hh', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
      map('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>')
      map('n', '<m-1>', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
      map('n', '<m-2>', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
      map('n', '<m-3>', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
      map('n', '<m-4>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
    end
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
          ['df'] = 'actions.close',
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
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
    enabled = false,
    event = 'VeryLazy',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          zig = rainbow_delimiters.strategy['noop'],
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
    'chentoast/marks.nvim',
    init = function() as.augroup('marks', { event = 'BufRead', command = ':delm a-zA-Z0-9' }) end,
    event = 'VeryLazy',
    keys = {
      { '<leader>mb', '<Cmd>MarksListBuf<CR>', desc = 'list buffer' },
      { '<leader>mg', '<Cmd>MarksQFListGlobal<CR>', desc = 'list global' },
      { '<leader>m0', '<Cmd>BookmarksQFList 0<CR>', desc = 'list bookmark' },
    },
    opts = {
      force_write_shada = false, -- This can cause data loss
      excluded_filetypes = { 'NeogitStatus', 'NeogitCommitMessage', 'toggleterm' },
      bookmark_0 = { sign = '⚑', virt_text = '' },
      mappings = { annotate = 'm?' },
    },
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
    'simrat39/rust-tools.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lspconfig' },
  },
  {
    'kevinhwang91/nvim-hlslens',
    opts = {},
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
      fast_wrap = { map = '<c-s>' },
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
    'numToStr/Comment.nvim',
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
      { 'fs', '<cmd>SessionManager load_session<cr>' },
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
  { 'famiu/bufdelete.nvim', keys = { { 'df', '<Cmd>Bdelete<CR>' } } },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn['mkdp#util#install']() end,
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    enabled = false,
    opts = {
      bind = true,
      fix_pos = false,
      auto_close_after = 15, -- close after 15 seconds
      hint_enable = false,
      handler_opts = { border = as.ui.current.border },
      toggle_key = '<C-c>',
    },
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = { window = { blend = 0 } },
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
      ignore_lsp = { 'null-ls' },
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
    opts = { create_keymaps = false },
    keys = {
      {
        '<leader>dp',
        function() return require('debugprint').debugprint({ variable = true }) end,
        desc = 'debugprint: cursor',
        expr = true,
      },
      {
        '<leader>do',
        function() return require('debugprint').debugprint({ motion = true }) end,
        { desc = 'debugprint: operator', expr = true },
      },
      { '<leader>dc', '<Cmd>DeleteDebugPrints<CR>', desc = 'debugprint: clear all' },
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
