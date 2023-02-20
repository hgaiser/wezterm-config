local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
	local _tab, _pane, window = wezterm.mux.spawn_window { }
	window:gui_window():maximize()
end)

-- Create shortcuts for ALT+n to switch tabs.
switch_tab_keys = {}
for key = 1, 9 do
	switch_tab_keys[#switch_tab_keys + 1] = {
		key = tostring(key), mods = "ALT", action = wezterm.action.ActivateTab(key - 1)
	}
end

return {
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = "Gruvbox dark, hard (base16)",
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	keys = {
		{ key = "Enter",      mods = "ALT",       action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }, },
		{ key = "Enter",      mods = "ALT|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }, },
		{ key = "c",          mods = "ALT",       action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }, },
		{ key = "c",          mods = "ALT|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }, },
		{ key = "t",          mods = "ALT",       action = wezterm.action.SpawnTab("CurrentPaneDomain"), },
		{ key = "LeftArrow",  mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Left"), },
		{ key = "RightArrow", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Right"), },
		{ key = "UpArrow",    mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Up"), },
		{ key = "DownArrow",  mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Down"), },

		table.unpack(switch_tab_keys),
	},
}
