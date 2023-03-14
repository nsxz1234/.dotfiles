return {
  'nvim-lua/plenary.nvim',
  {
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
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
        },
      },
      config = function()
        require('mason-lspconfig').setup({ automatic_installation = true })
        require('mason-lspconfig').setup_handlers({
          function(name)
            local config = require('servers')(name)
            require('lspconfig')[name].setup(config)
          end,
        })
      end,
    },
  },
  'nvim-tree/nvim-web-devicons',
  { 'stevearc/dressing.nvim' },
  { 'wellle/targets.vim', event = 'VeryLazy' },
  'mtdl9/vim-log-highlighting',
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  'romainl/vim-cool',
  {
    'willothy/flatten.nvim',
    priority = 1001,
    config = {
      window = { open = 'current' },
      callbacks = {
        block_end = function() require('toggleterm').toggle() end,
        pre_open = function() require('toggleterm').toggle() end,
        post_open = function(_, winnr)
          require('toggleterm').toggle()
          vim.api.nvim_set_current_win(winnr)
        end,
      },
    },
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = { 'nvim-lspconfig' },
  },
  {
    'saecki/crates.nvim',
    version = '*',
    event = 'BufRead Cargo.toml',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      null_ls = { enabled = true },
    },
    config = function(_, opts)
      as.augroup('CmpSourceCargo', {
        event = 'BufRead',
        pattern = 'Cargo.toml',
        command = function() require('cmp').setup.buffer({ sources = { { name = 'crates' } } }) end,
      })
      require('crates').setup(opts)
    end,
  },
  {
    'cshuaimin/ssr.nvim',
    keys = { { '<leader>sr', function() require('ssr').open() end, mode = { 'n', 'x' } } },
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  },
  { 'nacro90/numb.nvim', event = 'CmdlineEnter', config = true },
  {
    'lvimuser/lsp-inlayhints.nvim',
    opts = {
      inlay_hints = {
        highlight = 'Comment',
        labels_separator = ' ⏐ ',
        parameter_hints = { prefix = '' },
        type_hints = { prefix = '=> ', remove_colon_start = true },
      },
    },
  },
  {
    'linty-org/readline.nvim',
    keys = {
      { '<M-f>', function() require('readline').forward_word() end, mode = '!' },
      { '<M-b>', function() require('readline').backward_word() end, mode = '!' },
      { '<C-a>', function() require('readline').beginning_of_line() end, mode = '!' },
      { '<C-e>', function() require('readline').end_of_line() end, mode = '!' },
      { '<M-d>', function() require('readline').kill_word() end, mode = '!' },
      { '<M-BS>', function() require('readline').backward_kill_word() end, mode = '!' },
      { '<C-w>', function() require('readline').unix_word_rubout() end, mode = '!' },
      { '<C-u>', function() require('readline').backward_kill_line() end, mode = '!' },
    },
  },
  { 'kylechui/nvim-surround', opts = { keymaps = { visual = 's' } } },
  {
    'zbirenbaum/neodim',
    event = 'VeryLazy',
    opts = {
      hide = { underline = false },
    },
  },
  {
    'smjonas/inc-rename.nvim',
    config = true,
    keys = {
      {
        '<leader>rn',
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
    config = true,
    -- opts = {
    --   vim.api.nvim_command('set commentstring=//%s'),
    -- },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      check_ts = true,
      fast_wrap = { map = '<c-e>' },
      ts_config = {
        lua = { 'string' },
        dart = { 'string' },
      },
    },
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
    'phaazon/hop.nvim',
    keys = { { 's', function() require('hop').hint_words() end } },
    config = true,
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
      win_opts = { border = as.ui.current.border },
      highlighter = { auto_enable = true, excludes = { 'dart' } },
    },
  },
  {
    'moll/vim-bbye',
    cmd = 'Bwipeout',
    keys = { { 'df', '<Cmd>Bwipeout<CR>', desc = 'bbye: quit' } },
  },
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
    opts = {
      window = { blend = 0 },
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
    'AckslD/nvim-neoclip.lua',
    event = 'VeryLazy',
    config = true,
    keys = {
      { 'fp', function() require('telescope').extensions.neoclip.default() end },
    },
  },
  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    opts = {
      detection_methods = { 'pattern', 'lsp' },
      ignore_lsp = { 'null-ls' },
      patterns = { '.git', 'pubspec.yaml' },
    },
  },
  {
    'is0n/fm-nvim',
    keys = { { '<leader>e', '<cmd>Nnn<cr>' } },
  },
  {
    'akinsho/pubspec-assist.nvim',
    ft = { 'dart' },
    event = 'BufEnter pubspec.yaml',
    config = true,
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
      { '<leader>/', ':%s/<C-r><C-w>//c<left><left>', mode = 'n', silent = false },
      { '<leader>/', [["zy:%s/<C-r><C-o>"//c<left><left>]], mode = 'x', silent = false },
    },
  },
  --
  -- Git
  --
  {
    'akinsho/git-conflict.nvim',
    event = 'VeryLazy',
    opts = {
      default_mappings = true,
      disable_diagnostics = true,
    },
    keys = {
      { 'co', '<Plug>(git-conflict-ours)' },
      { 'cb', '<Plug>(git-conflict-both)' },
      { 'cn', '<Plug>(git-conflict-none)' },
      { 'ct', '<Plug>(git-conflict-theirs)' },
      { ']c', '<Plug>(git-conflict-next-conflict)' },
      { '[c', '<Plug>(git-conflict-prev-conflict)' },
    },
  },
}
--------------------------
-- vim:foldmethod=marker nospell
