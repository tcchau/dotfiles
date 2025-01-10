local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local mux = wezterm.mux
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 16.0

-- config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.8 -- personal recommended value

config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- print the workspace name at the upper right
wezterm.on("update-right-status", function(window, _pane)
	window:set_right_status(window:active_workspace())
end)

-- set path to zoxide
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Text = "󱂬 : " .. label },
	})
end

-- set up resurrect to save and restore workspaces whenever we switch to or from a workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
-- 	window:gui_window():set_right_status(wezterm.format({
-- 		{ Attribute = { Intensity = "Bold" } },
-- 	}))
--
-- 	local workspace_state = resurrect.workspace_state
--
-- 	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
-- 		-- window = window,
-- 		relative = true,
-- 		restore_text = true,
-- 		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
-- 	})
-- end)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	wezterm.log_info(window)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
	}))
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	wezterm.log_info(window)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
	resurrect.write_current_state(label, "workspace")
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.start", function(window, _)
	wezterm.log_info(window)
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.canceled", function(window, _)
	wezterm.log_info(window)
end)

-- Also saves the workspaces state every 15 minutes
resurrect.periodic_save({ interval_seconds = 15 * 60, save_workspaces = true, save_windows = false, save_tabs = true })

-- keymaps
config.keys = {
	{
		key = "t",
		mods = "CMD|SHIFT",
		action = act.ShowTabNavigator,
	},
	{
		key = "r",
		mods = "CMD|CTRL|SHIFT",
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
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					window = win,
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.load_state(id, "workspace")
					-- create new workspace with previous name
					-- win:perform_action(
					-- 	wezterm.action.SwitchToWorkspace({
					-- 		name = state.workspace,
					-- 	}),
					-- 	pane
					-- )
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id)
				resurrect.delete_state(id)
			end, {
				title = "Delete State",
				description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Search State to Delete: ",
				is_fuzzy = true,
			})
		end),
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
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			-- resurrect.window_state.save_window_action()
		end),
	},
	-- other keys
}

workspace_switcher.apply_to_config(config)

wezterm.on("gui-startup", function(cmd)
	local _tab, _pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
	-- resurrect.resurrect_on_gui_startup(window)
	resurrect.set_max_nlines(2000)
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
