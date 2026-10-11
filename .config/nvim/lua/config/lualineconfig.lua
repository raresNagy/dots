-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

-- Color utility to get hex color values from highlight groups
local function get_hl_color(group, field)
	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	if hl and hl[field] then
		-- Convert integer RGB to hex string (#RRGGBB)
		return string.format("#%06x", hl[field])
	end
	return nil
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = "auto",
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	-- mode component
	function()
		return "󰄛"
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = get_hl_color("DiffDelete", "fg"),
			i = get_hl_color("DiffAdd", "fg"),
			v = get_hl_color("WarningMsg", "fg"),
			[""] = get_hl_color("WarningMsg", "fg"),
			V = get_hl_color("WarningMsg", "fg"),
			c = get_hl_color("Function", "fg"),
			no = get_hl_color("DiffDelete", "fg"),
			s = get_hl_color("DiffAdd", "fg"),
			S = get_hl_color("DiffAdd", "fg"),
			[""] = get_hl_color("DiffAdd", "fg"),
			ic = get_hl_color("WarningMsg", "fg"),
			R = get_hl_color("Identifier", "fg"),
			Rv = get_hl_color("Identifier", "fg"),
			cv = get_hl_color("DiffDelete", "fg"),
			ce = get_hl_color("DiffDelete", "fg"),
			r = get_hl_color("Special", "fg"),
			rm = get_hl_color("Special", "fg"),
			["r?"] = get_hl_color("Special", "fg"),
			["!"] = get_hl_color("DiffDelete", "fg"),
			t = get_hl_color("DiffDelete", "fg"),
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1, left = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = get_hl_color("Function", "fg"), gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = get_hl_color("Normal", "fg"), gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = get_hl_color("DiffDelete", "fg") },
		warn = { fg = get_hl_color("WarningMsg", "fg") },
		info = { fg = get_hl_color("Special", "fg") },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

-- Add components to right sections
ins_right({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = get_hl_color("Normal", "fg"), gui = "bold" },
})
ins_right({
	"branch",
	icon = "",
	color = { fg = get_hl_color("Identifier", "fg"), gui = "bold" },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = get_hl_color("DiffAdd", "fg") },
		modified = { fg = get_hl_color("DiffChange", "fg") },
		removed = { fg = get_hl_color("DiffDelete", "fg") },
	},
	cond = conditions.hide_in_width,
})

return config
