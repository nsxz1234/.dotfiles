local utils = require 'utils.plugins'
local conf = utils.conf

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- local use = require('packer').use
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'sainnhe/everforest'
  use { 'neovim/nvim-lspconfig', config = conf 'lspconfig' }
  use 'lukas-reineke/lsp-format.nvim'
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
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
    },
    config = conf 'cmp',
  }
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
  }
  -- use 'junegunn/fzf.vim'
  use { 'akinsho/nvim-bufferline.lua', config = conf 'bufferline' }
  use 'windwp/nvim-autopairs'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'gcmt/wildfire.vim'
  use 'tpope/vim-surround'
  use 'mbbill/undotree'
  use 'nvim-lualine/lualine.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'instant-markdown/vim-instant-markdown' }
  use 'akinsho/nvim-toggleterm.lua'
  use 'voldikss/vim-translator'
  use 'norcalli/nvim-colorizer.lua'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    },
  }
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
      vim.cmd [[imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")]]
      vim.g.copilot_filetypes = {
        ['*'] = false,
        gitcommit = false,
        NeogitCommitMessage = false,
        dart = true,
        lua = true,
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
vim.opt.shortmess:append 'c'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.switchbuf = 'useopen,uselast'
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
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '│' },
    change = { hl = 'GitGutterChange', text = '│' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

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
    prompt_prefix = '  ',
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

-- vsnip
vim.g.vsnip_snippet_dir = '$HOME/.config/nvim/snippets'

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
function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>v',
  ':lua _lazygit_toggle()<CR>',
  { noremap = true, silent = true }
)

-- nvim-colorizer.lua
require('colorizer').setup()

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
  textobjects = {
    lookahead = true,
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aC'] = '@conditional.outer',
        ['iC'] = '@conditional.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['[w'] = '@parameter.inner',
      },
      swap_previous = {
        [']w'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ['df'] = '@function.outer',
        ['dF'] = '@class.outer',
      },
    },
  },
  rainbow = {
    enable = true,
    disable = { 'lua', 'json', 'html' },
    colors = {
      'royalblue3',
      'darkorange3',
      'seagreen3',
      'firebrick',
      'darkorchid3',
    },
    autopairs = { enable = true },
  },
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_next_usage = '<C-n>',
        goto_previous_usage = '<C-p>',
      },
    },
  },
}

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
    require('null-ls').builtins.code_actions.gitsigns,
    require('null-ls').builtins.diagnostics.zsh,
    require('null-ls').builtins.formatting.stylua, -- install stylua
    require('null-ls').builtins.formatting.prettier.with {
      filetypes = { 'html', 'json', 'yaml', 'graphql', 'markdown' },
    }, -- install prettier
  },
}
