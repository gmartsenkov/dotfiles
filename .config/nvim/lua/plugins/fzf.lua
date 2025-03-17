return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		command = "FzfLua",
		config = function()
			require("fzf-lua").setup({
				winopts = {
					row = 0.1,
					height = 0.5,
					width = 0.7,
					preview = {
						layout = "vertical",
						hidden = "hidden",
					},
				},
			})
		end,
	},
}
