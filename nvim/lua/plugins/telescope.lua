return function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<c-c>'] = function() vim.cmd('stopinsert!') end,
          ['<esc>'] = actions.close,
          ['<c-j>'] = actions.move_selection_next,
          ['<c-k>'] = actions.move_selection_previous,
          ['<c-n>'] = actions.cycle_history_next,
          ['<c-p>'] = actions.cycle_history_prev,
          ['<c-/>'] = actions.which_key,
          ['<Tab>'] = actions.toggle_selection,
        },
      },
      dynamic_preview_title = true,
      file_ignore_patterns = {
        '%.jpg',
        '%.jpeg',
        '%.png',
        '%.otf',
        '%.ttf',
        '%.DS_Store',
        '^.git/',
        '^node_modules/',
        '^site-packages/',
      },
      path_display = { 'smart', 'absolute', 'truncate' },
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.90,
        height = 0.90,
        preview_cutoff = 1, -- Preview should always show
        vertical = {
          mirror = true,
          prompt_position = 'top',
        },
        horizontal = {
          mirror = false,
          prompt_position = 'top',
        },
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
        file_ignore_patterns = { '.git/', '%.html' },
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
