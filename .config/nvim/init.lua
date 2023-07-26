--          _
--  ___ _ _|_|_____ ___ ___
-- |   | | | |     |  _|  _|
-- |_|_|\_/|_|_|_|_|_| |___|
--
-- This is ale's ~/.config/nvim/init.lua

::Plugins::

vim.g.mapleader = "\\"

require("plugins")({
	"savq/paq-nvim",
	"ethanholz/nvim-lastplace",
	"windwp/nvim-autopairs",
	"tamton-aquib/duck.nvim",

	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",

	"rebelot/kanagawa.nvim"
})

require("nvim-lastplace").setup({})
require("nvim-autopairs").setup({})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort()
	}),
	sources = cmp.config.sources({
		{name = "buffer"}
	})
})

local ducks = {
	{"🦆", 8}, {"🪿", 14},
	{"🐖", 6}, {"🦌", 10},
	{"🐤", 6}, {"🐢", 3},
	{"🦀", 6}, {"🦉", 4}
}
vim.keymap.set("n", "<leader>dd", function()
	math.randomseed(os.time())
	local duck = ducks[math.random(#ducks)]
	require("duck").hatch(duck[1], duck[2])
end)
vim.keymap.set("n", "<leader>dk", function()
	local module = require("duck")
	for i = 1,#module.ducks_list do
		module.cook()
	end
end)

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

::Indentation::

require("indent")({
	defaults = {
		expandtab = false,
		tabstop = 3,
		shiftwidth = 3
	}
})

::Theme::

vim.opt.termguicolors = true
vim.cmd.colorscheme("kanagawa-dragon")
vim.opt.statuscolumn = "%s %=%l%C %#Normal# "

-- NOTE: Works correctly when DiffDelete has a noticeable bg color (see `:highlight`)
vim.api.nvim_create_autocmd({"InsertEnter", "InsertLeave", "BufWinEnter"}, {
	command = "match DiffDelete /\\s\\+$/"
})
