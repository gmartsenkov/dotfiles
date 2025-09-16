return {
	"oribarilan/lensline.nvim",
	tag = "1.1.2", -- or: branch = 'release/1.x' for latest non-breaking updates
	event = "LspAttach",
	opts = {
		providers = { -- Array format: order determines display sequence
			{
				name = "last_author",
				enabled = true, -- enabled by default with caching optimization
				cache_max_files = 1000, -- maximum number of files to cache blame data for (default: 50)
			},
		},
	},
	config = true,
}
