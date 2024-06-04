local opts = function()
	local actions = require("telescope.actions")

	return {
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
		extensions_list = { "themes", "terms" },
	}
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	opts = opts,
}
