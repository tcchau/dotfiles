local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {
	font_size = 16.0,
}

wezterm.on("gui-startup", function(cmd)
	local _tab, _pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
	local frontend_tab, frontend_pane = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/Frontend" })
	frontend_tab:set_title("frontend/docker")
	frontend_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = "/Users/clinton/pcode/repos/Dockerization",
	})
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
		cwd = "/Users/clinton/pcode/repos/Dockerization",
	})
	local aws_scripts_tab, aws_scripts_pane = window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/aws-scripts" })
	aws_scripts_tab:set_title("aws-scripts/content-meta")
	aws_scripts_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = "/Users/clinton/pcode/repos/ContentMeta",
	})
	local mypeekaville_tab, mypeekaville_pane =
		window:spawn_tab({ cwd = "/Users/clinton/pcode/repos/mypeekaville.com/" })
	mypeekaville_tab:set_title("mypeekaville")
	mypeekaville_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = "/Users/clinton/pcode/repos/MyPeekavilleUnity-github-lfs",
	})
end)

return config
