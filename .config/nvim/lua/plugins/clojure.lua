return {
	{
		"tpope/vim-sexp-mappings-for-regular-people",
		ft = { "fennel", "clojure" },
		dependencies = {
			{
				"guns/vim-sexp",
				ft = { "clojure" },
				config = function()
					vim.g.sexp_enable_insert_mode_mappings = 0
					vim.g.sexp_filetypes = "clojure,fennel"
				end,
			},
		},
	},
	{
		"Olical/conjure",
		ft = { "clojure" },
		config = function()
			vim.g["conjure#log#wrap"] = true
			vim.g["conjure#log#hud#enabled"] = false
		end,
	},
}
