return {
	"mfussenegger/nvim-lint",
	ft = { "ruby" },
	config = function()
		require("lint").linters_by_ft = {
			ruby = { "rubocop" },
		}
		require("lint").linters.rubocop.cmd = "bundle"
		require("lint").linters.rubocop.args = {
			"exec",
			"rubocop",
			"--format",
			"json",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
