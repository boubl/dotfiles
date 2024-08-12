local wezterm = require("wezterm")

require("status_line")

local config = {}

config.font = wezterm.font("Fantasque Sans Mono")
config.font_size = 16.0

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = false

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.use_resize_increments = true
config.window_decorations = "TITLE | RESIZE"

config.color_scheme = "GruvboxDark"
print(config.window_frame)

if wezterm.target_triple == "aarch64-unknown-linux-gnu" then
	-- config.enable_wayland = false
	config.enable_tab_bar = false
	config.window_decorations = "NONE"
end

return config
