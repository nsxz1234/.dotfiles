as.safe_require('impatient')

local utils = require('utils.plugins')
local conf = utils.conf

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use({ 'neovim/nvim-lspconfig', config = conf('lspconfig') })
  use('nvim-lua/plenary.nvim')
  use('akinsho/flutter-tools.nvim')
  use('dart-lang/dart-vim-plugin')
  use('sainnhe/everforest')
  use({ 'akinsho/nvim-bufferline.lua', config = conf('bufferline') })
  use({ 'lukas-reineke/indent-blankline.nvim', config = conf('indentline') })
  use('kyazdani42/nvim-web-devicons')
  use('ryanoasis/vim-devicons')
  use('stevearc/dressing.nvim')
  use({ 'folke/which-key.nvim', config = conf('whichkey') })
  use('folke/trouble.nvim')
  use({ 'rcarriga/nvim-notify', config = conf('notify') })
  use('folke/lua-dev.nvim')
  use('wellle/targets.vim')
  use({ 'psliwka/vim-dirtytalk', run = ':DirtytalkUpdate' })
  use({ 'nvim-lualine/lualine.nvim', config = conf('lualine') })
  use('mtdl9/vim-log-highlighting')
  use('lewis6991/impatient.nvim')
  use('antoinemadec/FixCursorHold.nvim')
  use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
  use({
    'simrat39/symbols-outline.nvim',
    config = function()
      as.nnoremap('ts', '<cmd>SymbolsOutline<cr>')
    end,
  })
  use({
    'akinsho/nvim-toggleterm.lua',
    config = conf('toggleterm'),
  })
  use({
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = conf('telescope'),
    requires = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        after = 'telescope.nvim',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
      {
        'nvim-telescope/telescope-frecency.nvim',
        after = 'telescope.nvim',
        requires = 'tami5/sqlite.lua',
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
      require('nvim-autopairs').setup()
    end,
  })
  use({
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_default_engines = { 'haici' }
      as.nnoremap('tr', ':TranslateW<cr>')
      as.vnoremap('tr', ':TranslateW<cr>')
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
    keys = { '<leader>c' },
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('neogen').setup({ snippet_engine = 'luasnip' })
      as.nnoremap('<leader>c', require('neogen').generate, 'comment: generate')
    end,
  })
  use({
    'mbbill/undotree',
    config = function()
      vim.g.undotree_TreeNodeShape = '◦' -- Alternative: '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffpanelHeight = 8
      vim.g.undotree_SplitWidth = 24
      as.nnoremap('tu', '<cmd>UndotreeToggle<CR>')
    end,
  })
  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ '*' }, {
        RGB = false,
        mode = 'background',
      })
    end,
  })
  use({
    'famiu/bufdelete.nvim',
    config = function()
      as.nnoremap('fd', '<Cmd>Bdelete<CR>')
    end,
  })
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
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
        handler_opts = {
          border = 'none',
        },
      })
    end,
  })
  use({
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  })
  use({
    'bobrown101/minimal-nnn.nvim',
    config = function()
      as.nnoremap('<leader>t', function()
        require('minimal-nnn').start()
      end, { label = 'nnn' })
    end,
  })
  use({
    'narutoxy/dim.lua',
    requires = { 'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig' },
    config = function()
      require('dim').setup({
        disable_lsp_decorations = true,
      })
    end,
  })
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    config = conf('neo-tree'),
    keys = { '<tab>' },
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
        text = {
          spinner = 'moon',
        },
        window = {
          blend = 0,
        },
      })
    end,
  })
  use({
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',
    module = 'trevj',
    setup = function()
      as.nnoremap('S', function()
        require('trevj').format_at_cursor()
      end, { label = 'splitjoin: split' })
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
            n = { select = '<cr>', paste = 'p', paste_behind = 'P' },
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
        patterns = {
          '.git',
          '_darcs',
          '.hg',
          '.bzr',
          '.svn',
          'Makefile',
          'package.json',
          'pubspec.yaml',
        },
      })
    end,
  })
  use({
    'ilAYAli/scMRU.nvim',
    cmd = { 'Mfu', 'Mru' },
    setup = function()
      as.nnoremap('fu', '<Cmd>Mfu<CR>', 'most frequently used')
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
        ['Find Under'] = '<C-e>',
        ['Find Subword Under'] = '<C-e>',
        ['Select Cursor Down'] = '\\j',
        ['Select Cursor Up'] = '\\k',
      }
    end,
  })
  use({
    'mfussenegger/nvim-dap',
    requires = {
      {
        'rcarriga/nvim-dap-ui',
        after = 'nvim-dap',
        config = function()
          require('dapui').setup()
        end,
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        after = 'nvim-dap',
        config = function()
          require('nvim-dap-virtual-text').setup({ all_frames = true })
        end,
      },
    },
  })
  use({
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      as.imap('<Plug>(as-copilot-accept)', "copilot#Accept('<Tab>')", { expr = true })
      as.inoremap('<M-]>', '<Plug>(copilot-next)')
      as.inoremap('<M-[>', '<Plug>(copilot-previous)')
      as.inoremap('<C-\\>', '<Cmd>vertical Copilot panel<CR>')

      vim.g.copilot_filetypes = {
        ['*'] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
        DressingInput = false,
        ['neo-tree-popup'] = false,
        -- dart = false,
      }
    end,
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
    config = function()
      require('pubspec-assist').setup()
    end,
  })
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = conf('treesitter'),
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    },
  })
  use({
    'hrsh7th/nvim-cmp',
    module = 'cmp',
    event = 'InsertEnter',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      {
        'petertriho/cmp-git',
        after = 'nvim-cmp',
        config = function()
          require('cmp_git').setup({ filetypes = { 'gitcommit', 'NeogitCommitMessage' } })
        end,
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = conf('cmp'),
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
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
  })
  use({
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 15
    end,
  })
  --
  -- TPOPE
  --
  use('tpope/vim-eunuch')
  use('tpope/vim-sleuth')
  use('tpope/vim-repeat')
  use({
    'tpope/vim-abolish',
    -- "&" Repeat last substitute with flags
    config = function()
      local opts = { silent = false }
      as.nnoremap('<leader>/', ':%S/<C-r><C-w>//c<left><left>', opts)
      as.xnoremap('<leader>/', [["zy:%S/<C-r><C-o>"//c<left><left>]], opts)
    end,
  })
  use({
    'tpope/vim-surround',
    config = function()
      as.xmap('s', '<Plug>VSurround')
    end,
  })
  --
  -- Git
  --
  use({ 'lewis6991/gitsigns.nvim', config = conf('gitsigns') })
  use({
    'ruifm/gitlinker.nvim',
    requires = 'plenary.nvim',
    keys = { '<leader>gu', '<leader>go' },
    setup = function()
      require('which-key').register(
        { gu = 'gitlinker: get line url', go = 'gitlinker: open repo url' },
        { prefix = '<leader>' }
      )
    end,
    config = function()
      local linker = require('gitlinker')
      linker.setup({ mappings = '<leader>gu' })
      as.nnoremap('<leader>go', function()
        linker.get_repo_url({ action_callback = require('gitlinker.actions').open_in_browser })
      end)
    end,
  })
  use({
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    keys = { '<leader>gs', '<leader>gc', '<leader>gp', '<leader>gP' },
    requires = 'plenary.nvim',
    setup = conf('neogit').setup,
    config = conf('neogit').config,
  })
  use({
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    module = 'diffview',
    keys = { '<leader>gd', '<leader>gh' },
    setup = function()
      require('which-key').register({ ['<leader>gd'] = 'diffview: diff HEAD' })
    end,
    config = function()
      as.nnoremap('<leader>gd', '<Cmd>DiffviewOpen<CR>')
      as.nnoremap('<leader>gh', '<Cmd>DiffviewFileHistory<CR>')
      require('diffview').setup({
        enhanced_diff_hl = true,
        key_bindings = {
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
  -- use {
  --   'rlch/github-notifications.nvim',
  --   -- don't load this plugin if the gh cli is not installed
  --   cond = function()
  --     return as.executable 'gh'
  --   end,
  --   requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  -- }
end)
