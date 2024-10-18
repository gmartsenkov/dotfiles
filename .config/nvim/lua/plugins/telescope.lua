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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = false,
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-n>"] = require("telescope.actions").cycle_history_next,
							["<C-p>"] = require("telescope.actions").cycle_history_prev,
							["<C-a>"] = { "<home>", type = "command" },
							["<C-e>"] = { "<end>", type = "command" },
						},
					},
					file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" },
				},
				extensions = {
					fzf = {
						fuzzy = false, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("fzf")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
