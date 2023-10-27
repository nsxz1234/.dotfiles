-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require('wezterm')

return {
  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 0.80,

  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

  window_decorations = 'NONE',

  font = wezterm.font('FantasqueSansM Nerd Font'),

  font_size = 17.0,

  default_cursor_style = 'BlinkingBar',

  line_height = 1.12,

  keys = {
    { key = 'i', mods = 'CTRL', action = wezterm.action.SendString('\x1b[105;5u') },
  },
}
