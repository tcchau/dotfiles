local wezterm = require("wezterm")

-- load plugin
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- set path to zoxide
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

local config = {}
local act = wezterm.action

-- show workspace name in status
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

config.keys = {
	{
		key = "W",
		mods = "LEADER|SHIFT",
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
}

return config
