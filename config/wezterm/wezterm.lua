-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.window_decorations = "RESIZE"
config.font = wezterm.font("FiraCode Nerd Font Mono", {})
config.font_size = 13
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "tokyonight_night"
config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
	bottom = 0,
}

config.use_ime = true

-- and finally, return the configuration to wezterm
return config
