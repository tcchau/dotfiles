-- wezterm.lua
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
local act = wezterm.action

local is_linux = wezterm.target_triple:find("linux") ~= nil
local hostname = wezterm.hostname()

-- Replace with your actual Zorin hostname
local is_zorin = is_linux and (hostname == "clinton-macbook")

if is_zorin then
	-- Force X11 instead of Wayland for this host
	config.enable_wayland = false -- default is true, but we override here[web:8]
end

config.hide_tab_bar_if_only_one_tab = true
config.debug_key_events = true

-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 15

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

if wezterm.gui then
	config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
else
	config.color_scheme = "Catppuccin Mocha"
end

config.leader = {
	key = "\\",
	mods = "CTRL|META",
	timeout_milliseconds = 2000,
}

config.keys = {
	--- Activate copy mode
	---{
	---	key = "?",
	---	mods = "LEADER|SHIFT",
	---	action = wezterm.action.ActivateCopyMode,
	---},
	------ Vertical split
	---{
	---	key = "|",
	---	mods = "LEADER|SHIFT",
	---	action = act.SplitPane({
	---		direction = "Right",
	---		size = { Percent = 50 },
	---	}),
	---},
	----- Horizontal split
	---{
	---	key = "-",
	---	mods = "LEADER",
	---	action = act.SplitPane({
	---		direction = "Down",
	---		size = { Percent = 50 },
	---	}),
	---},
	------ Close pane
	---{
	---	key = "c",
	---	mods = "LEADER",
	---	action = act.CloseCurrentPane({ confirm = true }),
	---},
	------ Swap with active pane
	---{
	---	key = "{",
	---	mods = "LEADER|SHIFT",
	---	action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
	---},
	------ Go to previous pane
	---{
	---	key = "<",
	---	mods = "CMD|SHIFT",
	---	action = act.ActivatePaneDirection("Prev"),
	---},
	------ Go to next pane
	---{
	---	key = ">",
	---	mods = "CMD|SHIFT",
	---	action = act.ActivatePaneDirection("Next"),
	---},
	------ Toggle full screen on pane
	---{
	---	key = "f",
	---	mods = "LEADER",
	---	action = wezterm.action.TogglePaneZoomState,
	---},
	------ Spawn new tab
	------ already bound to default of CMD-T
	------ {
	------ 	key = "t",
	------ 	mods = "LEADER",
	------ 	action = act.SpawnTab("CurrentPaneDomain"),
	------ },
	------ Activate next tab
	---{
	---	key = "]",
	---	mods = "LEADER",
	---	action = wezterm.action.ActivateTabRelative(1),
	---},
	------ Activate previous tab
	---{
	---	key = "[",
	---	mods = "LEADER",
	---	action = wezterm.action.ActivateTabRelative(-1),
	---},
	------ name tab
	---{
	---	key = ",",
	---	mods = "LEADER",
	---	action = act.PromptInputLine({
	---		description = "Enter new name for tab",
	---		action = wezterm.action_callback(function(window, pane, line)
	---			if line then
	---				window:active_tab():set_title(line)
	---			end
	---		end),
	---	}),
	---},
	------ Activate tab navigator
	---{
	---	key = "t",
	---	mods = "LEADER",
	---	action = act.ShowTabNavigator,
	---},
	----- Close tab
	---{
	---	key = "&",
	---	mods = "LEADER|SHIFT",
	---	action = act.CloseCurrentTab({ confirm = true }),
	---},
	----- Attach to muxer
	---{
	---	key = "a",
	---	mods = "LEADER",
	---	action = act.AttachDomain("unix"),
	---},
	----- Detach from muxer
	---{
	---	key = "d",
	---	mods = "LEADER",
	---	action = act.DetachDomain({ DomainName = "unix" }),
	---},
	----- Rename current session; analagous to command in tmux
	---{
	---	key = "$",
	---	mods = "LEADER|SHIFT",
	---	action = act.PromptInputLine({
	---		description = "Enter new name for session",
	---		action = wezterm.action_callback(function(window, pane, line)
	---			if line then
	---				mux.rename_workspace(window:mux_window():get_workspace(), line)
	---			end
	---		end),
	---	}),
	---},
	----- Show list of workspaces
	---{
	---	key = "s",
	---	mods = "LEADER",
	---	action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	---},
}

config.keys = config.keys or {}
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CMD",
		action = act.SendString("\x1b" .. tostring(i)), -- ESC + digit => M-<digit> for tmux
	})
end

table.insert(config.keys, {
	key = "Tab",
	mods = "CTRL",
	action = act.SendKey({ key = "Tab", mods = "CTRL" }),
})

table.insert(config.keys, {
	key = "Tab",
	mods = "CTRL|SHIFT",
	action = act.SendKey({ key = "Tab", mods = "CTRL|SHIFT" }),
})

-- Make it look like tabs, with better GUI controls
config.use_fancy_tab_bar = true

-- Don't let any individual tab name take too much room
config.tab_max_width = 50
config.colors = {
	tab_bar = {
		active_tab = {
			-- I use a solarized dark theme; this gives a teal background to the active tab
			fg_color = "#073642",
			bg_color = "#7aa2f7",
		},
	},
}

-- Switch to the last active tab when I close a tab
config.switch_to_last_active_tab_when_closing_tab = true

config.pane_focus_follows_mouse = true
config.scrollback_lines = 50000

-- I don't really have need for padding between panes
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.unix_domains = {
	{
		name = "unix",
	},
}

local opacity = 0.9

wezterm.on("window-focus-changed", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	overrides.color_scheme = scheme_for_appearance(window:get_appearance())

	if window:is_focused() then
		overrides.window_background_opacity = 1
	else
		overrides.window_background_opacity = opacity
	end

	window:set_config_overrides(overrides)
end)

config.window_background_opacity = opacity
config.macos_window_background_blur = 20

-- Turn on indicator leader key
-- wezterm.on("update-right-status", function(window, pane)
--	local leader = ""
--	if window:leader_is_active() then
--		leader = "LEADER"
--	end
--	window:set_right_status(leader)
--end)

local merge = require("merge")
--local resurrect = require("resurrect/config")
--config.keys = merge.all(config.keys, resurrect.keys)

--local smart_workspace_switcher = require("smart_workspace_switcher/config")
--config.keys = merge.all(config.keys, smart_workspace_switcher.keys)

return config
