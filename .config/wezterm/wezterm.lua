local wezterm = require("wezterm")
local keys = require("key")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { "zsh" }
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = false
config.color_scheme = "Catppuccin Mocha"
config.font_size = 18
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
-- config.font = wezterm.font("Victor Mono", { weight = "DemiBold" })
-- config.font = wezterm.font("Sarasa Fixed CL Nerd Font", { weight = "Medium" })
-- config.font = wezterm.font("Iosevka NFM", { weight = "Medium" })
-- config.font = wezterm.font("UbuntuMono Nerd Font Mono", { weight = "Medium" })
-- config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })

-- let(:teammate) { Teammate.new account: teammate_account }
config.cell_width = 0.95
config.line_height = 1.0

config.window_decorations = "TITLE | RESIZE"
config.initial_rows = 40
config.initial_cols = 150

config.show_tabs_in_tab_bar = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 50

config.keys = keys
config.window_padding = {
	left = 20,
	right = 20,
	top = 30,
	bottom = 10,
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 30
config.colors = {
	background = "#000000",
}

return config
