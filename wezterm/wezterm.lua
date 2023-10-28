-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require('wezterm')

return {
  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 0.85,

  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

  window_decorations = 'NONE',

  font = wezterm.font('FantasqueSansM Nerd Font'),

  font_size = 17.0,

  default_cursor_style = 'BlinkingBar',

  line_height = 1.12,

  keys = {
    { key = 'i', mods = 'CTRL', action = wezterm.action.SendString('\x1b[105;5u') },
  },

  color_scheme = 'gruvbox_material_dark_hard',
  color_schemes = {
    ['gruvbox_material_dark_hard'] = {
      background = '#32302f',
      foreground = '#D4BE98',
      cursor_bg = '#D4BE98',
      cursor_border = '#D4BE98',
      cursor_fg = '#1D2021',
      selection_bg = '#D4BE98',
      selection_fg = '#3C3836',

      ansi = { '#1d2021', '#ea6962', '#a9b665', '#d8a657', '#7daea3', '#d3869b', '#89b482', '#d4be98' },
      brights = {
        '#eddeb5',
        '#ea6962',
        '#a9b665',
        '#d8a657',
        '#7daea3',
        '#d3869b',
        '#89b482',
        '#d4be98',
      },
    },
  },
}
