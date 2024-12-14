local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {
	font_size = 16.0,
}

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

return config
