require "nvchad.autocmds"

-- Filetype detection and settings for template files (Go templates, generic templ files)
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = {"*.tmpl","*.gotmpl"},
	callback = function()
		-- Go templates: set filetype that gopls recognizes
		vim.bo.filetype = "gotmpl"
		-- enable HTML syntax highlighting as a fallback
		vim.cmd([[ setlocal syntax=html ]])
	end,
})

vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = {"*.templ"},
	callback = function()
		-- generic templ files (as in your lspconfig)
		vim.bo.filetype = "templ"
		vim.cmd([[ setlocal syntax=html ]])
	end,
})
