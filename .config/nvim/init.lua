--          _
--  ___ _ _|_|_____ ___ ___
-- |   | | | |     |  _|  _|
-- |_|_|\_/|_|_|_|_|_| |___|
--
-- This is ale's ~/.config/nvim/init.lua

::Plugins::

require("plugins")({
	"savq/paq-nvim",
	"ethanholz/nvim-lastplace",
	"windwp/nvim-autopairs",
	"tpope/vim-sleuth",

	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",

	"rebelot/kanagawa.nvim"
})

require("nvim-lastplace").setup({})
require("nvim-autopairs").setup({})

vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
	callback = function()
		vim.b.sleuth_defaults = "noexpandtab tabstop=3 shiftwidth=3"
		if vim.bo.filetype and not vim.b.sleuth then
			vim.cmd("silent Sleuth")
		end
	end
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort()
	}),
	sources = cmp.config.sources({
		{name = "buffer"}
	})
})

::Options::

-- See `:h vim-differences`
vim.opt.number = true
vim.opt.confirm = true
vim.opt.scrolloff = 3
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse = {n = true, v = true, c = true}
vim.opt.mousemodel = "extend"
vim.opt.list = true
vim.opt.listchars = {tab = "┊ ", nbsp = "⎵", extends = "»", precedes = "«"}
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spelllang = {"en", "it"}

::Theme::

vim.opt.termguicolors = true
vim.cmd.colorscheme("kanagawa-dragon")
vim.opt.statuscolumn = "%s %=%l%C %#Normal# "

-- NOTE: Works correctly when DiffDelete has a noticeable bg color (see `:highlight`)
vim.api.nvim_create_autocmd({"InsertEnter", "InsertLeave", "BufWinEnter"}, {
	command = "match DiffDelete /\\s\\+$/"
})
