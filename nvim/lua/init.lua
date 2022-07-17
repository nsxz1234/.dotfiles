as.safe_require('impatient')

local utils = require('utils.plugins')
local conf = utils.conf

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use('sainnhe/everforest')
  use('sainnhe/gruvbox-material')
  use({
    'williamboman/mason.nvim',
    event = 'BufRead',
    branch = 'alpha',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
    end,
  })
  use({ 'neovim/nvim-lspconfig', config = conf('lspconfig') })
  use('nvim-lua/plenary.nvim')
  use({ 'akinsho/flutter-tools.nvim', config = conf('flutter-tools') })
  use({ 'akinsho/nvim-bufferline.lua', config = conf('bufferline') })
  use({ 'lukas-reineke/indent-blankline.nvim', config = conf('indentline') })
  use('kyazdani42/nvim-web-devicons')
  use({ 'stevearc/dressing.nvim', after = 'telescope.nvim' })
  use({ 'folke/which-key.nvim', config = conf('whichkey') })
  use({ 'rcarriga/nvim-notify', config = conf('notify') })
  use('folke/lua-dev.nvim')
  use('wellle/targets.vim')
  use({ 'psliwka/vim-dirtytalk', run = ':DirtytalkUpdate' })
  use({ 'nvim-lualine/lualine.nvim', config = conf('lualine') })
  use('mtdl9/vim-log-highlighting')
  use('lewis6991/impatient.nvim')
  use('antoinemadec/FixCursorHold.nvim')
  use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
  use('ziglang/zig.vim')
  use({
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({
        keymaps = { visual = 's' },
      })
    end,
  })
  use({
    'zbirenbaum/neodim',
    config = function()
      require('neodim').setup({
        hide = {
          signs = false,
        },
      })
    end,
  })
  use({
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
      as.nnoremap(
        '<leader>rn',
        function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
        { expr = true, silent = false, desc = 'lsp: incremental rename' }
      )
    end,
  })
  use({
    'simrat39/symbols-outline.nvim',
    setup = function() as.nnoremap('ts', '<cmd>SymbolsOutline<cr>') end,
  })
  use({
    'akinsho/nvim-toggleterm.lua',
    config = conf('toggleterm'),
  })
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    module_pattern = 'telescope.*',
    config = conf('telescope'),
    event = 'CursorHold',
    requires = {
      {
        'natecraddock/telescope-zf-native.nvim',
        after = 'telescope.nvim',
        config = function() require('telescope').load_extension('zf-native') end,
      },
      {
        'ilAYAli/scMRU.nvim',
        setup = function()
          as.nnoremap('fr', '<Cmd>Mru<CR>', 'most recently used')
          as.nnoremap('fu', '<Cmd>Mfu<CR>', 'most frequently used')
        end,
      },
    },
  })
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      vim.api.nvim_command('set commentstring=//%s')
    end,
  })
  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        fast_wrap = { map = '<c-e>' },
      })
    end,
  })
  use({
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_default_engines = { 'haici' }
      as.nnoremap('tr', ':TranslateW<cr>')
      as.xnoremap('tr', ':TranslateW<cr>')
    end,
  })
  use({
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
  })
  use({
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup()
      as.nnoremap('s', require('hop').hint_words)
    end,
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('null-ls'),
  })
  use({
    'danymat/neogen',
    requires = 'nvim-treesitter/nvim-treesitter',
    module = 'neogen',
    setup = function() as.nnoremap('<leader>cc', require('neogen').generate, 'comment: generate') end,
    config = function() require('neogen').setup({ snippet_engine = 'luasnip' }) end,
  })
  use({
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    setup = function() as.nnoremap('tu', '<cmd>UndotreeToggle<CR>') end,
    config = function()
      vim.g.undotree_TreeNodeShape = '◦' -- Alternative: '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffpanelHeight = 8
      vim.g.undotree_SplitWidth = 24
    end,
  })
  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ 'lua', 'vim', 'kitty', 'conf' }, {
        RGB = false,
        mode = 'background',
      })
    end,
  })
  use({
    'moll/vim-bbye',
    config = function() as.nnoremap('d<space>', '<Cmd>Bdelete<CR>', 'bbye: quit') end,
  })
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  })
  use({
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        bind = true,
        fix_pos = false,
        auto_close_after = 15, -- close after 15 seconds
        hint_enable = false,
        handler_opts = { border = 'none' },
        toggle_key = '<C-c>',
      })
    end,
  })
  use({
    'goolord/alpha-nvim',
    config = function() require('alpha').setup(require('alpha.themes.startify').config) end,
  })
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    config = conf('neo-tree'),
    keys = { '<tab>', '<C-e>' },
    cmd = { 'NeoTree' },
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'kyazdani42/nvim-web-devicons',
    },
  })
  use({
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup({
        enable = true,
      })
    end,
  })
  use({
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        window = { blend = 0 },
      })
    end,
  })
  use({
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',
    module = 'trevj',
    setup = function()
      as.nnoremap(
        'S',
        function() require('trevj').format_at_cursor() end,
        { desc = 'splitjoin: split' }
      )
    end,
  })
  use({
    'nvim-pack/nvim-spectre',
    config = function()
      as.nnoremap('<leader>so', '<cmd>lua require("spectre").open()<CR>')
      as.nnoremap('<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
      as.nnoremap('<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
    end,
  })
  use({
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
  })
  use({
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        ignore_lsp = { 'null-ls' },
        patterns = { '.git', 'pubspec.yaml' },
      })
    end,
  })
  use({
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
  })
  use({
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_highlight_matches = 'underline'
      vim.g.VM_theme = 'codedark'
      vim.g.VM_maps = {
        ['Find Under'] = '<m-n>',
        ['Find Subword Under'] = '<m-n>',
        ['Select Cursor Down'] = '\\j',
        ['Select Cursor Up'] = '\\k',
      }
    end,
  })
  use({
    'nvim-neotest/neotest',
    config = conf('neotest'),
    requires = {
      'rcarriga/neotest-plenary',
      'rcarriga/neotest-vim-test',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
    },
  })
  use({
    'mfussenegger/nvim-dap',
    module = 'dap',
    requires = {
      {
        'rcarriga/nvim-dap-ui',
        after = 'nvim-dap',
        config = function() require('dapui').setup() end,
      },
    },
  })
  use({
    'akinsho/pubspec-assist.nvim',
    requires = 'plenary.nvim',
    rocks = {
      {
        'lyaml',
        server = 'http://rocks.moonscript.org',
      },
    },
    config = function() require('pubspec-assist').setup() end,
  })
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = conf('treesitter'),
  })
  use({ 'p00f/nvim-ts-rainbow' })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
  use({
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        multiline_threshold = 4,
        mode = 'topline',
      })
    end,
  })
  use({
    'hrsh7th/nvim-cmp',
    module = 'cmp',
    event = 'InsertEnter',
    config = conf('cmp'),
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
      {
        'petertriho/cmp-git',
        after = 'nvim-cmp',
        config = function()
          require('cmp_git').setup({ filetypes = { 'gitcommit', 'NeogitCommitMessage' } })
        end,
      },
    },
  })
  use({
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    module = 'luasnip',
    requires = 'rafamadriz/friendly-snippets',
    config = conf('luasnip'),
  })
  use('rafamadriz/friendly-snippets')
  use({
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 15 end,
  })
  --
  -- TPOPE
  --
  use('tpope/vim-eunuch')
  use('tpope/vim-sleuth')
  use('tpope/vim-repeat')
  use({
    'johmsalas/text-case.nvim',
    -- "&" Repeat last substitute with flags
    config = function()
      require('textcase').setup()
      as.nnoremap('<leader>/', ':%s/<C-r><C-w>//c<left><left>', { silent = false })
      as.xnoremap('<leader>/', [["zy:%s/<C-r><C-o>"//c<left><left>]], { silent = false })
    end,
  })
  --
  -- Git
  --
  use({ 'lewis6991/gitsigns.nvim', event = 'CursorHold', config = conf('gitsigns') })
  use({
    'TimUntersberger/neogit',
    requires = 'plenary.nvim',
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
  })
  use({
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    module = 'diffview',
    setup = function()
      as.nnoremap('<leader>gd', '<Cmd>DiffviewOpen<CR>', 'diffview: diff HEAD')
      as.nnoremap('<leader>gh', '<Cmd>DiffviewFileHistory<CR>', 'diffview: file history')
      as.xnoremap('<leader>gh', [[:'<'>DiffviewFileHistory<CR>]], 'diffview: file history')
    end,
    config = function()
      require('diffview').setup({
        enhanced_diff_hl = true,
        keymaps = {
          view = { q = '<Cmd>DiffviewClose<CR>' },
          file_panel = { q = '<Cmd>DiffviewClose<CR>' },
          file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
        },
      })
    end,
  })
  use({
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
  })
end)
