local map = vim.keymap.set

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "<C-a>", "<Home>", { silent = false })
map("i", "<C-e>", "<End>", { silent = false })

map("c", "<C-a>", "<Home>", { silent = false })
map("c", "<C-e>", "<End>", { silent = false })

map("n", "<leader>wo", "<cmd> only <CR>")
map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

map("n", "<leader><leader>", function()
	require("snacks").picker.files()
end)
map("n", "<leader>ff", "<cmd> Telescope file_browser path=%:p:h select_buffer=true <CR>")
map("n", "<leader>mf", function()
	require("conform").format()
end)

map("n", "<C-n>", "<cmd> NvimTreeFindFile <CR>")
map("n", "<leader>bb", function()
	require("snacks").picker.buffers()
end)
map("n", "<leader>bd", function()
	vim.api.nvim_buf_delete(0, { force = true })
end)
map("n", "<leader>bn", "<cmd> enew <CR>")
map("n", "<leader>/", function()
	require("snacks").picker.grep()
end)

-- Testing
map("n", "<leader>tt", function()
	require("gotospec").jump(require("nvim-rooter").get_root())
end)
map("n", "<leader>tv", "<cmd> TestFile <CR>")
map("n", "<leader>tf", "<cmd> TestLast --only-failures<CR>")
map("n", "<leader>tF", "<cmd> TestSuite --only-failures<CR>")
map("n", "<leader>ta", "<cmd> TestSuite <CR>")
map("n", "<leader>tc", "<cmd> TestNearest <CR>")
map("n", "<leader>tl", "<cmd> TestLast <CR>")
map("n", "<leader>tg", "<cmd> TestVisit <CR>")
--

-- Conjure
map("n", "<leader>eb", "<cmd> ConjureEvalBuf <CR>")
map("n", "<leader>er", "<cmd> ConjureEvalRootForm <CR>")
map("n", "<leader>ee", "<cmd> ConjureEvalCurrentFor <CR>")

map("n", "<Esc>", function()
	vim.cmd("noh")
	local terminals = require("toggleterm.terminal").get_all()
	for _, term in ipairs(terminals) do
		if vim.api.nvim_win_is_valid(term.window) then
			vim.api.nvim_win_close(term.window, true)
		end
	end
end)
map("n", "<leader>mp", function()
	local terminals = require("toggleterm.terminal").get_all()
	for _, term in ipairs(terminals) do
		if vim.api.nvim_win_is_valid(term.window) then
			vim.api.nvim_win_close(term.window, true)
		end
	end
	vim.cmd("TermExec cmd='bundle exec rubocop'")
end)

-- LSP
map("n", "gs", function()
	require("snacks").picker.lsp_symbols()
end, { silent = true })
map("n", "gS", function()
	require("snacks").picker.lsp_symbols({ workspace = true })
end, { silent = true })
map("n", "gd", function()
	require("snacks").picker.lsp_definitions()
end, { silent = true })
map("n", "gr", function()
	require("snacks").picker.lsp_references()
end, { silent = true })
map("n", "<leader>cc", function()
	require("snacks").picker.files({ cwd = vim.fn.expand("~/dotfiles/.config/nvim") })
end)
map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
map("n", "<leader>cR", function()
	vim.lsp.buf.rename()
end)
-- Git
map("n", "<leader>gg", "<cmd> Neogit <CR>")
map("n", "<leader>gp", "<cmd> Git pull <CR>")
map("n", "<leader>gP", "<cmd> Git push <CR>")
map("n", "<leader>gb", function()
	require("snacks").gitbrowse()
end)

-- Navigation
map("n", "<leader>wv", "<cmd> vsplit <CR>")
map("n", "<leader>wh", "<cmd> split <CR>")
map("n", "<leader>wd", "<cmd> close <CR>")
map("n", "<leader>qq", "<cmd> qa <CR>")
map("n", "[h", "<cmd> Gitsigns prev_hunk <CR>")
map("n", "]h", "<cmd> Gitsigns next_hunk <CR>")
map("n", "<leader>d", function()
	require("snacks").picker.diagnostics()
end)
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = false })
end)
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = false })
end)

map("n", "<leader>r", function()
	require("snacks").picker.resume()
end)
-- Tabs
map("n", "<leader><tab>1", "<cmd> tabnext 1 <CR>")
map("n", "<leader><tab>2", "<cmd> tabnext 2 <CR>")
map("n", "<leader><tab>3", "<cmd> tabnext 3 <CR>")
map("n", "<leader><tab>4", "<cmd> tabnext 4 <CR>")
map("n", "<leader><tab>5", "<cmd> tabnext 5 <CR>")
map("n", "<leader><tab>n", "<cmd> tabnew <CR>")
map("n", "<leader><tab>d", "<cmd> tabclose <CR>")

-- Fix weird indentation issues in ruby with treesitter enabled
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "ruby" },
	callback = function()
		vim.opt_local.indentkeys:remove(".")
	end,
})
