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
	font = wezterm.font 'Roboto Mono',
	warn_about_missing_glyphs = false,
	check_for_updates = false,
	-- scroll_factor = 0.2,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = "Gruvbox dark, hard (base16)",
	window_decorations = "NONE",
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
	mouse_bindings = {
		{ event = { Down = { streak = 1, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.SelectTextAtMouseCursor('Cell'), },
		{ event = { Down = { streak = 1, button = 'Middle' } }, mods = 'NONE',  action = wezterm.action.PasteFrom('PrimarySelection'), },
		{ event = { Down = { streak = 2, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.SelectTextAtMouseCursor('Word'), },
		{ event = { Down = { streak = 3, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.SelectTextAtMouseCursor('Line'), },
		{ event = { Drag = { streak = 1, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.ExtendSelectionToMouseCursor('Cell'), },
		{ event = { Drag = { streak = 2, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.ExtendSelectionToMouseCursor('Word'), },
		{ event = { Drag = { streak = 3, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.ExtendSelectionToMouseCursor('Line'), },
		{ event = { Up   = { streak = 2, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'), },
		{ event = { Up   = { streak = 3, button = 'Left' } },   mods = 'SHIFT', action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'), },
	},
}
