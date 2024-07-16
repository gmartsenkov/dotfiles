function _G.set_clojure_keymaps()
	local opts = { buffer = 0 }
	local map = vim.keymap.set
	map("n", "<leader>tv", function()
		vim.cmd("ConjureCljRefreshChanged")
		-- vim.cmd("ConjureEvalBuf")
		vim.cmd("ConjureCljRunCurrentNsTests")
	end, opts)
	map("n", "<leader>tc", function()
		vim.cmd("ConjureCljRefreshChanged")
		-- vim.cmd("ConjureEvalBuf")
		vim.cmd("ConjureCljRunCurrentTest")
	end, opts)
	map("n", "<leader>ta", function()
		vim.cmd("ConjureCljRefreshChanged")
		-- vim.cmd("ConjureCljRefreshAll")
		vim.cmd("ConjureCljRunAllTests")
	end, opts)
	map("n", "gd", "<cmd> ConjureDefWord <CR>", opts)
end

vim.cmd("autocmd! Filetype clojure lua set_clojure_keymaps()")
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
			vim.g["conjure#highlight#enabled"] = true
			vim.g["conjure#highlight#group"] = "Search"
		end,
	},
}
