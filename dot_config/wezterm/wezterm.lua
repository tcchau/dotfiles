-- wezterm.lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("wuake").setup({
	config = config,
	create_unix_domain = true,
})

return config
