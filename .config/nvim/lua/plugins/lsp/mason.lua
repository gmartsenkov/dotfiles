return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	opts = {
		ensure_installed = { "lua-language-server", "stylua", "rust-analyzer", "tailwindcss-language-server" },
		PATH = "prepend",

		ui = {
			icons = {
				package_pending = " ",
				package_installed = "󰄳 ",
				package_uninstalled = " 󰚌",
			},

			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},

		max_concurrent_installers = 10,
	},
	config = function(_, opts)
		require("mason").setup(opts)

		-- custom nvchad cmd to install all mason binaries listed
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
		end, {})

		vim.g.mason_binaries_list = opts.ensure_installed
	end,
}
