return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		lazy = false,
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					preview = false,
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
						width = 0.5,
						height = 0.5,
					},
					mappings = {
						["i"] = {
							["<esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-a>"] = { "<home>", type = "command" },
							["<C-e>"] = { "<end>", type = "command" },
						},
					},
				},
				extensions = {
					file_browser = {
						hidden = { file_browser = true, folder_browser = true },
						no_ignore = true,
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						hide_parent_dir = true,
						mappings = {
							["i"] = {
								["<tab>"] = actions.select_default,
							},
							["n"] = {},
						},
					},
				},
			})
			-- To get telescope-file-browser loaded and working with telescope,
			-- you need to call load_extension, somewhere after setup function:
			require("telescope").load_extension("file_browser")
		end,
	},
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
