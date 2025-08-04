vim.lsp.config["tailwindcss"] = {
	cmd = { "tailwindcss-language-server" },
	filetypes = { "typescript", "html", "javascript", "gleam" },
	root_markers = { "tailwind.config.js" },
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					[[class= "([^"]*)]],
					[[class: "([^"]*)]],
					[[attribute.class\("(.*)"\)]],
					'~H""".*class="([^"]*)".*"""',
					':class "([^"]*)"',
				},
			},
		},
	},
}

vim.lsp.config["gleam"] = {
	cmd = { "gleam", "lsp" },
	filetypes = { "gleam" },
	root_markers = { "gleam.toml" },
}

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go" },
	root_markers = { "go.mod" },
}

vim.lsp.config["solargraph"] = {
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile" },
}

vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
}

vim.lsp.enable("tailwindcss")
vim.lsp.enable("luals")
vim.lsp.enable("solargraph")
vim.lsp.enable("gleam")
vim.lsp.enable("gopls")

return {}
