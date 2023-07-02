return (function(plugins)
	local paq_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
	local paq_boostrap = not vim.loop.fs_stat(paq_path)
	if paq_boostrap then
		vim.fn.system({
			"git", "clone", "--depth=1",
			"https://github.com/savq/paq-nvim", paq_path
		})
		vim.cmd.packadd("paq-nvim")
	end

	local paq = require("paq")(plugins)

	-- NOTE: Usually finishes after init.lua, so it requires a restart
	if paq_boostrap then
		paq:install()
	end
end)
