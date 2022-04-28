return function()
  vim.g.neo_tree_remove_legacy_commands = 1
  local icons = as.style.icons
  as.nnoremap('<tab>', '<Cmd>Neotree toggle reveal<CR>')
  require('neo-tree').setup {
    enable_git_status = true,
    git_status_async = true,
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.cmd 'setlocal signcolumn=no'
          vim.cmd 'highlight! Cursor blend=100'
        end,
      },
      {
        event = 'neo_tree_buffer_leave',
        handler = function()
          vim.cmd 'highlight! Cursor blend=0'
        end,
      },
      {
        event = 'file_opened',
        handler = function()
          --auto close
          require('neo-tree').close_all()
        end,
      },
    },
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    default_component_configs = {
      indent = {
        padding = 0,
      },
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
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        o = 'toggle_node',
      },
    },
  }
end
