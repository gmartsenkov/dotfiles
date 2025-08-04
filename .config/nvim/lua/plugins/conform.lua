return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters = {
			cljfmt = {
				command = "cljfmt",
				args = { "fix" },
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			ruby = { "rubocop" },
			rust = { "rustfmt" },
			clojure = { "cljstyle" },
			elixir = { "mix" },
			gleam = { "gleam" },
			go = { "gofmt" },
			javascript = { { "prettierd", "prettier" } },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.lua", "*.rs", "*.clj", "*.cljs", "*.edn", "*.gleam", "*.go" },
			callback = function(args)
				require("conform").format({ bufnr = args.buf, quiet = true })
			end,
		})
	end,
}
