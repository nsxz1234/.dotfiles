local fmt = string.format
local function conf(name) return require(fmt('plugins.%s', name)) end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {
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
      'williamboman/mason.nvim',
      dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
      },
      config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({ automatic_installation = true })
      end,
    },
    {
      'neovim/nvim-lspconfig',
      config = conf('lspconfig'),
    },
    {
      'akinsho/flutter-tools.nvim',
      config = conf('flutter-tools'),
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'RobertBrunhage/flutter-riverpod-snippets',
    {
      'akinsho/nvim-bufferline.lua',
      config = conf('bufferline'),
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    { 'lukas-reineke/indent-blankline.nvim', config = conf('indentline') },
    'kyazdani42/nvim-web-devicons',
    { 'stevearc/dressing.nvim' },
    { 'rcarriga/nvim-notify', config = conf('notify') },
    'ii14/emmylua-nvim',
    'wellle/targets.vim',
    { 'nvim-lualine/lualine.nvim', config = conf('lualine') },
    'mtdl9/vim-log-highlighting',
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    { 'monaqa/dial.nvim', config = conf('dial') },
    'romainl/vim-cool',
    {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
      config = conf('ufo'),
    },
    {
      'kevinhwang91/nvim-hlslens',
      config = function() require('hlslens').setup() end,
    },
    {
      'folke/todo-comments.nvim',
      enabled = true,
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = function() require('todo-comments').setup() end,
    },
    {
      'nacro90/numb.nvim',
      event = 'CmdlineEnter',
      config = function() require('numb').setup() end,
    },
    {
      'lvimuser/lsp-inlayhints.nvim',
      config = function()
        require('lsp-inlayhints').setup({
          inlay_hints = {
            highlight = 'Comment',
            labels_separator = ' ⏐ ',
            parameter_hints = {
              prefix = '',
            },
            type_hints = {
              prefix = '=> ',
              remove_colon_start = true,
            },
          },
        })
      end,
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
    {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup({
          keymaps = { visual = 's' },
        })
      end,
    },
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
      config = function()
        require('inc_rename').setup()
        as.nnoremap(
          '<leader>rn',
          function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
          { expr = true, silent = false, desc = 'lsp: incremental rename' }
        )
      end,
    },
    {
      'akinsho/nvim-toggleterm.lua',
      config = conf('toggleterm'),
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = 'master', -- '0.1.x',
      lazy = true,
      config = conf('telescope'),
      event = 'CursorHold',
      dependencies = {
        {
          'natecraddock/telescope-zf-native.nvim',
          config = function() require('telescope').load_extension('zf-native') end,
        },
        {
          'ilAYAli/scMRU.nvim',
          init = function()
            as.nnoremap('fr', '<Cmd>Mru<CR>', 'most recently used')
            as.nnoremap('fu', '<Cmd>Mfu<CR>', 'most frequently used')
          end,
        },
      },
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
        vim.api.nvim_command('set commentstring=//%s')
      end,
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({
          fast_wrap = { map = '<c-e>' },
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
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = conf('null-ls'),
    },
    {
      'danymat/neogen',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      module = 'neogen',
      init = function() as.nnoremap('<leader>cc', require('neogen').generate, 'comment: generate') end,
      config = function() require('neogen').setup({ snippet_engine = 'luasnip' }) end,
    },
    {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      init = function() as.nnoremap('<leader>u', '<cmd>UndotreeToggle<CR>') end,
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
      config = function()
        require('ccc').setup({
          win_opts = { border = as.style.current.border },
          highlighter = {
            auto_enable = true,
            excludes = { 'dart' },
          },
        })
      end,
    },
    {
      'moll/vim-bbye',
      config = function() as.nnoremap('df', '<Cmd>Bwipeout<CR>', 'bbye: quit') end,
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
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      config = conf('neo-tree'),
      keys = { '<tab>', '<C-e>' },
      cmd = { 'NeoTree' },
      dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'kyazdani42/nvim-web-devicons',
        { 'mrbjarksen/neo-tree-diagnostics.nvim' },
      },
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
      'aarondiel/spread.nvim',
      init = function()
        as.nnoremap('gs', function() require('spread').out() end, 'spread: expand')
        as.nnoremap('gj', function() require('spread').combine() end, 'spread: combine')
      end,
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
          patterns = { '.git' },
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
      'nvim-neotest/neotest',
      config = conf('neotest'),
      dependencies = {
        { 'rcarriga/neotest-plenary' },
        { 'sidlatau/neotest-dart' },
      },
    },
    {
      'mfussenegger/nvim-dap',
      lazy = true,
      dependencies = {
        {
          'rcarriga/nvim-dap-ui',
          config = function() require('dapui').setup() end,
        },
        {
          'theHamsta/nvim-dap-virtual-text',
          config = function() require('nvim-dap-virtual-text').setup({ all_frames = true }) end,
        },
      },
    },
    {
      'akinsho/pubspec-assist.nvim',
      enabled = false,
      ft = { 'dart' },
      event = 'BufEnter pubspec.yaml',
      rocks = {
        {
          'lyaml',
          server = 'http://rocks.moonscript.org',
        },
      },
      config = function() require('pubspec-assist').setup() end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = conf('treesitter'),
    },
    'p00f/nvim-ts-rainbow',
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = conf('cmp'),
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
        { 'hrsh7th/cmp-cmdline' },
        { 'f3fora/cmp-spell' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'dmitmel/cmp-cmdline-history' },
        {
          'petertriho/cmp-git',
          config = function()
            require('cmp_git').setup({ filetypes = { 'gitcommit', 'NeogitCommitMessage' } })
          end,
        },
      },
    },
    {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      module = 'luasnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = conf('luasnip'),
    },
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      config = function() vim.g.startuptime_tries = 15 end,
    },
    --
    -- TPOPE
    --
    'tpope/vim-eunuch',
    'tpope/vim-sleuth',
    'tpope/vim-repeat',
    {
      'johmsalas/text-case.nvim',
      -- "&" Repeat last substitute with flags
      config = function()
        require('textcase').setup()
        as.nnoremap('<leader>/', ':%s/<C-r><C-w>//c<left><left>', { silent = false })
        as.xnoremap('<leader>/', [["zy:%s/<C-r><C-o>"//c<left><left>]], { silent = false })
      end,
    },
    --
    -- Git
    --
    { 'lewis6991/gitsigns.nvim', event = 'BufRead', config = conf('gitsigns') },
    {
      'TimUntersberger/neogit',
      commit = '691cf89f59ed887809db7854b670cdb944dc9559',
      cmd = 'Neogit',
      keys = { '<leader>gs' },
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local neogit = require('neogit')
        neogit.setup({
          disable_signs = false,
          disable_hint = true,
          disable_commit_confirmation = true,
          disable_builtin_notifications = true,
          disable_insert_on_commit = false,
          signs = {
            section = { '', '' }, -- "", ""
            item = { '▸', '▾' },
            hunk = { '樂', '' },
          },
          integrations = {
            diffview = true,
          },
        })
        as.nnoremap('<leader>gs', function() neogit.open() end, 'neogit: open status buffer')
      end,
    },
    {
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      module = 'diffview',
      init = function()
        as.nnoremap('<leader>gd', '<Cmd>DiffviewOpen<CR>', 'diffview: open')
        as.nnoremap('<leader>gh', '<Cmd>DiffviewFileHistory<CR>', 'diffview: file history')
        as.xnoremap('<leader>gh', [[:'<'>DiffviewFileHistory<CR>]], 'diffview: file history')
      end,
      config = function()
        require('diffview').setup({
          default_args = {
            DiffviewFileHistory = { '%' },
          },
          enhanced_diff_hl = true,
          keymaps = {
            view = { q = '<Cmd>DiffviewClose<CR>' },
            file_panel = { q = '<Cmd>DiffviewClose<CR>' },
            file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
          },
        })
      end,
    },
    {
      'akinsho/git-conflict.nvim',
      config = function()
        require('git-conflict').setup({
          default_mappings = true,
          disable_diagnostics = true,
        })
        as.nnoremap('co', '<Plug>(git-conflict-ours)')
        as.nnoremap('cb', '<Plug>(git-conflict-both)')
        as.nnoremap('cn', '<Plug>(git-conflict-none)')
        as.nnoremap('ct', '<Plug>(git-conflict-theirs)')
        as.nnoremap(']c', '<Plug>(git-conflict-next-conflict)')
        as.nnoremap('[c', '<Plug>(git-conflict-prev-conflict)')
      end,
    },
  },
  --------------------------
  {
    defaults = {},
  }
)

-- vim:foldmethod=marker nospell
