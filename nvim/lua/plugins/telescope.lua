return function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      file_ignore_patterns = { '%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf', '%.DS_Store' },
      path_display = { 'smart', 'absolute', 'truncate' },
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      mappings = {
        i = {
          ['<c-c>'] = function()
            vim.cmd('stopinsert!')
          end,
          ['<esc>'] = actions.close,
        },
      },
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
      history = {
        path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      },
    },
    extensions = {
      fzf = {
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
      },
    },
    pickers = {
      live_grep = {
        file_ignore_patterns = { '.git/' },
        on_input_filter_cb = function(prompt)
          -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
          return { prompt = prompt:gsub('%s', '.*') }
        end,
      },
      colorscheme = {
        enable_preview = true,
      },
      find_files = {
        hidden = true,
      },
    },
  })
end
