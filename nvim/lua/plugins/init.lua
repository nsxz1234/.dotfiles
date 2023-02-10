local opt, fmt = vim.opt, string.format

return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      -- vim.g.gruvbox_material_transparent_background = 2
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
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
      dependencies = { 'mason-lspconfig.nvim', 'mason-null-ls.nvim' },
      config = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = { 'neovim/nvim-lspconfig' },
      config = function() require('mason-lspconfig').setup({ automatic_installation = true }) end,
    },
    {
      'jayp0521/mason-null-ls.nvim',
      dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
      opts = { automatic_installation = true },
    },
  },
  'nvim-tree/nvim-web-devicons',
  { 'stevearc/dressing.nvim' },
  'ii14/emmylua-nvim',
  { 'wellle/targets.vim', event = 'VeryLazy' },
  'mtdl9/vim-log-highlighting',
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  'romainl/vim-cool',
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
        type_hints = {
          prefix = '=> ',
          remove_colon_start = true,
        },
      },
    },
  },
  {
    'linty-org/readline.nvim',
    event = 'CmdlineEnter',
    config = function()
      local readline = require('readline')
      local map = vim.keymap.set
      map('!', '<M-f>', readline.forward_word)
      map('!', '<M-b>', readline.backward_word)
      map('!', '<C-a>', readline.beginning_of_line)
      map('!', '<C-e>', readline.end_of_line)
      map('!', '<M-d>', readline.kill_word)
      map('!', '<M-BS>', readline.backward_kill_word)
      map('!', '<C-w>', readline.unix_word_rubout)
      map('!', '<C-u>', readline.backward_kill_line)
    end,
  },
  { 'kylechui/nvim-surround', opts = { keymaps = { visual = 's' } } },
  {
    'zbirenbaum/neodim',
    config = function()
      require('neodim').setup({
        hide = {
          underline = false,
        },
      })
    end,
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
      as.nnoremap('<leader>t', ':TranslateW<cr>')
      as.xnoremap('<leader>t', ':TranslateW<cr>')
    end,
  },
  {
    'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_ignore_not_normal = false,
      })
      as.nnoremap('fs', ':SessionManager load_session<cr>')
      as.nnoremap('<leader>ss', ':SessionManager save_current_session<cr>', { silent = false })
      as.nnoremap('<leader>sd', ':SessionManager delete_session<cr>')
    end,
  },
  {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup()
      as.nnoremap('s', require('hop').hint_words)
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
    opts = {
      win_opts = { border = as.style.current.border },
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
        handler_opts = { border = as.style.current.border },
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
      as.nnoremap('<leader>so', '<cmd>lua require("spectre").open()<CR>')
      as.nnoremap('<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
      as.nnoremap('<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
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
      as.nnoremap('fp', require('telescope').extensions.neoclip.default)
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        detection_methods = { 'pattern', 'lsp' },
        ignore_lsp = { 'null-ls' },
        patterns = { '.git', 'pubspec.yaml' },
      })
    end,
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
      as.nnoremap('<leader>e', '<cmd>Nnn<CR>')
    end,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      { 'rcarriga/nvim-dap-ui', config = true },
      { 'theHamsta/nvim-dap-virtual-text', opts = { all_frames = true } },
    },
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
