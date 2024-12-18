local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local mux = wezterm.mux
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 16.0

-- config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.8 -- personal recommended value

-- print the workspace name at the upper right
wezterm.on("update-right-status", function(window, _pane)
	window:set_right_status(window:active_workspace())
end)

-- set path to zoxide
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

-- keymaps
config.keys = {
	{
		key = "t",
		mods = "CMD|SHIFT",
		action = act.ShowTabNavigator,
	},
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wezterm.action_callback(function(_window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	{ key = "s", mods = "CTRL|SHIFT", action = workspace_switcher.switch_workspace() },
	{ key = "t", mods = "CTRL|SHIFT", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{ key = "[", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "]", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	-- other keys
}

workspace_switcher.apply_to_config(config)

wezterm.on("gui-startup", function(cmd)
	local _tab, _pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

--[[
wezterm.on("gui-startup", function(cmd)
	local frontend_tab, _, window = mux.spawn_window(cmd or { cwd = "/Users/clinton/pcode/repos/Frontend" })
	window:gui_window():maximize()
	frontend_tab:set_title("frontend")
	local microservices_tab, microservices_pane = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/Microservices" })
	microservices_tab:set_title("lambda/types")
	microservices_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = "/Users/clinton/pcode/repos/Microservices/src/peekapak-types",
	})
	local servers_tab, servers_pane = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/Frontend" })
	servers_tab:set_title("servers")
	servers_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = "/Users/clinton/pcode/repos/mypeekaville.com",
	})
	local aws_scripts_tab = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/aws-scripts" })
	aws_scripts_tab:set_title("aws-scripts")
	local content_meta_tab = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/ContentMeta" })
	content_meta_tab:set_title("content-meta")
	local mypeekaville_tab = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/mypeekaville.com/" })
	mypeekaville_tab:set_title("mypeekaville.com")
	local mypeekaville_unity_tab = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/mypeekaville-unity" })
	mypeekaville_unity_tab:set_title("mypeekaville-unity")
end)
--]]

return config
