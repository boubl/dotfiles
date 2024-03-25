local wezterm = require("wezterm")

require("status_line")

return {

	font = wezterm.font("mononoki"),
	font_size = 16.0,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = false,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = false,

	use_resize_increments = true,
	window_decorations = "RESIZE",

	color_scheme = "Catppuccin Mocha",
}
