local function config()
  local fn = vim.fn
  local icons = as.ui.icons.lsp

  local groups = require('bufferline.groups')

  require('bufferline').setup({
    options = {
      debug = { logging = true },
      mode = 'buffers', -- tabs
      sort_by = 'insert_after_current',
      right_mouse_command = 'vert sbuffer %d',
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level) return (icons[level] or '?') .. ' ' .. count end,
      diagnostics_update_in_insert = false,
      offsets = {
        {
          filetype = 'DiffviewFiles',
          text = 'Diff View',
          highlight = 'PanelHeading',
        },
        {
          filetype = 'flutterToolsOutline',
          text = 'Flutter Outline',
          highlight = 'PanelHeading',
        },
        {
          filetype = 'packer',
          text = 'Packer',
          highlight = 'PanelHeading',
        },
      },
      groups = {
        options = { toggle_hidden_on_enter = true },
        items = {
          groups.builtin.pinned:with({ icon = '' }),
          groups.builtin.ungrouped,
          {
            name = 'Terraform',
            matcher = function(buf) return buf.name:match('%.tf') ~= nil end,
          },
          {
            name = 'tests',
            icon = '',
            matcher = function(buf)
              return buf.filename:match('_spec') or buf.filename:match('_test')
            end,
          },
          {
            name = 'docs',
            icon = '',
            matcher = function(buf)
              for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
                if ext == fn.fnamemodify(buf.path, ':e') then return true end
              end
            end,
          },
        },
      },
    },
  })
end

return {
  {
    'akinsho/bufferline.nvim',
    event = 'BufReadPre',
    config = config,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
