return {
	"MeanderingProgrammer/dashboard.nvim",
	event = "VimEnter",
	dependencies = {
		{ "MaximilianLloyd/ascii.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	},
	config = function()
		require("dashboard").setup({
			header = require("ascii").art.text.neovim.def_leppard,
			directories = {
				"~/Development/uplisting-api",
				"~/Development/peek",
				"~/Development/fusion-api",
				"~/dotfiles",
			},
		})
	end,
}
