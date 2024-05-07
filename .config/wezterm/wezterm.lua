local wezterm = require("wezterm")

require("status_line")

local config = {}

config.font = wezterm.font("mononoki")
config.font_size = 16.0

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = false

config.use_resize_increments = true
config.window_decorations = "RESIZE"

config.color_scheme = "Catppuccin Mocha"

if wezterm.target_triple == "aarch64-unknown-linux-gnu" then
	-- config.enable_wayland = false
	config.enable_tab_bar = false
	config.window_decorations = "NONE"
end

return config
