local icons = as.ui.icons

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    keys = {
      { '<tab>', '<Cmd>Neotree toggle reveal<CR>', desc = 'NeoTree' },
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require('neo-tree').setup({
        enable_git_status = true,
        git_status_async = true,
        nesting_rules = {
          ['dart'] = { 'freezed.dart', 'g.dart' },
        },
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function() vim.cmd('highlight! Cursor blend=100') end,
          },
          {
            event = 'neo_tree_buffer_leave',
            handler = function() vim.cmd('highlight! Cursor blend=0') end,
          },
        },
        filesystem = {
          hijack_netrw_behavior = 'open_current',
          use_libuv_file_watcher = true,
          group_empty_dirs = true,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = icons.git.add,
              deleted = icons.git.remove,
              modified = icons.git.mod,
              renamed = icons.git.rename,
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
        },
        window = {
          width = 30,
          mappings = {
            ['o'] = 'toggle_node',
          },
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
