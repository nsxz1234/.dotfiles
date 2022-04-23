local utils = require 'utils.plugins'
local conf = utils.conf

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- local use = require('packer').use
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'neovim/nvim-lspconfig', config = conf 'lspconfig' }
  use 'nvim-lua/plenary.nvim'
  use 'akinsho/flutter-tools.nvim'
  use 'sainnhe/everforest'
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'akinsho/nvim-bufferline.lua', config = conf 'bufferline' }
  use 'windwp/nvim-autopairs'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'tpope/vim-surround'
  use 'mbbill/undotree'
  use 'nvim-lualine/lualine.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'instant-markdown/vim-instant-markdown'
  use 'akinsho/nvim-toggleterm.lua'
  use 'voldikss/vim-translator'
  use 'norcalli/nvim-colorizer.lua'
  use 'ahmedkhalf/project.nvim'
  use 'AndrewRadev/splitjoin.vim'
  use 'AckslD/nvim-neoclip.lua'
  use 'phaazon/hop.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'Shatur/neovim-session-manager'
  use 'goolord/alpha-nvim'
  use 'stevearc/dressing.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'numToStr/Comment.nvim'
  use { 'folke/which-key.nvim', config = conf 'whichkey' }
  use 'folke/trouble.nvim'
  use { 'rcarriga/nvim-notify', config = conf 'notify' }
  use 'folke/lua-dev.nvim'
  use 'wellle/targets.vim'
  use {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    module = 'diffview',
    keys = '<leader>dv',
    setup = function()
      require('which-key').register { ['<localleader>gd'] = 'diffview: diff HEAD' }
    end,
    config = function()
      as.nnoremap('<leader>dv', '<Cmd>DiffviewOpen<CR>')
      require('diffview').setup {
        enhanced_diff_hl = true,
        key_bindings = {
          file_panel = { q = '<Cmd>DiffviewClose<CR>' },
          view = { q = '<Cmd>DiffviewClose<CR>' },
        },
      }
    end,
  }
  use {
    'ilAYAli/scMRU.nvim',
    cmd = { 'Mfu', 'Mru' },
    setup = function()
      as.nnoremap('fu', '<Cmd>Mfu<CR>', 'most frequently used')
    end,
  }
  use {
    'is0n/fm-nvim',
    config = function()
      require('fm-nvim').setup {
        ui = {
          float = {
            border = 'rounded',
          },
        },
      }
      as.nnoremap('<leader>e', '<cmd>Nnn<CR>')
    end,
  }
  use {
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
  }
  use {
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
        config = function()
          require('nvim-dap-virtual-text').setup()
        end,
      },
    },
  }
  use {
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
  }
  use {
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
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = conf 'treesitter',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    },
  }
  use {
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
      { 'petertriho/cmp-git', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = conf 'cmp',
  }
  use {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    module = 'luasnip',
    requires = 'rafamadriz/friendly-snippets',
    config = conf 'luasnip',
  }
  use 'rafamadriz/friendly-snippets'
  --
  -- Git
  --
  use {
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
      local linker = require 'gitlinker'
      linker.setup { mappings = '<leader>gu' }
      as.nnoremap('<leader>go', function()
        linker.get_repo_url { action_callback = require('gitlinker.actions').open_in_browser }
      end)
    end,
  }
end)

vim.opt.inccommand = 'nosplit'
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.hlsearch = false
vim.opt.ic = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.switchbuf = 'useopen,uselast'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.showbreak = [[↪ ]]
vim.opt.breakindentopt = 'sbr'
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'number'
vim.opt.ruler = false
vim.opt.autowriteall = true
vim.opt.guifont = 'FantasqueSansMono Nerd Font:h16'
vim.opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}

-- dap
if vim.env.DEVELOPING then
  vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
end

-- colorscheme
vim.g.everforest_enable_italic = 1
vim.g.everforest_disable_italic_comment = 1
vim.cmd 'colorscheme everforest'

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)

-- Gitsigns
require('gitsigns').setup {}

-- comment
require('Comment').setup {}
vim.api.nvim_command 'set commentstring=//%s'

-- lualine
require('lualine').setup {
  options = {
    theme = 'everforest',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  extensions = { 'nvim-tree' },
}

-- indent-blankline
require('indent_blankline').setup {
  char = '┊', -- │ ┆ ┊ 
  show_foldtext = false,
  context_char = '│',
  show_current_context = true,
  show_current_context_start = false,
  show_current_context_start_on_current_line = false,
  show_first_indent_level = true,
  filetype_exclude = {
    'dap-repl',
    'startify',
    'dashboard',
    'log',
    'fugitive',
    'gitcommit',
    'packer',
    'vimwiki',
    'markdown',
    'json',
    'txt',
    'vista',
    'help',
    'NvimTree',
    'git',
    'TelescopePrompt',
    'undotree',
    'flutterToolsOutline',
    'norg',
    'org',
    'orgagenda',
    '', -- for all buffers without a file type
  },
  buftype_exclude = { 'terminal', 'nofile' },
  context_patterns = {
    'class',
    'function',
    'method',
    'block',
    'list_literal',
    'selector',
    '^if',
    '^table',
    'if_statement',
    'while',
    'for',
  },
}

-- fzf
-- vim.g.fzf_preview_window = 'up'
-- vim.g.fzf_layout = {window = {width = 0.9, height = 0.8}}

-- telescope
local actions = require 'telescope.actions'
require('telescope').setup {
  defaults = {
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.90,
      height = 0.80,
      vertical = {
        mirror = true,
        prompt_position = 'top',
      },
      horizontal = {
        mirror = false,
        prompt_position = 'top',
      },
    },
    mappings = {
      i = {
        ['<c-c>'] = function()
          vim.cmd 'stopinsert!'
        end,
        ['<esc>'] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    },
  },
}

-- nvim-autopairs
require('nvim-autopairs').setup()

-- nvim-tree
vim.g.nvim_tree_icons = {
  default = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
  },
}
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_root_folder_modifier = ':t'
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }

require('nvim-tree').setup {
  view = {
    width = 30,
    auto_resize = true,
  },
  diagnostics = {
    enable = true,
  },
  hijack_unnamed_buffer_when_opening = true,
  sort_by = 'modification_time',
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  system_open = {
    cmd = 'open',
  },
  disable_netrw = false,
  hijack_netrw = true,
  open_on_setup = false,
  hijack_cursor = true,
  update_cwd = true,
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    custom = { '.DS_Store', 'fugitive:', '.git' },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

-- markdown
vim.g.instant_markdown_slow = 1
vim.g.instant_markdown_autostart = 0
vim.g.instant_markdown_autoscroll = 1

-- toggleterm
require('toggleterm').setup {
  open_mapping = [[<c-t>]],
  direction = 'horizontal',
}

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new {
  cmd = 'lazygit',
  dir = 'git_dir',
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
}
function Lazygit_Toggle()
  lazygit:toggle()
end

vim.keymap.set('n', '<leader>v', ':lua Lazygit_Toggle()<CR>', { noremap = true, silent = true })

-- nvim-colorizer.lua
require('colorizer').setup()

-- project.nvim
require('project_nvim').setup {
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
}
-- Telescope Integration
vim.g.nvim_tree_respect_buf_cwd = 1
require('telescope').load_extension 'projects'

-- nvim-neoclip
require('neoclip').setup {
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<m-p>',
        paste_behind = '<m-P>',
      },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
      },
    },
  },
}

-- vim-translator
vim.g.translator_default_engines = { 'haici' }

-- Undotree
vim.g.undotree_DiffAutoOpen = 1
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 8
vim.g.undotree_SplitWidth = 24

-- neovim-session-manager
require('session_manager').setup {
  autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
}

-- alpha-nvim
require('alpha').setup(require('alpha.themes.startify').opts)

-- hop.nvim
require('hop').setup()

-- null-ls
require('null-ls').setup {
  sources = {
    require('null-ls').builtins.code_actions.gitsigns, -- dart formatting
    require('null-ls').builtins.diagnostics.zsh,
    require('null-ls').builtins.formatting.stylua, -- install stylua
    require('null-ls').builtins.formatting.prettier.with {
      filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
    }, -- install prettier
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]]
    end
  end,
}
