local wezterm = require 'wezterm'

-- This table holds the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder
-- which will help provide clearer error messages:
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Build the custom configuration we want:
config.default_prog = { 'wsl.exe', '-d', 'Ubuntu' }
-- config.color_scheme = 'Kanagawa (Gogh)'
config.color_scheme = 'Ubuntu'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.launch_menu = {
  {
    label = 'Ubuntu (WSL)',
    args = { 'wsl.exe', '-d', 'Ubuntu' },
  },
  {
    label = 'Powershell 7',
    args = { 'pwsh.exe' }
  },
  {
    label = 'Powershell 1',
    args = { 'powershell.exe'}
  },
  {
    label = 'CMD.exe',
    args = { 'cmd.exe'}
  },
}

-- Nothing beats JetBrains Mono in legibility:
config.font = wezterm.font('JetBrainsMonoNL NF', { weight = 'Light' })
config.font_size = 14

config.disable_default_key_bindings = true
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config

