local wezterm = require("wezterm")

local theme = "Catppuccin Mocha"

local scheme = wezterm.color.get_builtin_schemes()[theme]

print(scheme)

local SEPARATOR_SYMBOL = wezterm.nerdfonts.ple_upper_left_triangle
local SOFT_SEPARATOR_SYMBOL = wezterm.nerdfonts.ple_forwardslash_separator_redundant

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local bg = scheme.background
	local fg = scheme.foreground

	local separator = SEPARATOR_SYMBOL

	if tab.is_active then
		bg = scheme.foreground
		fg = scheme.background
	end

	local sep_bg = scheme.background
	local sep_fg = bg

	local next_tab = tab.tab_index + 1 < #tabs
	local next_tab_active = next_tab and tabs[tab.tab_index + 2].is_active
	local need_soft = next_tab and not tab.is_active and not next_tab_active

	if next_tab then
		if next_tab_active then
			sep_bg = scheme.foreground
		end
	else
		sep_bg = scheme.cursor_fg
	end

	if need_soft then
		separator = SOFT_SEPARATOR_SYMBOL
		sep_fg = fg
	end

	local title = tab_title(tab)

	title = wezterm.truncate_right(title, max_width - 3)

	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = sep_bg } },
		{ Foreground = { Color = sep_fg } },
		{ Text = separator },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.fa_clock_o .. " " .. date },
	}))
end)
