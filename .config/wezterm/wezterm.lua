local wezterm = require("wezterm")
local keys = require("key")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = false
config.color_scheme = "Catppuccin Mocha"
config.font_size = 16
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
-- config.font = wezterm.font("Victor Mono", { weight = "DemiBold" })
-- config.font = wezterm.font("Sarasa Fixed CL Nerd Font", { weight = "Medium" })
-- config.font = wezterm.font("Iosevka NFM", { weight = "Medium" })
-- config.font = wezterm.font("UbuntuMono Nerd Font Mono", { weight = "Medium" })
-- config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })

-- let(:teammate) { Teammate.new account: teammate_account }
config.cell_width = 0.95
config.line_height = 1.0

config.window_decorations = "RESIZE"
config.initial_rows = 40
config.initial_cols = 150

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 50

config.keys = keys
config.window_padding = {
	left = 10,
	right = 0,
	top = 10,
	bottom = 0,
}

return config
