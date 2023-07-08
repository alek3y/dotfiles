local config_default = {
	editorconfig = true,
	defaults = {
		expandtab = false,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 0
	},
	exclude = {
		filetype = {
			"netrw",
			"tutor"
		},
		buftype = {
			"help",
			"nofile",
			"terminal",
			"prompt"
		}
	}
}

local function config_get(config, keys)
	config = config or {}
	local default = config_default
	local fallback = false

	for _, key in ipairs(keys) do
		local has_key = false
		for k, _ in pairs(config) do
			if k == key then
				has_key = true
				break
			end
		end

		if not fallback and not has_key then
			config = default
			fallback = true
		end

		config = config[key]
		default = default[key]
	end

	return config
end

local function buffer_ignore(bufnr, config)
	if config_get(config, {"editorconfig"}) then
		local editorconfig = vim.b[bufnr].editorconfig
		if editorconfig and (
			editorconfig.indent_style or
			editorconfig.indent_size or
			editorconfig.tab_width
		) then
			return true
		end
	end

	for _, name in ipairs({"buftype", "filetype"}) do
		for _, value in ipairs(config_get(config, {"exclude", name})) do
			if value == vim.bo[bufnr][name] then
				return true
			end
		end
	end

	return false
end

-- See nvim's vim.inspect_pos() at runtime/lua/vim/_inspector.lua
local function buffer_highlightings(bufnr, row, col)
	links = {}
	vim.api.nvim_buf_call(bufnr, function()
		for _, i in ipairs(vim.fn.synstack(row + 1, col + 1)) do
			local group = vim.fn.synIDattr(i, "name")
			local id = vim.api.nvim_get_hl_id_by_name(group)
			local link = vim.fn.synIDattr(vim.fn.synIDtrans(id), "name")
			table.insert(links, link)
		end
	end)
	return links
end

local function detect(bufnr)
	local batch_size = 64
	local batch_count = 16

	local spaces = {
		count = 0,
		widths = {},
		stack = {0}
	}
	local tabs = 0

	for batch_start = 0, batch_size * batch_count, batch_size do
		local lines = vim.api.nvim_buf_get_lines(bufnr, batch_start, batch_start + batch_size, false)

		for i, line in ipairs(lines) do
			local ignore_line = false
			local highlightings = buffer_highlightings(bufnr, batch_start + i-1, 0)

			for _, name in ipairs(highlightings) do
				name = name:lower()
				if name == "comment" or name == "string" then
					ignore_line = true
					break
				end
			end
			ignore_line = ignore_line or not line:find("[^%s]")

			if not ignore_line then
				local spaces_chars = 0
				local tabs_chars = 0
				local too_long = false

				for j = 1, #line do
					local char = line:sub(j, j)
					if char == "\t" then
						tabs_chars = tabs_chars + 1
					elseif char == " " then
						spaces_chars = spaces_chars + 1
					else
						break
					end

					if tabs_chars + spaces_chars > 70 then
						too_long = true
						break
					end
				end

				if not too_long then
					if tabs_chars ~= 0 and spaces_chars == 0 then
						tabs = tabs + 1
					elseif tabs_chars == 0 and spaces_chars ~= 0 then
						while spaces.stack[#spaces.stack] > spaces_chars do
							table.remove(spaces.stack)
						end

						if spaces.stack[#spaces.stack] < spaces_chars then
							table.insert(spaces.stack, spaces_chars)
						end

						local parent_width = spaces.stack[#spaces.stack - 1]
						local width = spaces_chars - parent_width
						spaces.widths[width] = (spaces.widths[width] or 0) + 1
						spaces.count = spaces.count + 1
					elseif table_chars == 0 and spaces_chars == 0 then
						spaces.stack = {0}
					end
				end
			end
		end

		if math.abs(tabs - spaces.count) > 128 then
			break
		end
	end

	if tabs > spaces.count and tabs > 0 then
		return {
			expandtab = false
		}
	elseif spaces.count > 0 then
		local likely_width = nil
		local likely_count = -1

		for width, count in pairs(spaces.widths) do
			if count > likely_count then
				likely_width = width
				likely_count = count
			end
		end

		if likely_count >= spaces.count/3 then
			return {
				expandtab = true,
				tabstop = likely_width,
				shiftwidth = likely_width
			}
		end
	end

	return {}
end

local function apply(bufnr, config)
	if vim.b[bufnr].indent_applied or buffer_ignore(bufnr, config) then
		return false
	end

	local applied = config_get(config, {"defaults"})
	for option, value in pairs(applied) do
		vim.bo[bufnr][option] = value
	end

	for option, value in pairs(detect(bufnr)) do
		vim.bo[bufnr][option] = value
		applied[option] = value
	end

	vim.b[bufnr].indent_applied = applied
	return true
end

return (function(config)
	local group = vim.api.nvim_create_augroup("Indent", {clear = true})

	vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
		group = group,
		callback = function(auargs)
			if auargs.event == "FileType" then
				vim.b[auargs.buf].indent_applied = nil	-- Overwrites ftplugin defaults on 'filetype' option changes
			end
			apply(auargs.buf, config)
		end
	})

	-- Overwrites config defaults once on new file write
	vim.api.nvim_create_autocmd("BufNewFile", {
		group = group,
		callback = function(auargs)
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = group,
				buffer = auargs.buf,
				callback = function()
					vim.b[auargs.buf].indent_applied = nil
					apply(auargs.buf, config)
					return true	-- Prevents further triggers
				end
			})
		end
	})
end)
