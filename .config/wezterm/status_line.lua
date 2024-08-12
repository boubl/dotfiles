local wezterm = require("wezterm")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local scheme = config.window_frame
	print(scheme)
	local fg = scheme.button_bg
	local bg = scheme.button_fg
	local text = "▂"

	if tab.is_active then
		bg = scheme.button_bg
		if hover then
			fg = scheme.button_hover_fg
		else
			fg = scheme.active_titlebar_fg
		end
		text = "█"
	else
		if hover then
			bg = scheme.button_hover_fg
		end
		if tab.tab_index % 2 == 0 then
			bg = wezterm.color.parse(bg):lighten(0.5)
		end
	end

	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = text },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.fa_clock_o .. " " .. date },
	}))
end)
