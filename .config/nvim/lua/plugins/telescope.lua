return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		command = "FzfLua",
		config = function()
			-- calling `setup` is optional for customization
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
