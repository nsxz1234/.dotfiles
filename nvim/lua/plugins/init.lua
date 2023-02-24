local opt, fmt = vim.opt, string.format

return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      -- vim.g.gruvbox_material_transparent_background = 2
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'soft'
      -- vim.cmd.colorscheme('everforest')
    end,
  },
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
          config = true,
        },
      },
      config = function() require('mason-lspconfig').setup({ automatic_installation = true }) end,
    },
  },
  'nvim-tree/nvim-web-devicons',
  { 'stevearc/dressing.nvim' },
  { 'wellle/targets.vim', event = 'VeryLazy' },
  'mtdl9/vim-log-highlighting',
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  'romainl/vim-cool',
  {
    'lukas-reineke/virt-column.nvim',
    event = 'VimEnter',
    opts = { char = '▕' },
  },
  {
    'cshuaimin/ssr.nvim',
    keys = { { '<leader>sr', function() require('ssr').open() end, mode = { 'n', 'x' } } },
  },
  {
    'm-demare/hlargs.nvim',
    event = 'VeryLazy',
    config = function()
      require('hlargs').setup({
        excluded_argnames = {
          declarations = { 'use', '_' },
          usages = { lua = { 'self', 'use', '_' } },
        },
      })
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function() require('hlslens').setup() end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('todo-comments').setup() end,
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
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
        fast_wrap = { map = '<c-e>' },
        ts_config = {
          lua = { 'string' },
          dart = { 'string' },
        },
      })
    end,
  },
  {
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_default_engines = { 'haici' }
      map({ 'n', 'x' }, '<leader>t', ':TranslateW<cr>')
    end,
  },
  {
    'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_ignore_not_normal = false,
      })
      map('n', 'fs', ':SessionManager load_session<cr>')
      map('n', '<leader>ss', ':SessionManager save_current_session<cr>', { silent = false })
      map('n', '<leader>sd', ':SessionManager delete_session<cr>')
    end,
  },
  {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup()
      map('n', 's', require('hop').hint_words)
    end,
  },
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { snippet_engine = 'luasnip' },
    keys = {
      {
        '<leader>cc',
        function() require('neogen').generate() end,
        desc = 'comment: generate',
      },
    },
  },
  {
    'mizlan/iswap.nvim',
    config = true,
    cmd = { 'ISwap', 'ISwapWith' },
    keys = {
      { '<leader>iw', '<Cmd>ISwapWith<CR>', desc = 'ISwap: swap with' },
      { '<leader>ia', '<Cmd>ISwap<CR>', desc = 'ISwap: swap any' },
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
    config = function()
      require('lsp_signature').setup({
        bind = true,
        fix_pos = false,
        auto_close_after = 15, -- close after 15 seconds
        hint_enable = false,
        handler_opts = { border = as.ui.current.border },
        toggle_key = '<C-c>',
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        window = { blend = 0 },
      })
    end,
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
    'nvim-pack/nvim-spectre',
    config = function()
      map('n', '<leader>so', '<cmd>lua require("spectre").open()<CR>')
      map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
      map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
    end,
  },
  {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup({
        keys = {
          telescope = {
            i = { select = '<cr>', paste = '<m-p>', paste_behind = '<m-P>' },
          },
        },
      })
      map('n', 'fp', require('telescope').extensions.neoclip.default)
    end,
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
    config = function()
      require('fm-nvim').setup({
        ui = {
          float = {
            border = 'rounded',
          },
        },
      })
      map('n', '<leader>e', '<cmd>Nnn<CR>')
    end,
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
