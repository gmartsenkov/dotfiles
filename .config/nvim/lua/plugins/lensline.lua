return {
	"oribarilan/lensline.nvim",
	tag = "2.0.0",
	event = "LspAttach",
	opts = {
		profiles = {
			{
				name = "minimal",
				style = {
					placement = "inline",
					prefix = "",
					-- render = "focused", optionally render lenses only for focused function
				},
			},
		},
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
