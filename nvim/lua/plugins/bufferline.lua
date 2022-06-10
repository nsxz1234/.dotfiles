return function()
  local fn = vim.fn

  local function diagnostics_indicator(_, _, diagnostics)
    local symbols = { error = ' ', warning = ' ', info = ' ' }
    local result = {}
    for name, count in pairs(diagnostics) do
      if symbols[name] and count > 0 then
        table.insert(result, symbols[name] .. count)
      end
    end
    result = table.concat(result, ' ')
    return #result > 0 and result or ''
  end

  local groups = require('bufferline.groups')

  require('bufferline').setup({
    options = {
      debug = {
        logging = true,
      },
      mode = 'buffers', -- tabs
      sort_by = 'insert_after_current',
      right_mouse_command = 'vert sbuffer %d',
      show_close_icon = false,
      ---based on https://github.com/kovidgoyal/kitty/issues/957
      -- separator_style = os.getenv 'KITTY_WINDOW_ID' and 'slant' or 'padded_slant',
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = diagnostics_indicator,
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
          filetype = 'Outline',
          text = 'Symbols',
          highlight = 'PanelHeading',
        },
        {
          filetype = 'packer',
          text = 'Packer',
          highlight = 'PanelHeading',
        },
      },
      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          groups.builtin.ungrouped,
          {
            name = 'Terraform',
            matcher = function(buf)
              return buf.name:match('%.tf') ~= nil
            end,
          },
          {
            highlight = { guisp = '#51AFEF', gui = 'underline' },
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
                if ext == fn.fnamemodify(buf.path, ':e') then
                  return true
                end
              end
            end,
          },
        },
      },
    },
  })
end
