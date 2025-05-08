local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font("CommitMono")
config.font_size = 16.0

config.enable_tab_bar = false

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.use_resize_increments = false
config.window_decorations = "TITLE | RESIZE"

config.color_scheme = "Everforest Dark (Gogh)"

if wezterm.target_triple == "aarch64-unknown-linux-gnu" then
	-- config.enable_wayland = false
	config.window_decorations = "NONE"
end

return config
