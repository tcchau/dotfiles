-- File: resurrect/events.lua
-- resurrect.wezterm event listener configuration
--
-- This module configures event listeners for the resurrect.wezterm plugin.

local wezterm = require("wezterm")
local suppress_notification = false

wezterm.on("resurrect.error", function(error)
	wezterm.gui.gui_windows()[1]:toast_notification("Wezterm - resurrect Error", error, nil, 4000)
end)

wezterm.on("resurrect.periodic_save", function()
	suppress_notification = true
end)

wezterm.on("resurrect.save_state.finished", function(session_path)
	local is_workspace_save = session_path:find("state/workspace")

	if is_workspace_save == nil then
		return
	end

	if suppress_notification then
		suppress_notification = false
		return
	end

	local path = session_path:match(".+/([^+]+)$")
	local name = path:match("^(.+)%.json$")
	wezterm.gui
		.gui_windows()[1]
		:toast_notification("Wezterm - Save workspace", "Saved workspace " .. name .. "\n\n" .. session_path, nil, 4000)
end)

wezterm.on("resurrect.load_state.finished", function(name, type)
	local msg = "Completed loading " .. type .. " state: " .. name
	wezterm.gui.gui_windows()[1]:toast_notification("Wezterm - Resore workspace", msg, nil, 4000)
end)
